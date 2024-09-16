`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2024 08:19:09
// Design Name: 
// Module Name: updown_counter
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


module updown_counter(clk,rst,mode,init,count);
input wire clk,rst,mode;
input wire [7:0]init;//inital value from which count to be started
output reg [7:0] count;//counting register
always@(posedge clk or negedge rst)
begin
    if(rst==1'b0)//active low reset
      begin 
       count=init;
       end
    else 
    begin
        if(mode==1)//mode 1 for up count
            count=count+1;
        else 
            count=count-1;
    end
end
endmodule
