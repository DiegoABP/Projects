`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2021 00:55:08
// Design Name: 
// Module Name: ProgramCounter
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


module ProgramCounter( input [31:0] Pcp,
    input [7:0] S,
    input up,
    input clk, 
    input rst,
    input z,
    input [3:0] en,
    output reg [31:0] PC   
    );
    reg tb;
    always @(posedge clk) begin
        if (rst==0) begin
            PC<=32'h00000000;
            tb=0;
        end
        if (en==4'b1000 && tb==0) begin
            if (z==1) begin
                PC<=Pcp;
            end 
            else begin
               PC<=PC+1;
            end
            tb=1;
        end
        else tb=0;
    end
endmodule