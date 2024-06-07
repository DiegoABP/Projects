//`timescale 1ns / 1ps
`timescale 1us/10ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2021 12:04:08
// Design Name: 
// Module Name: SumTB
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


module SumTB;

reg signed [31:0] A;
reg signed [31:0] B;
reg [3:0] en;
wire signed [31:0] num;
//---------------------------------------------------------------------------------------------------------------------------------
Sumador sum(.A(A),.B(B),.en(en),.num(num));

initial begin
//0.46   0.79
A=32'b00111110111010111000010100011110;B=32'b00111110111010111000010100011110;en=4'b1111; 
#10;A=32'b00111111010010100011110101110000;B=32'b00111110111010111000010100011110;en=4'b1111; 
#10;A=32'b00111111010010100011110101110000;B=32'b00111111010010100011110101110000;en=4'b1111; 
//0.25 0.5
#10;A=32'b00111110100000000000000000000000;B=32'b00111111000000000000000000000000;en=4'b1111; 
#10;A=32'b00111110100000000000000000000000;B=32'b00111110100000000000000000000000;en=4'b1111; 
#10;A=32'b00111111000000000000000000000000;B=32'b00111111000000000000000000000000;en=4'b1111; 
//7.98 4.33
#10;A=32'b01000000111111110101110000101001;B=32'b01000000100010101000111101011100;en=4'b1111; 
#10;A=32'b01000000111111110101110000101001;B=32'b01000000111111110101110000101001;en=4'b1111; 
#10;A=32'b01000000100010101000111101011100;B=32'b01000000100010101000111101011100;en=4'b1111; 
//-253.336 -12.1
#10;A=32'b11000011011111010101011000000100;B=32'b11000001010000011001100110011010;en=4'b1111; 
#10;A=32'b11000011011111010101011000000100;B=32'b11000011011111010101011000000100;en=4'b1111; 
#10;A=32'b11000001010000011001100110011010;B=32'b11000001010000011001100110011010;en=4'b1111; 
//-525701.75 -797.077
#10;A=32'b11001001000000000101100001011100;B=32'b11000100010001110100010011101110;en=4'b1111; 
#10;A=32'b11001001000000000101100001011100;B=32'b11001001000000000101100001011100;en=4'b1111; 
#10;A=32'b11000100010001110100010011101110;B=32'b11000100010001110100010011101110;en=4'b1111; 
//-525701.75 -797.077
#10;A=32'b01001001011101001010110110010101;B=32'b01000101010101110011011100001010;en=4'b1111; 
#10;A=32'b01001001011101001010110110010101;B=32'b01001001011101001010110110010101;en=4'b1111; 
#10;A=32'b01000101010101110011011100001010;B=32'b01000101010101110011011100001010;en=4'b1111; 
#10; $finish;
end
endmodule
