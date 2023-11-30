`timescale 1ns/1ns

module uart_rx_tb;
    
    reg clk,rst;
    reg baud_tick;
    reg rx;
    wire [7:0] data;

    uart_rx uut(clk,rst,baud_tick,rx,data);

    initial begin
        $dumpfile("./temp/UART_Rx_tb.vcd");
        $dumpvars(0,uart_rx_tb);
    end

    initial clk = 0;
    always #25 clk = ~clk;

    initial baud_tick = 0;
    always #3250 baud_tick = ~baud_tick;

    initial begin
        #50 rst = 1;
        #50 rst = 0;
        #104800 rx = 0;
        #104800 rx = 1;
        #104800 rx = 0;
        #104800 rx = 1;
        #104800 rx = 0;
        #104800 rx = 1;
        #104800 rx = 1;
        #104800 rx = 0;
        #104800 rx = 1;
        #104800 rx = 1;
        #104800 rx = 1;
        #200000 $finish;
    end

endmodule