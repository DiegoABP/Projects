`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.06.2021 17:35:12
// Design Name: 
// Module Name: OpInmediatas
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


module OpInmediatas(input [6:0] OpI,
    input [20:0] inmediato ,
    input clk ,
    input [11:0]Offset,
    input [3:0] en,
    output reg [31:0] ResI,
    output reg [31:0] PCOffset
    );
    always @(posedge clk) begin
        if (en==4'b0001 || en==4'b0100 || en==4'b0010) begin
            case (OpI)
                7'b0110111: begin ResI[31:0]=32'h00000000; ResI[20:0]=inmediato; end
                7'b1100011: begin PCOffset [31:0]=32'h00000000; PCOffset [11:0]=Offset; end
                7'b0000011: begin ResI[31:0]=32'h00000000; ResI[20:0]=inmediato; end
            endcase
        end
    end
endmodule