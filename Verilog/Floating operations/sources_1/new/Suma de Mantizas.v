`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2021 13:45:00
// Design Name: 
// Module Name: Lab 4
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


module Suma(
    input  [31:0] A,
    input  [31:0] B,
    output reg  [31:0] out
    );
    reg  [23:0] outs;
    reg  [22:0] AS;
    reg  [22:0] BS;
    reg [7:0]exp;
    reg FC;
    always @(A or B) begin
    AS[22:0]=A[22:0];
    BS[22:0]=B[22:0];
    if (A[31]==B[31] )begin
        outs[22:0]= AS+BS;
        exp[7:0]=A[30:23];
        FC=outs[23];
        if (FC==1) begin
            if (exp == 8'b01111111)
            out= 'bx;
            else
            outs= (outs >> 1);
            outs[22]=1;
            exp=exp+1;
        end
    out[22:0]=outs[22:0];
    out[30:23]=exp[7:0];
    out[31]=A[31];
 
    end
    else
    out = 'bx;
    end
    endmodule
