`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2021 22:53:20
// Design Name: 
// Module Name: Maquina de Estados
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


module Maquina_de_Estados(
input Boton,
input Modo,
input clk,
input [3:0] Op,
output reg [3:0] en,
output reg  cambio);
always@(posedge clk)
begin
    if (Modo==0 | (Modo==1 & Boton==1))begin
        case(Op)
            3'b000: en = 4'b1000;
            3'b001: en = 4'b1100;
            3'b010: en = 4'b1110;
            3'b011: en = 4'b1111;
            3'b100: en = 4'b0000;
        endcase
        cambio =1;
        
    end 
    else
    cambio=0;   
   
end
endmodule
