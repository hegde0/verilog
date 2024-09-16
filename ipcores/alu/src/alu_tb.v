`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2024 20:31:31
// Design Name: 
// Module Name: alu_tb
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


module alu_tb();
reg [7:0]a,b;
reg cin;
wire [7:0]res;
wire cout,z,v;
reg [4:0]count;
alu uut(.result(res),
        .a(a), 
        .b(b),
        .cin(cin),
        .cout(cout),
        .z(z),
        .v(v),
        .opcode(count));
initial begin
cin=1;
a=8'b11011011;
b=8'b01101101;
count = 0;
end
always #10  count=count+1; 
endmodule
