module Buffer (in,enable,out);
parameter bit=4;
input  [bit-1:0] in;
input  enable;
output [bit-1:0] out;
assign out = (enable) ? in : 'bz;  
endmodule
