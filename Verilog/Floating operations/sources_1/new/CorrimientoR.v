`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2021 11:38:48
// Design Name: 
// Module Name: CorrimientoR
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


module CorrimientoR(
    input signed [31:0] A,
    input signed [31:0] B,
    input eq,
    input en,
    output reg sel,
    output reg [7:0]cant
    );
    reg signed [7:0] EA;
    reg signed [7:0] Eb;
    reg selb;
    reg [7:0]cantb;
    always @(A or B or eq or en) begin
    EA=A[30:23];
    Eb=B[30:23];
    selb=(A>B) ? 1:0;
    cantb=(selb) ? (EA-Eb):(Eb-EA);
    sel=(en==1) ? (selb):'bx;
    cant=(en==1) ? (cantb):'bx;
    end 
endmodule
