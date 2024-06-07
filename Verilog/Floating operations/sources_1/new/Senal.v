`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.05.2021 21:18:10
// Design Name: 
// Module Name: Senal
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


module Senal(
input  BAc,
input  clk,
input  BAn,
input cambio,
output reg BSi,
output reg  Botons);
reg [2:0]Presionado =0;
always @( posedge clk)
begin
    if (cambio)
        Botons=0;
	if (BAn == !BAc)begin
		  Presionado = Presionado + 1;
	end
	if (Presionado == 4) begin
		 Botons=1;
		 Presionado =0;
	end
	else begin 
	Botons=0;
	end
	BSi=BAc;
end
endmodule  