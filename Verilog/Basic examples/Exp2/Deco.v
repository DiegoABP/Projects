module decoderBCD(in,Out);
input [3:0] in;
output [6:0] Out;
//catodo comun
assign Out[6]=(in[3] & (~in[2]) & (~in[1]))|((~in[3]) & in[2] & in[0])|((~in[2]) & (~in[0]))|((~in[3]) & in[1])|(in[3] & (~in[0]))|(in[2] & in[1]);
assign Out[5]=((~in[3]) & (~in[1]) & (~in[0]))|((~in[3]) & in[1]& in[0])|(in[3] & (~in[1]) & in[0])|((~in[3]) & (~in[2]))|((~in[2]) & (~in[0]));
assign Out[4]=((~in[2]) & (~in[1]))|((~in[2]) & in[0])|((~in[1]) & in[0])|((~in[3]) & in[2])|(in[3] & (~in[2]));
assign Out[3]=((~in[3]) & (~in[2]) & (~in[0]))|((~in[2]) & in[1] & in[0])|((~in[1]) & in[2] & in[0])|(in[2] & (~in[0]) & in[1])|(in[3] & (~in[1]));
assign Out[2]=((~in[2]) & (~in[0]))|(in[1] & (~in[0]))|(in[3] & in[1])|(in[3] & in[2]);
assign Out[1]=((~in[3])& in[2] & (~in[1]))|((~in[1])& (~in[0]))|(in[2] & (~in[0]))|(in[3] &(~in[2]))|(in[3] & in[1]);
assign Out[0]=((~in[3]) & in[2]& (~in[1]))|(in[1] & (~in[2]))|(in[3] & in[0])|(in[1] & (~in[0]))|(in[3] & (~in[2]));
endmodule
