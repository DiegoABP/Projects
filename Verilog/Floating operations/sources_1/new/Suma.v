`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.04.2021 00:53:00
// Design Name: 
// Module Name: Suma
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
    input  [32:0] A,
    input  [32:0] B,
    input en,
    output reg  [32:0] out,
    output reg [31:0] numsO 
    );
    reg  [24:0] outs;
    reg  [32:0] outb;
    reg  [23:0] AS;
    reg  [23:0] BS;
    reg [7:0]exp;
    reg FC;
    always @(A or B or en) begin
        AS[23:0]=A[23:0];
        BS[23:0]=B[23:0];
        outs= AS+BS;
        exp[7:0]=A[31:24];
        FC=outs[24];
        if (FC==1) begin
           if (exp == 8'b01111111) out= 'bx;
           else begin
            outs= (outs >> 1);
            exp=exp+1; end
        end
        outb[23:0]=outs[23:0];
        outb[31:24]=exp[7:0];
        outb[32]=A[32];
        out=(en==1) ? outb:'bx;
    numsO[22:0]=outb [22:0];
    numsO[30:23]=outb[31:24];
    numsO[31]=outb [32];
        
        
        
    end
endmodule
