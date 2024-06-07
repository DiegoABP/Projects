`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.06.2021 23:25:31
// Design Name: 
// Module Name: Selector
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


module Selector(input [31:0] rd1, 
    input [31:0] rd2,
    input [31:0] r3,
    input [31:0] ALUr,
    input [31:0] ResI,
    input [1:0] sel,
    input [3:0] en,
    input clk,
    output reg we,//habilita escribir en regitros
    output reg wem, //habilita el escribir en memoria
    output reg [31:0] address,
    output reg  [31:0] dataout
    );
    always @(posedge clk) begin 
        if (en==4'b0001 || en==4'b0100 || en==4'b0010) begin
            case (sel)
            //add
            2'b00: begin
                we<=1;
                wem<=0;
                dataout<=ALUr;
            end
            //lw
            2'b01: begin
                we<=1;
                wem<=0;
                address<=ResI;
            end
            //sw
            2'b10: begin
                we<=0;
                wem<=1;
                address<=ResI;
                dataout<=r3;
            end     
            endcase
        end
    end
endmodule
