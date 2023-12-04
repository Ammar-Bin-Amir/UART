`timescale 1ns/1ns

module uart_rx_tb;
    
    reg clk;
    reg rst;
    wire baud_tick;
    wire rx;
    wire [7:0] ext_data_out;

    uart_rx uut (
        .clk (clk),
        .rst (rst),
        .baud_tick (baud_tick),
        .rx (rx),
        .ext_data_out (ext_data_out)
    );

    reg en;
    reg [7:0] ext_data_in;

    uart_tx uut_tx (
        .clk (clk),
        .rst (rst),
        .baud_tick (baud_tick),
        .ext_data_in (ext_data_in),
        .en (en),
        .tx (rx)
    );

    uart_baud_rate uut_baud_rate (
        .clk (clk),
        .rst (rst),
        .baud_division (130),
        .en (en),
        .baud_tick (baud_tick)
    );

    initial begin
        $dumpfile("./temp/UART_Rx_tb.vcd");
        $dumpvars(0,uart_rx_tb);
    end

    initial clk = 0;
    always #25 clk = ~clk;

    initial begin
        #10 rst = 1;
        #50 rst = 0;
        #10000 en = 1;
        #1000 ext_data_in = 8'b1011_0100;
        #1100000 ext_data_in = 8'b1111_0000;
        #100000 en = 0;
        #1000 ext_data_in = 8'b1010_0101;
        #2000000 en = 1;
        #100 en = 0;
        #1500000 $finish;
    end

endmodule