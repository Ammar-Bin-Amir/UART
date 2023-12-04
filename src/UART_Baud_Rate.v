module uart_baud_rate (
    input wire clk,
    input wire rst,
    input wire [31:0] baud_division,
    input wire en,
    output reg baud_tick
);

    /*
    Clock Frequency: f  = 20 MHz
    Baud Rate:       Bd = 9600 bit/s
    
    Baud Division = ____f____
                     16 x Bd
    */

    reg temp_en;
    reg delayed_en;

    always @(posedge clk) begin
        if (rst) begin
            temp_en <= 0;
            delayed_en <= 0;
        end
        else begin
            if ((en == 0) || (en == 1)) begin
                temp_en <= en;
                delayed_en <= temp_en;
            end
            else begin
                temp_en <= temp_en;
                delayed_en <= delayed_en;
            end
        end
    end
    
    reg [31:0] baud_count;

    always @(posedge clk) begin
        if (rst) begin
            baud_count <= 0;
            baud_tick <= 0;
        end
        else begin
            if (baud_division != 0) begin
                if ((en == 1) && (delayed_en == 0)) begin
                    baud_count <= 1;
                    baud_tick <= baud_tick;
                end
                else if (baud_count == baud_division) begin
                    baud_count <= 0;
                    baud_tick <= 1;
                end
                else begin
                    baud_count <= baud_count + 1;
                    baud_tick <= 0;
                end
            end
            else begin
                baud_count <= 0;
                baud_tick <= 0;
            end
        end
    end
    
endmodule