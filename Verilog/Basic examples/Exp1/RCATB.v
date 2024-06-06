//`timescale 1ns/1ps
`timescale 1us/10ns
module RCATB;
reg [7:0] a;
reg [7:0] b;
reg cin;
wire [7:0] S;
wire C;
Ripple_Carry_Adder_eight_bits_v uut(.A(a),.B(b),.C0(cin),.S(S),.Cout(C));
initial begin
$dumpfile("wave_Ripple_Carry_Adder_eight_bits_v.vcd");
$dumpvars(0,RCATB); 
end
integer i;
integer j;
initial begin

a=8'b00000000;b=8'b00000000;cin=1'b0;
#2;
for(i=0; i<16; i=i+1)begin
a=a+1;
	for(j=0; j<16; j=j+1)begin
		b=b+1;

		for(j=0; j<2; j=j+1)begin
			cin=cin+1;
			#2;
		end

	end
end 

end

initial begin
#500 $finish;
end


endmodule
