`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2021 23:37:51
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile(
input clk, 
input [4:0] address1,
input [4:0] address2, 
input [4:0] address3,
input [3:0] en, 
input enw, 
input [31:0] r3,
output reg [31:0] r1d,
output reg [31:0] r2d
 );

reg [31:0] registers[31:0];

always @(posedge clk) begin
if (en==4'b0001 || en==4'b0100 || en==4'b0010) begin
    if (enw==1)begin
        registers[address3] <= r3; end
end
end
always @(address1 or address2) begin
if (en==4'b0001 || en==4'b0100 || en==4'b0010) begin
    registers[0000] =32'b00000000000000000000000000000000 ;
    r1d <= registers[address1];
    r2d <= registers[address2];
end
end

endmodule
