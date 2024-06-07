`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.06.2021 09:45:21
// Design Name: 
// Module Name: Deco
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


module Deco(input [31:0]Entrada,
input clk,
input [3:0] en,
output reg [4:0] ORegistro1,
output reg [4:0] ORegistro2,
output reg [4:0] ORegistroD,
output reg [6:0] OpI,
//output reg [6:0] AluOP,
output reg [20:0] inmediato ,
output reg [11:0] Offset,
output reg [2:0]BCode);

always @(posedge clk)
begin
    if (en==4'b0001 || en==4'b0100 || en==4'b0010) begin
        case (Entrada[6:0])
            //add
         7'b0110011: begin 
            //AluOP=Entrada[6:0];
            OpI=Entrada[6:0];
            ORegistroD = Entrada[11:7];
            ORegistro1 = Entrada[19:15];
            ORegistro2 = Entrada[24:20];
            end
        
        //Lw
         7'b0000011:begin
            OpI=Entrada[6:0];
            ORegistroD= Entrada[11:7];
            inmediato[3:0]=Entrada [19:15];
            inmediato[20:4]=0;	
            end
        //SW
         7'b0100011:begin
            OpI=Entrada[6:0];
            inmediato[4:0]= Entrada [19:15];
            ORegistro2 = Entrada [24:20];
            inmediato[20:4]=0;	
            end
        //BLT
         7'b1100011: begin
            OpI=Entrada[6:0];
            ORegistro1 = Entrada [19:15];
            ORegistro2 = Entrada [24:20];
            Offset[4:0]= Entrada [11:7];
            Offset [11:5]= Entrada[31:25];
            end
        endcase
    end
end
endmodule