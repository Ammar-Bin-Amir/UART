`timescale 1ns/1ns

module uart_test_tb;
    
    reg clk;
    reg rst;
    reg [1:0] address;
    reg write_enable;
    reg [31:0] write_data;
    reg read_enable;
    wire [7:0] read_data;
    wire tx;
    reg rx;

    uart_top_design uut(clk,rst,address,write_enable,write_data,read_enable,read_data,tx,rx);

    initial begin
        $dumpfile("./temp/UART_Test_tb.vcd");
        $dumpvars(0,uart_test_tb);
    end

    initial clk = 0;
    always #25 clk = ~clk;

    initial begin
        rst = 1;
        #100 rst = 0;
        #100 address = 0;
        #100 write_data = 130;
        #100 write_enable = 1;
        #100 write_enable = 0;
        #100 address = 1;
        #100 write_data = 1;
        #100 write_enable = 1;
        #100 address = 2;
        #100 write_data = 8'b0110_1001;
        #100 address = 1;
        #100 write_data = 0;
        #100 write_enable = 1;
        #100 address = 3;
        #100 write_enable = 1;
        #100 write_data = 8'b1011_0100;
        #115350 rx = 0;
        #115350 rx = 0;
        #115350 rx = 1;
        #115350 rx = 0;
        #115350 rx = 1;
        #115350 rx = 1;
        #115350 rx = 0;
        #115350 rx = 1;
        #1000000 read_enable = 1;
        #1000000 $finish;
    end

endmodule