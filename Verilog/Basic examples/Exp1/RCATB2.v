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
initial begin
a=8'b00000001;b=8'b00000001;cin=1'b0;
#10; a=8'b00000001;b=8'b00000001;cin=1'b1;
#10; a=8'b00000010;b=8'b00000011;cin=1'b0;
#10; a=8'b10000001;b=8'b10000001;cin=1'b0;
#10; a=8'b00011001;b=8'b00110001;cin=1'b0;
#10; a=8'b00000011;b=8'b00000011;cin=1'b1;
#10; a=8'b11111111;b=8'b00000001;cin=1'b0;
#10; a=8'b11111111;b=8'b00000000;cin=1'b1;
#10; a=8'b11111111;b=8'b11111111;cin=1'b0;
#10; a=8'b11111111;b=8'b11111111;cin=1'b1;
#10; 
end
endmodule
