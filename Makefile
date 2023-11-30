# Verilog Files

SRC_BAUD_RATE = $(shell pwd)/src/UART_Baud_Rate.v
TB_BAUD_RATE = $(shell pwd)/tb/UART_Baud_Rate_tb.v
VVP_BAUD_RATE = $(shell pwd)/temp/UART_Baud_Rate_tb.vvp
VCD_BAUD_RATE = $(shell pwd)/temp/UART_Baud_Rate_tb.vcd

SRC_TX = $(shell pwd)/src/UART_Tx.v
TB_TX = $(shell pwd)/tb/UART_Tx_tb.v
VVP_TX = $(shell pwd)/temp/UART_Tx_tb.vvp
VCD_TX = $(shell pwd)/temp/UART_Tx_tb.vcd

SRC_RX = $(shell pwd)/src/UART_Rx.v
TB_RX = $(shell pwd)/tb/UART_Rx_tb.v
VVP_RX = $(shell pwd)/temp/UART_Rx_tb.vvp
VCD_RX = $(shell pwd)/temp/UART_Rx_tb.vcd

SRC_UART = $(shell pwd)/src/UART.v
TB_UART = $(shell pwd)/tb/UART_Test_tb.v
VVP_UART = $(shell pwd)/temp/UART_Test_tb.vvp
VCD_UART = $(shell pwd)/temp/UART_Test_tb.vcd

# Compilation Settings

COMPILER = iverilog
COMPILER_FLAG = -o

# Simulation Settings

SIMULATION_FLAG = vvp

# Target: MAIN

all: uart

everything: uart baud_rate tx rx

clean: 
	rm -rf temp

# Target: Baud Rate Generator

baud_rate: compile_baud_rate
	$(SIMULATION_FLAG) $(VVP_BAUD_RATE)

compile_baud_rate: 
	mkdir -p temp
	$(COMPILER) $(COMPILER_FLAG) $(VVP_BAUD_RATE) $(TB_BAUD_RATE) $(SRC_BAUD_RATE)

clean_baud_rate: 
	rm -rf $(VCD_BAUD_RATE)
	rm -rf $(VVP_BAUD_RATE)

# Target: Transmitter

tx: compile_tx
	$(SIMULATION_FLAG) $(VVP_TX)

compile_tx: 
	mkdir -p temp
	$(COMPILER) $(COMPILER_FLAG) $(VVP_TX) $(TB_TX) $(SRC_TX)

clean_tx: 
	rm -rf $(VCD_TX)
	rm -rf $(VVP_TX)

# Target: Receiver

rx: compile_rx
	$(SIMULATION_FLAG) $(VVP_RX)

compile_rx: 
	mkdir -p temp
	$(COMPILER) $(COMPILER_FLAG) $(VVP_RX) $(TB_RX) $(SRC_RX)

clean_rx: 
	rm -rf $(VCD_RX)
	rm -rf $(VVP_RX)

# Target: UART

uart: compile_uart
	$(SIMULATION_FLAG)  $(VVP_UART)

compile_uart: 
	mkdir -p temp
	$(COMPILER) $(COMPILER_FLAG) $(VVP_UART) $(TB_UART) $(SRC_UART) $(SRC_BAUD_RATE) $(SRC_TX) $(SRC_RX)

clean_uart:
	rm -rf $(VCD_UART)
	rm -rf $(VVP_UART)

