module uart_rx (
    input clk,
    input rst,
    input baud_tick,
    input rx,
    output reg [7:0] data
);
    
    // localparam CLOCK_FREQUENCY = 20000000;      // 20 MHz Clock
    // localparam BAUD_RATE = 9600;
    // localparam BAUD_DIVISION = (CLOCK_FREQUENCY / (16 * BAUD_RATE));
    
    // reg [7:0] baud_count = 0;
    // reg baud_tick = 0;

    // always @(posedge clk) begin
    //     if (rst) begin
    //         baud_count <= 0;
    //         baud_tick <= 0;
    //     end
    //     else begin
    //         if (baud_count == BAUD_DIVISION) begin
    //             baud_count <= 0;
    //             baud_tick <= 1;
    //         end
    //         else begin
    //             baud_count <= baud_count + 1;
    //             baud_tick <= 0;
    //         end
    //     end
    // end

    localparam IDLE = 4'b0000;
    localparam START = 4'b0001;
    localparam DATA_BIT_0 = 4'b0010;
    localparam DATA_BIT_1 = 4'b0011;
    localparam DATA_BIT_2 = 4'b0100;
    localparam DATA_BIT_3 = 4'b0101;
    localparam DATA_BIT_4 = 4'b0110;
    localparam DATA_BIT_5 = 4'b0111;
    localparam DATA_BIT_6 = 4'b1000;
    localparam DATA_BIT_7 = 4'b1001;
    localparam STOP = 4'b1010;

    reg [3:0] current_state, next_state;

    always @(posedge clk) begin
        if (rst) begin
            current_state <= IDLE;
            data <= 0;
        end
        else begin
            current_state <= next_state;
        end
    end

    reg [4:0] count_16 = 0;

    always @(*) begin
        case (current_state)
            IDLE: begin
                if (rx == 0) begin
                    next_state = START;
                end
            end
            START: begin
                if (baud_tick) begin
                    if (count_16 == 8) begin
                        count_16 = 0;
                        next_state = DATA_BIT_0;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_0: begin
                if (baud_tick) begin
                    if (count_16 == 16) begin
                        data[0] = rx;
                        count_16 = 0;
                        next_state = DATA_BIT_1;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_1: begin
                if (baud_tick) begin
                    if (count_16 == 16) begin
                        data[1] = rx;
                        count_16 = 0;
                        next_state = DATA_BIT_2;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_2: begin
                if (baud_tick) begin
                    if (count_16 == 16) begin
                        data[2] = rx;
                        count_16 = 0;
                        next_state = DATA_BIT_3;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_3: begin
                if (baud_tick) begin
                    if (count_16 == 16) begin
                        data[3] = rx;
                        count_16 = 0;
                        next_state = DATA_BIT_4;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_4: begin
                if (baud_tick) begin
                    if (count_16 == 16) begin
                        data[4] = rx;
                        count_16 = 0;
                        next_state = DATA_BIT_5;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_5: begin
                if (baud_tick) begin
                    if (count_16 == 16) begin
                        data[5] = rx;
                        count_16 = 0;
                        next_state = DATA_BIT_6;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_6: begin
                if (baud_tick) begin
                    if (count_16 == 16) begin
                        data[6] = rx;
                        count_16 = 0;
                        next_state = DATA_BIT_7;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            DATA_BIT_7: begin
                if (baud_tick) begin
                    if (count_16 == 16) begin
                        data[7] = rx;
                        count_16 = 0;
                        next_state = STOP;
                    end
                    else begin
                        count_16 = count_16 + 1;
                    end
                end
            end
            STOP: begin
                if (rx == 1) begin
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule