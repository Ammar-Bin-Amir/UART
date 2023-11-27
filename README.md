# UART

Universal Asynchronous Receiver/Transmitter (UART) is a key component in digital communication systems, facilitating serial data transmission between devices. 

The RTL design of UART has been implemented by using verilog. The architecture is divided into four essential modules: the Baud Rate Generator, Transmitter (TX), Receiver (RX), and the UART top-level module that acts as the Register Interface (RIF) unit.

The Baud Rate Generator determines the communication speed, generating clock signals synchronized with the data transmission rate. The Transmitter and Receiver modules manage the data flow, handling outgoing and incoming data, respectively. At the top level, the UART module orchestrates these units, functioning as the Register Interface where data transfer occurs between the internal registers of the UART and external components. This design encapsulates the functionalities of each module, enabling the seamless transmission and reception of data while providing a structured and organized interface for data exchange between the UART and external systems.
