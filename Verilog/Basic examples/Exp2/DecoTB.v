//`timescale 10ns/ 10ps;
`timescale 1us/10ns
module DecoTB;
reg [3:0]A;  
wire [6:0]B;

decoderBCD uut(A,B);
initial begin
$dumpfile("wave_decoBCD.vcd");
$dumpvars(0,DecoTB); 
end

initial begin
A=4'b0000;
#10 A=4'b0001;
#10 A=4'b0010;
#10 A=4'b0011;
#10 A=4'b0100;
#10 A=4'b0101;
#10 A=4'b0110;
#10 A=4'b0111;
#10 A=4'b1000;
#10 A=4'b1001;
#10 A=4'b1010;
#10 A=4'b1011;
#10 A=4'b1100;
#10 A=4'b1101;
#10 A=4'b1110;
#10 A=4'b1111;
#10 A=4'b0000;
end
endmodule
