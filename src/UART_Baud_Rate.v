module uart_baud_rate (
    input clk,
    input rst,
    input [31:0] baud_division,
    output reg baud_tick
);
    
    reg [31:0] baud_count = 0;

    always @(posedge clk) begin
        if (rst) begin
            baud_count <= 0;
            baud_tick <= 0;
        end
        else begin
            if (baud_division != 0) begin
                if (baud_count == baud_division) begin
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