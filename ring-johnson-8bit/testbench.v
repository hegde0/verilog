`timescale 1ns / 1ps
///////////////////////////////////////////////////////////
///////////////////////
// Company:
// Engineer:Hegde
//
// Create Date: 07.03.2024 09:26:58
// Design Name:
// Module Name: testbench_ring
// Additional Comments:
//verilog testbench for the design 8 bit ring-johnson counter
///////////////////////////////////////////////////////////
///////////////////////
module testbench_ring( );
wire [7:0]count;
reg clk,rst,mode,ring;
reg [7:0] init;
ring_ctr uut(clk,rst,mode,init,count,ring);
initial begin
clk=0;rst=0;ring=1;init=8&#39;b0011;
forever #10 clk=~clk;
end
always begin
#10 mode=1; rst=1;
#150 mode=0;
#150 rst=0;
#10 rst=1;
ring=0;
#150 ring=1;end
endmodule
