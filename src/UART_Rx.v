module uart_rx (
    input clk,
    input rst,
    input baud_tick,
    input rx,
    output reg [7:0] ext_data_out
);
    
    reg [3:0] count_16;
    reg count_16_indication;

    always @(posedge clk) begin
        if (rst) begin
            count_16 <= 0;
            count_16_indication <= 0;
        end
        else begin
            if (baud_tick == 1) begin
                if (current_state == START) begin
                    if (count_16 == 7) begin
                        count_16 <= 0;
                        count_16_indication <= 1;
                    end
                    else begin
                        count_16 <= count_16 + 1;
                        count_16_indication <= 0;
                    end
                end
                else if ((current_state == DATA) || (current_state == STOP)) begin
                    if (count_16 == 15) begin
                        count_16 <= 0;
                        count_16_indication <= 1;
                    end
                    else begin
                        count_16 <= count_16 + 1;
                        count_16_indication <= 0;
                    end
                end
                else begin
                    count_16 <= 0;
                    count_16_indication <= 0;
                end
            end
            else begin
                count_16 <= count_16;
                count_16_indication <= 0;
            end
        end
    end

    reg [2:0] count_8;
    reg count_8_indication;
    reg [7:0] data_save;

    always @(posedge clk) begin
        if (rst) begin
            count_8 <= 0;
            count_8_indication <= 0;
            data_save <= 0;
        end
        else begin
            if (current_state == DATA) begin
                if ((baud_tick == 1) && (count_16 == 15)) begin
                    if (count_8 == 7) begin
                        count_8 <= 0;
                        count_8_indication <= 1;
                        data_save <= {data_save[6:0],rx};
                    end
                    else begin
                        count_8 <= count_8 + 1;
                        count_8_indication <= 0;
                        data_save <= {data_save[6:0],rx};
                    end
                end
                else begin
                    count_8 <= count_8;
                    count_8_indication <= 0;
                    data_save <= data_save;
                end
            end
            else begin
                count_8 <= 0;
                count_8_indication <= 0;
                data_save <= data_save;
            end
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            ext_data_out <= 0;
        end
        else begin
            ext_data_out <= data_save;
        end
    end

    // Finite State Machine

    localparam IDLE = 0;
    localparam START = 1;
    localparam DATA = 2;
    localparam STOP = 3;

    reg [1:0] current_state, next_state;

    always @(posedge clk) begin
        if (rst) begin
            current_state <= 0;
        end
        else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        if (rst) begin
            next_state = 0;
        end
        else begin
            case (current_state)
                IDLE: begin
                    if (rx == 0) begin
                        next_state = START;
                    end
                end
                START: begin
                    if ((count_16_indication == 1) && (rx == 0)) begin
                        next_state = DATA;
                    end
                end
                DATA: begin
                    if (count_8_indication == 1) begin
                        next_state = STOP;
                    end
                end
                STOP: begin
                    if ((count_16_indication == 1) && (rx == 1)) begin
                        next_state = IDLE;
                    end
                end
                default: next_state = IDLE;
            endcase
        end
    end

endmodule