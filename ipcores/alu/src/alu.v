`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2024 15:53:10
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module alu (result,a,b,cin,cout,z,v,opcode);
  output reg [7:0] result;     //output of alu
   input [7:0]     a,b;    //inputs to alu
   input [4:0] opcode;     //control signal for different operation
   input cin;
   output reg cout,z,v;
   reg [8:0]op; 
   initial begin 
   op=8'd0;cout=0;z=0;v=0;end
always@(*)
begin 
cout=op[8];
result={op[7:0]};
if((opcode==(5'd0||5'd2||5'd4))&&op>9'b011111111)
v=1;
else
v=0;
end
always@(*) 
begin
if(result==0)
z=1;
else 
z=0;
end
always @(*)
begin
 case (opcode)
   5'd0000 : begin op = a + b; $display("Addition without carry operation"); end
   5'd0001 : begin op = a - b; $display("Subtraction operation"); end
   5'd2 : begin op= a+b+cin;end
   5'd3 : begin op= a-b-cin;end
   5'd4 : begin op = a * b; $display("Multiplication operation"); end
   5'd5 : begin op = a / b; $display("Division operation"); end
   5'd6 : begin op = a % b; $display("Modulo Division operation"); end
   5'd7 : begin op = a & b; $display("Bit-wise AND operation"); end
   5'd8 : begin op = a | b; $display("Bit-wise OR operation"); end
   5'd9 : begin op = a && b; $display("Logical AND operation"); end
   5'd10 : begin op = a || b; $display("Logical OR operation"); end
   5'd11 : begin op = a ^ b; $display("Bit-wise XOR operation"); end
   5'd12 : begin op = ~ a; $display("Bit-wise Invert operation"); end
   5'd13 : begin op = ! a; $display("Logical Invert operation"); end
   5'd14 : begin op = a >> 1; $display("Right Shift operation"); end//logic
   5'd15 : begin op = a << 1 ; $display("Left Shift operation"); end//logic
   5'd16 : begin op = a + 1; $display("Increment operation"); end
   5'd17 : begin op = a - 1; $display("Decrement operation"); end
   5'd18 : begin op= a>b; end //compare
   5'd19 : begin op=a<b;end //compare
   5'd20 : begin op=a==b; end //compare
   5'd21 : begin op[7:0]=a<<<b;end //signed shift i.e. arithmatic
   5'd22 : begin op[7:0]=a>>>b; end//signed right shift i.e. arithmatic
   5'd23 : begin op={op[8],a[6:0],a[7]};end//rotate left
   5'd24 : begin op={op[8],a[0],a[7:1]};end//rotate right
   5'd25 : begin op={a[7:0],op[8]};end//rotate left through carry
   5'd26 : begin op={a[0],op[8],a[7:1]};end//rotate right through carry 
   default:op = 9'bXXXXXXXX;
 endcase
end
endmodule