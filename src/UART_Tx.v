module uart_tx (
    input wire clk,
    input wire rst,
    input wire baud_tick,
    input wire [7:0] ext_data_in,
    input wire en,
    output reg tx
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
                if (current_state != IDLE) begin
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
                        data_save <= data_save;
                    end
                    else begin
                        count_8 <= count_8 + 1;
                        count_8_indication <= 0;
                        data_save <= {data_save[6:0],1'b0};
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
                data_save <= ext_data_in;
            end
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
                    tx = 1;
                    if (en == 1) begin
                        next_state = START;
                    end
                end
                START: begin
                    tx = 0;
                    if (count_16_indication == 1) begin
                        next_state = DATA;
                    end
                end
                DATA: begin
                    tx = data_save[7];
                    if (count_8_indication == 1) begin
                        next_state = STOP;
                    end
                end
                STOP: begin
                    tx = 1;
                    if (count_16_indication == 1) begin
                        next_state = IDLE;
                    end
                end
                default: next_state = IDLE;
            endcase
        end
    end

endmodule