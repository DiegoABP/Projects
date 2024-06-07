`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.06.2021 17:09:00
// Design Name: 
// Module Name: MainFSM
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


module MainFSM(input clk,
    input [31:0] datain,
    input [6:0] OpI,
    input [7:0] S,
    output reg [31:0] ins,
    output reg [1:0]sel,
    output reg [2:0] ALUop,
    output reg [3:0] en,
    output reg [31:0] PC    
    );
   parameter S0 = 8'b00000001;
   parameter S1 = 8'b00000010;
   parameter S2 = 8'b00000100;
   parameter S3 = 8'b00001000;

   always @(posedge clk) begin
             case (S)
                S0 : begin
                   ins <= datain; 
                   en<=4'b0001;
                end
                S1 : begin //add
                    case(OpI)
                       7'b0110011: begin //add
                           ALUop <= 3'b000;
                       end

                       7'b1100011: begin //beq
                           ALUop <= 3'b001;
                       end
                    endcase
                    en<=4'b0010;
                end
                S2 : begin 
                  case(OpI)
                       7'b0110011: begin //add
                           sel<=2'b00;
                       end
                       7'b0000011: begin
                            sel<=2'b01; //lw
                       end
                       7'b0100011: begin  ///sw
                            sel<=2'b10;
                       end
                       
                    endcase
                    en<=4'b0100;
                end
                S3 : begin 
                   en<=4'b1000;
                end
    
             endcase

   end
endmodule