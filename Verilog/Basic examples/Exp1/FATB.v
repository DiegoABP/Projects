//`timescale 10ns/ 10ps;
`timescale 1us/10ns
module FATB;
reg A,B,Cin;
wire S,Cout;  

one_bit_full_adder_v uut(.A0(A),.B0(B),.Ci(Cin),.S(S),.C(Cout));
initial begin
$dumpfile("wave_one_bit_full_adder_v.vcd");
$dumpvars(0,FATB); 
end
initial begin
A = 0;
B = 0;
Cin = 0;
#5;   
A = 0;  
B = 0;
Cin = 1;
#5;  
A = 0;
B = 1;
Cin = 0;
#5;
A = 0;
B = 1;
Cin = 1;
#5;
A = 1;
B = 0;
Cin = 0;   
#5;
A = 1;
B = 0;
Cin = 1;
#5;
A = 1;
B = 1;
Cin = 0;
#5;  
A = 1;
B = 1;
Cin = 1;
#5; 
A = 1;
B = 1;
Cin = 1;
#10;  
end
      
endmodule 
