`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2021 10:44:30
// Design Name: 
// Module Name: Comparador
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


module Comparador(
    input [31:0] A,
    input [31:0] B,
    input en,
    output reg out
    );
    reg [7:0] EA;
    reg [7:0] Eb;
    reg outb;
    always @(A or B or en) begin
    EA=A[30:23];
    Eb=B[30:23];
    outb=~(EA==Eb); 
    out=(en==1) ? outb:'bx; 
    end 
endmodule
