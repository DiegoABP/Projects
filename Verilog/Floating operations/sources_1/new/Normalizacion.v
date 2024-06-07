`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2021 19:21:30
// Design Name: 
// Module Name: Normalizacion
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


module Normalizacion(
    input [32:0] A,
    input en,
    output reg [31:0] fnum
    );
    reg [31:0] fnumb;
    reg [31:0] fnumbx;
    reg [23:0] man;
    reg [7:0] exp;
    always @(A or en) begin
       man=A[23:0];
       exp=A[31:24]; 
       fnumb[23:0]=(man[23]==0) ? man<<1:man;
       fnumb[31:24]=(man[23]==0) ? exp-1:exp;
       fnumbx[31]=A[32];
       fnumbx[30:23]=fnumb[31:24];
       fnumbx[22:0]=fnumb[22:0];
       fnum=(en==1) ? fnumbx:'bx;
    end
endmodule
