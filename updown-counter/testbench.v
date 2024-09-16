`timescale 1ns / 1ps
module tb();
reg [7:0]init;//inital value from which count to be started
reg clk,rst,mode;
wire [7:0]count;
updown_counter uut(clk,rst,mode,init,count);
initial begin
clk=0;
rst=0;
forever #10 clk=~clk;

end
always begin #10 init=8'b10000001;mode=1; #10 rst=1;
#5000 mode=0; #5000 rst=0; end
endmodule
