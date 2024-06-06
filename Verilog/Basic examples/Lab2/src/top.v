`timescale 1ns/1ps

module top(in1,in2,in3,in4, en, out);

input [3:0]in1,in2,in3,in4;
input [1:0]en;

output [3:0]out;

low u0(.a(in1[0]),.b(in2[0]),.c(in3[0]),.d(in4[0]),.sel(en),.q(out[0]));
low u1(.a(in1[1]),.b(in2[1]),.c(in3[1]),.d(in4[1]),.sel(en),.q(out[1]));
low u2(.a(in1[2]),.b(in2[2]),.c(in3[2]),.d(in4[2]),.sel(en),.q(out[2]));
low u3(.a(in1[3]),.b(in2[3]),.c(in3[3]),.d(in4[3]),.sel(en),.q(out[3]));

endmodule;


