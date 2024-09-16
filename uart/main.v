`timescale 1ns / 1ps

// Module declaration for the feeder module
module main(
    input       i_Clock,    // Clock input
    input       rst,        // Reset input
    input       r_ready,    // Receiver ready signal input
    output wire  o_Tx_active,// Transmitter active signal output
    output wire  o_Tx_Serial,// Transmitted serial data output
    output wire  o_Tx_done   // Transmission completion signal output
);

    // Parameter declarations
    parameter data_send = 2'b01;    // Parameter for data send state
    parameter completed = 2'b10;     // Parameter for transmission completion state
    parameter getbyte   = 2'b11;     // Parameter for getting a new byte of data state
    parameter strlen    = 4'd12;     // Parameter for string length

    // Data buffer declaration
    reg [95:0] data_buff;

    ////////////////////////////

    // Internal variables declaration
    reg [7:0] data_Byte = 0;        // Byte of data to be transmitted
    reg       i_Tx_DV = 0;          // Data valid signal for transmission
    wire      o_Tx_ready;           // Transmitter ready signal from UART
    reg [3:0] counter = 0;           // Counter for tracking transmission progress
    reg [1:0] state = 0;             // State variable for FSM
    reg [95:0] data_Buff = 96'h48656C6C6F20576F726C640A;   // Data buffer containing the string to be transmitted. the string is “ Hello world”

    ///////////////////////////////

    // Initialize data_Byte with the first byte of data from data_Buff
    initial begin
        data_Byte = data_Buff[95:88];
    end

    // Instantiation of the UART module
    tx uut(
        .i_Clock(i_Clock),          // Clock input to UART
        .data_Byte(data_Byte),      // Byte of data to be transmitted to UART
        .r_ready(r_ready),          // Receiver ready signal input to UART
        .i_Tx_DV(i_Tx_DV),          // Data valid signal input to UART
        .o_Tx_Active(o_Tx_active),  // Transmitter active signal output from UART
        .o_Tx_Serial(o_Tx_Serial),  // Transmitted serial data output from UART
        .o_Tx_Done(o_Tx_done),      // Transmission completion signal output from UART
        .o_Tx_ready(o_Tx_ready)     // Transmitter ready signal input to UART
    );

    // Combinational logic for FSM and data transmission
    always @(posedge i_Clock or posedge rst) begin
        // Reset condition
        if (rst == 1'b1) begin
            counter <= 0;
            data_Byte <= data_Buff[95:88];
            i_Tx_DV <= 0;
            data_buff <= data_Buff;
        end
        // FSM and data transmission logic
        else if (rst == 1'b0 && counter < strlen && r_ready) begin
            // Data transmission in progress
            if (!o_Tx_done) begin
                // Check if UART is ready to receive data
                if (o_Tx_ready)
                    i_Tx_DV <= 1;
                else
                    i_Tx_DV <= 0;
            end
            // Transmission completed
            else if (o_Tx_done == 1'b1) begin
                // Check if UART is ready to receive new data
                if (!o_Tx_ready) begin
                    // Shift data buffer to the left by 8 bits and increment counter
                    data_buff <= {data_buff[87:0], data_buff[95:88]};
                    counter <= counter + 1;
                end
                else
                    // Update data_Byte with the next byte from data_buff
                    data_Byte <= data_buff[95:88];
            end
        end
    end

endmodule
