`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2024 09:26:58
// Design Name: 
// Module Name: testbench_ring
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


module testbench_ring( );
wire [7:0]count;
reg clk,rst,mode;
reg [7:0] init;
ring_ctr uut(clk,rst,mode,init,count);
initial begin
clk=0;rst=0;
forever #10 clk=~clk;
end
always begin #10 init=8'b0011;mode=1; #10 rst=1; #150 mode=0; #150 rst=0; end 
endmodule
