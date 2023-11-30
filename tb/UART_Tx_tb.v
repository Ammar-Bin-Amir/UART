`timescale 1ns/1ns

module uart_tx_tb;
    
    reg clk,rst,en;
    reg baud_tick;
    reg [7:0] data;
    wire tx;

    uart_tx uut(clk,rst,en,baud_tick,data,tx);

    initial begin
        $dumpfile("./temp/UART_Tx_tb.vcd");
        $dumpvars(0,uart_tx_tb);
    end

    initial clk = 0;
    always #25 clk = ~clk;

    initial baud_tick = 0;
    always #3250 baud_tick = ~baud_tick;
    
    initial begin
        data = 8'b1011_0100;
        #50 rst = 1; en = 0;
        #50 rst = 0;
        #100 en = 1;
        #500000 en = 0;
        #1000000 en = 1;
        #500000 en = 0;
        #2000000 en = 1;
        #500000 en = 0;
        #1000000 $finish;
    end

endmodule