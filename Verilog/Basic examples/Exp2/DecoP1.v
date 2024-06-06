module decoderBCD(in,Out);
input [3:0] in;
output [6:0] Out;
wire a=in[3];
wire b=in[2];
wire c=in[1];
wire d=in[0];
//catodo comun
assign Out[6]=(a&~b&~c)|(~a&b&d)|(~b&~d)|(~a&c)|(a&~d)+(b&c);
assign Out[5]=(~a&~c&~d)|(~a&c&d)|(a&~c&d)|(~b&~d)|(~b&~c);
assign Out[4]=(~c&d)|(~a&b)|(a&~b)|(~a&d)|(~a&~c);
assign Out[3]=(~b&c&d)|(b&~c&d)|(b&c&~d)|(a&~c&~b)|(~a&~b&~d);
assign Out[2]=(~b&~d)|(c&~d)|(a&c)|(a&b);
assign Out[1]=(~a&b&~c)|(~c&~d)|(b&~d)|(a&~b)|(a&c);
assign Out[0]=(~b&c)|(a&~b)|(a&d)|(~d&c)|(~a&b&~c);
//always@ (in)
//begin
//case (in)
//	4'b0000 : Out = 7'b1111110;
//	4'b0001 : Out = 7'b0110000;
//	4'b0010 : Out = 7'b1101101;
//	4'b0011 : Out = 7'b1111001;
//	4'b0100 : Out = 7'b0010011;
//	4'b0101 : Out = 7'b1011011;
//	4'b0110 : Out = 7'b0011111;
//	4'b0111 : Out = 7'b1110000;
//	4'b1000 : Out = 7'b1111111;
//	4'b1001 : Out = 7'b1110011;
//	4'b1010 : Out = 7'b1110111;
//	4'b1011 : Out = 7'b0011111;
//	4'b1100 : Out = 7'b1001110;
//	4'b1101 : Out = 7'b0111101;
//	4'b1110 : Out = 7'b1001111;
//	4'b1111 : Out = 7'b1000111;
//	default: Out = 7'b1111110;
//	endcase
//end
endmodule
