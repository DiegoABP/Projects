`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2021 02:01:22
// Design Name: 
// Module Name: PruebaMem
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


module PruebaMem(input [31:0]A, output [31:0]Do);
    reg [31:0] MATRIX [255:0];
    
    initial begin
        $readmemh("SPIContent.mem", MATRIX); //cargar contenido de archivo de memoria
    end    
    
    assign #25 Do = MATRIX[A]; //simulando 25ns de retraso (un poco más real)
    
endmodule

