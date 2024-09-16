`timescale 1ns / 1ps
///////////////////////////////////////////////////////////
///////////////////////
// Engineer:Hegde
//
// Create Date: 07.03.2024 09:22:31
// Design Name:
// Module Name: ring_ctr
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
//rj---> 1 -> ring counting
//       0 -> johnson counting
//8bit size
///////////////////////////////////////////////////////////
///////////////////////

module ring_ctr(clk,rst,mode,init,count,ring);
input wire clk,rst,mode,ring;
output reg [7:0]count;
input wire [7:0]init;//initial value
always@(posedge clk or negedge rst)
begin
if(rst==0)//active low reset
count=init;
else if(ring==1)
begin
if(mode) //left to right
count={count[0],count[7:1]};
else //right to left
count={count[6:0],count[7]};
end
else
count={~count[0],count[7:1]};
end
endmodule
