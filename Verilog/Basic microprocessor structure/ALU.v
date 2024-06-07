`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2021 14:11:03
// Design Name: 
// Module Name: ALU
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



module ALU(
 input  [31:0] a,  
 input  [31:0] b,  
 input  [2:0] control, 
 input [3:0] en,
 output reg [31:0] result,  
 output reg z
    );

always @(control or a or b)
begin 
    if (en==4'b0001 || en==4'b0100 || en==4'b0010) begin
         case(control)
         3'b000: result = a + b; // add
         3'b001: result = a - b; // sub
         3'b010: result = a & b;
         3'b011: result = a | b;
         3'b100: result = a^b;
         3'b101: result = a<<b;
         3'b110: result = a>>b; 
         endcase
         z = (result==32'd0) ? 1'b1: 1'b0;
     end
     else result=result;
end
 
endmodule

