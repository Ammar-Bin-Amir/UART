`timescale 1ns/1ns

module uart_baud_rate_tb;
    
    reg clk;
    reg rst;
    reg [31:0] baud_division;
    reg en;
    wire baud_tick;

    uart_baud_rate uut (
        .clk (clk),
        .rst (rst),
        .baud_division (baud_division),
        .en (en),
        .baud_tick (baud_tick)
    );

    initial begin
        $dumpfile("./temp/UART_Baud_Rate_tb.vcd");
        $dumpvars(0,uart_baud_rate_tb);
    end

    initial clk = 0;
    always #25 clk = ~clk;
    
    initial begin
        #25 rst = 1;
        #100 rst = 0;
        #50 baud_division = 130;
        #1000 en = 1;
        #10000 en = 0;
        #1000 $finish;
    end

endmodule