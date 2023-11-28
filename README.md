# UART

Universal Asynchronous Receiver/Transmitter (UART) is a key component in digital communication systems, facilitating serial data transmission between devices. 

## Verilog Implementation

The RTL design of 8-bit UART has been implemented by using verilog. The architecture is divided into four essential modules: the Baud Rate Generator, Transmitter (TX), Receiver (RX), and the UART top-level module that acts as the Register Interface (RIF) unit.

## Architecture

The Baud Rate Generator determines the communication speed, generating clock signals synchronized with the data transmission rate. The Transmitter and Receiver modules manage the data flow, handling outgoing and incoming data, respectively. At the top level, the UART module orchestrates these units, functioning as the Register Interface where data transfer occurs between the internal registers of the UART and external components. This design encapsulates the functionalities of each module, enabling the seamless transmission and reception of data while providing a structured and organized interface for data exchange between the UART and external systems.

## Transaction Format

The transaction involves three distinct bit-streams of data.

- ### Start Bit (LOW)

The communication begins with a start bit, usually held at a low voltage level. This low-level start bit signals the start of a data byte and prepares the receiver for incoming data.

- ### 8-Bit Data

Following the start bit, the actual data (typically 8 bits) is transmitted, representing the payload to be conveyed. These bits encode the information to be sent.

- ### Stop Bit (HIGH)

After transmitting the data bits, a stop bit is sent, held at a high voltage level. This high-level stop bit indicates the end of the data byte transmission. It allows the receiver to prepare for the next potential byte transmission.
