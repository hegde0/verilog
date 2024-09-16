`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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
// 
//////////////////////////////////////////////////////////////////////////////////


module ring_ctr(clk,rst,mode,init,count);
input wire clk,rst,mode;
output reg [7:0]count;
input wire [7:0]init;//initial value
always@(posedge clk or negedge rst)
begin
    if(rst==0)//active low reset
        count=init;
    else
    begin 
    if(mode) //left to right
        count={count[0],count[7:1]};
    else //right to left
        count={count[6:0],count[7]};
   end
end
endmodule
