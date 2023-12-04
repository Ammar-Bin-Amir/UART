`timescale 1ns/1ns

module uart_tx_tb;
    
    reg clk;
    reg rst;
    wire baud_tick;
    reg [7:0] ext_data_in;
    reg en;
    wire tx;

    uart_tx uut (
        .clk (clk),
        .rst (rst),
        .baud_tick (baud_tick),
        .ext_data_in (ext_data_in),
        .en (en),
        .tx (tx)
    );

    uart_baud_rate uut_baud_rate (
        .clk (clk),
        .rst (rst),
        .baud_division (130),
        .en (en),
        .baud_tick (baud_tick)
    );

    initial begin
        $dumpfile("./temp/UART_Tx_tb.vcd");
        $dumpvars(0,uart_tx_tb);
    end

    initial clk = 0;
    always #25 clk = ~clk;
    
    initial begin
        #10 rst = 1;
        #50 rst = 0;
        #10000 en = 1;
        #1000 ext_data_in = 8'b1011_0100;
        #2000000 en = 0;
        #1000 ext_data_in = 8'b1010_0101;
        #1000000 en = 1;
        #100 en = 0;
        #1500000 $finish;
    end

endmodule