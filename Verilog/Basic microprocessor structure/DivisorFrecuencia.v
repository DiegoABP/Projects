`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.05.2021 10:12:52
// Design Name: 
// Module Name: DivisorFrecuencia
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


module Clock_divider(clkin,clkout
    );
input clkin; // input clock on FPGA
output reg clkout; // output clock after dividing the input clock by divisor
reg[27:0] count=28'd0;
parameter div = 28'd16;
always @(posedge clkin)
begin
 count <= count + 28'd1;
 if(count>=(div-1))
  count <= 28'd0;
 clkout <= (count<div/2)?1'b1:1'b0;
end

endmodule
