`timescale 1ns/1ns

module uart_baud_rate_tb;
    
    reg clk,rst;
    reg [31:0] baud_division;
    wire baud_tick;

    uart_baud_rate uut(clk,rst,baud_division,baud_tick);

    initial begin
        $dumpfile("./temp/UART_Baud_Rate_tb.vcd");
        $dumpvars(0,uart_baud_rate_tb);
    end

    initial clk = 0;
    always #25 clk = ~clk;
    
    initial begin
        baud_division = 130;
        #100 rst = 1;
        #500 rst = 0;
        #10000 $finish;
    end

endmodule