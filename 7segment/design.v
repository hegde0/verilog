`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Hegde
// 
// Create Date: 01.04.2024 07:22:43
// Design Name:decoder module 
// Module Name: sevseg
// Project Name: 
// Target Devices: Nexys-A7
// Tool Versions: Vivado 
// Description: 
// takes binary input from sliding switches and displays hex equivalent on onboard 7-segment display 
// Dependencies: Nexys-A7-100T-Master.xdc
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sevseg(input wire[3:0]SW,
               output reg[6:0]disp, output reg[7:0]en );
always@(*)
begin
en=8'b11111110;
    case(SW)
    4'd1:disp=7'b1111001;
    4'd2:disp=7'b0100100;
    4'd3:disp<=7'b0110000;
    4'd4:disp<=7'b0011001;
    4'd5:disp<=7'b0010010;
    4'd6:disp<=7'b0000010;
    4'd7:disp<=7'b1111000;
    4'd8:disp<=7'b0000000;
    4'd9:disp<=7'b0010000;
    4'd10:disp<=7'b0001000;
    4'd11:disp<=7'b0000011;
    4'd12:disp<=7'b1000110;
    4'd13:disp<=7'b0100001;
    4'd14:disp<=7'b0000110;
    4'd15:disp<=7'b0001110;
    4'd0:disp<=7'b1000000;
    endcase
    end
endmodule
