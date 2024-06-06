//`timescale 10ns/ 10ps;
`timescale 1us/10ns
module MuxPTB;
reg A,B;  
wire C;

MuxP uut(A,B,C);
initial begin
$dumpfile("wave_MuxP.vcd");
$dumpvars(0,MuxPTB); 
end
initial begin
A=0;
B=0;

#5;
A=0;
B=0;

#5;
A=0;
B=1;

#5;

end
endmodule
