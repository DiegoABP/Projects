`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2021 11:41:56
// Design Name: 
// Module Name: ShiftR
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


module ShiftR(
    input [31:0] A,
    input [31:0] B,
    input wire [7:0] cant,
    input wire sel,
    input en,
    output reg [32:0] AR,
    output reg [32:0] BR,
    output reg [31:0] numr
    );
    reg [23:0] eq=24'b100000000000000000000000;
    reg [23:0] int=24'b100000000000000000000000;
    reg [23:0] SR_outb;
    reg [32:0] ARb;
    reg [32:0] BRb;
    always @(A or B or cant or sel or en)begin
    ARb[32:24]=A[31:23];
    BRb[32:24]=B[31:23];
    int[22:0]=(sel==0) ? A[22:0]:B[22:0];
    ARb[31:24]=(sel==0) ? B[30:23]:A[30:23];
    BRb[31:24]=(sel==0) ? B[30:23]:A[30:23];
    SR_outb=int >> cant;
    eq[22:0]=(sel==0)?B[22:0]:A[22:0];
    ARb[23:0]=(sel==0) ? SR_outb:eq;
    BRb[23:0]=(sel==0) ? eq:SR_outb;
    AR=(en==1) ? ARb:'bx;
    BR=(en==1) ? BRb:'bx;
   if (sel==1)begin
          numr[22:0]= BR[22:0];
          numr[30:23]= BR[31:24];
          numr[31]= BR[32];
    end
    else begin
          numr[22:0]= AR[22:0];
          numr[30:23]= AR[31:24];
          numr[31]= AR[32];
    end

   end
    
endmodule
