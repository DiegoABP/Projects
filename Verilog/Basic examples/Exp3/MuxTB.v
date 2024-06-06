//`timescale 10ns/ 10ps;
`timescale 1us/10ns
module MuxTB;
//Prueba 16 bits
reg  [15:0]A,B,C,D;
reg [1:0] S; 
wire [15:0]O;
//Prueba 8 bits
reg  [7:0] A2,B2,C2,D2;
reg [1:0] S2; 
wire [7:0]O2;

//Prueba 4 bits
reg  [3:0] A4,B4,C4,D4;
reg [1:0] S4; 
wire [3:0]O4;

mux_4x1 uut(A,B,C,D,S,O);
mux_4x1#(.WIDTH(8))uuq(A2,B2,C2,D2,S2,O2);
mux_4x1#(.WIDTH(4))uup(A4,B4,C4,D4,S4,O4);


initial begin
$dumpfile("wave_mux4x1.vcd");
$dumpvars(0,MuxTB); 
end
integer i;
initial begin

A=16'b0000000110000000;
B=16'b0000000000000001;
C=16'b1000000000000000;
D=16'b0000010000000000;
S=2'b00;

A2=8'b00000001;
B2=8'b10000000;
C2=8'b01100000;
D2=8'b00001100;
S2=8'b00000000;

A4=4'b0100;
B4=4'b0010;
C4=4'b0001;
D4=4'b0110;
S4=2'b00;

for(i=0; i<51; i=i+1)begin

	A=A+1;
	B=B+1;
	C=C+1;
	D=D+1;
	S=S+1;

	A2=A2+1;
	B2=B2+1;
	C2=C2+1;
	D2=D2+1;
	S2=S2+1;

	A4=A4+1;
	B4=B4+1;
	C4=C4+1;
	D4=D4+1;
	S4=S4+1;
	#2;
end
end
endmodule
