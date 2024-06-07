`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2021 10:38:18
// Design Name: 
// Module Name: Sumador
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


module Sumador(
    input [31:0] A,
    input [31:0] B,
    input [3:0] en,
    output  outcomp,
    output [31:0] num,
    output [31:0] numr,
    output [31:0] numsO
    );
    //wire outcomp;
    wire sel;
    wire [7:0] cant;
    wire [32:0] BR;
    wire [32:0] AR;
    wire [32:0] nums;
    Comparador c(.A(A),.B(B),.en(en[3]),.out(outcomp));
    CorrimientoR cr(.A(A),.B(B),.eq(outcomp),.en(en[2]),.sel(sel),.cant(cant));
    ShiftR sh(.A(A),.B(B),.cant(cant),.sel(sel),.en(en[2]),.AR(AR),.BR(BR),.numr(numr));
    Suma sumi(.A(AR),.B(BR),.en(en[1]),.out(nums),.numsO(numsO));
    Normalizacion n(.A(nums),.en(en[0]),.fnum(num));

    

endmodule
