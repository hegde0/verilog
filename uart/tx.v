`timescale 1ns / 1ps

// Module declaration for the UART transmitter module
module tx (
    input       i_Clock,            // Clock input
    input [7:0] data_Byte,          // Data byte input from feeder module
    input       r_ready,            // Receiver ready input (switch on/off)
    input       i_Tx_DV,            // Data valid input from feeder module
    output reg  o_Tx_Active,        // Transmitter active output to LED
    output reg  o_Tx_Serial,        // Transmitted serial data output
    output reg  o_Tx_Done,          // Transmission completion output to feeder & LED
    output      o_Tx_ready          // Transmission ready output to feeder
);

    // Parameters defining states of the finite state machine
    parameter s_IDLE         = 3'b000;
    parameter s_TX_START_BIT = 3'b001;
    parameter s_TX_DATA_BITS = 3'b010;
    parameter s_TX_STOP_BIT  = 3'b011;
    parameter s_CLEANUP      = 3'b100;
    parameter CLKS_PER_BIT  = 10'd868; // Clock cycles per bit

    // Registers for state machine control
    reg [2:0]   r_SM_Main     = 0;
    integer     r_Clock_Count = 0;
    reg [2:0]   r_Bit_Index   = 0;
    reg [7:0]   r_Tx_Data     = 0;

    // Initialization block
    initial begin
        o_Tx_Done   = 0;
        o_Tx_Active = 0;
    end

    // State machine logic
    always @(posedge i_Clock) begin
        case (r_SM_Main)
            s_IDLE: begin
                // Drive line high for idle state
                o_Tx_Serial   <= 1'b1;
                o_Tx_Done     <= 1'b0;
                r_Clock_Count <= 0;
                r_Bit_Index   <= 0;

                // Check for start of transmission
                if (i_Tx_DV == 1'b1 && r_ready == 1'b1) begin
                    o_Tx_Active <= 1'b1;
                    r_Tx_Data   <= data_Byte;
                    r_SM_Main   <= s_TX_START_BIT;
                end else
                    r_SM_Main <= s_IDLE;
            end

            // Send out start bit (0)
            s_TX_START_BIT: begin
                o_Tx_Serial <= 1'b0;
                
                // Wait for start bit to finish
                if (r_Clock_Count < CLKS_PER_BIT - 1) begin
                    r_Clock_Count <= r_Clock_Count + 1;
                    r_SM_Main     <= s_TX_START_BIT;
                end else begin
                    r_Clock_Count <= 0;
                    r_SM_Main     <= s_TX_DATA_BITS;
                end
            end

            // Send out data bits
            s_TX_DATA_BITS: begin
                o_Tx_Serial <= r_Tx_Data[r_Bit_Index];
                
                // Wait for data bits to finish
                if (r_Clock_Count < CLKS_PER_BIT - 1) begin
                    r_Clock_Count <= r_Clock_Count + 1;
                    r_SM_Main     <= s_TX_DATA_BITS;
                end else begin
                    r_Clock_Count <= 0;
                    
                    // Check if all bits have been sent
                    if (r_Bit_Index < 7) begin
                        r_Bit_Index <= r_Bit_Index + 1;
                        r_SM_Main   <= s_TX_DATA_BITS;
                    end else begin
                        r_Bit_Index <= 0;
                        r_SM_Main   <= s_TX_STOP_BIT;
                    end
                end
            end

            // Send out stop bit (1)
            s_TX_STOP_BIT: begin
                o_Tx_Serial <= 1'b1;
                
                // Wait for stop bit to finish
                if (r_Clock_Count < CLKS_PER_BIT - 1) begin
                    r_Clock_Count <= r_Clock_Count + 1;
                    r_SM_Main     <= s_TX_STOP_BIT;
                end else begin
                    // Transmission is complete
                    o_Tx_Done     <= 1'b1;
                    r_Clock_Count <= 0;
                    r_SM_Main     <= s_CLEANUP;
                end
            end

            // Cleanup state
            s_CLEANUP: begin
                o_Tx_Active   <= 1'b0;
                o_Tx_Done     <= 1'b1;
                r_SM_Main     <= s_IDLE;
            end

            default:
                r_SM_Main <= s_IDLE;
        endcase
    end

    // Assign output for transmission ready signal
    assign o_Tx_ready = ~o_Tx_Active;

endmodule
