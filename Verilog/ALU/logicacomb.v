module compuerta_and(and_in1,and_in2,and_out,and_N,and_V,and_C);
parameter bits = 4;
input  [bits-1:0] and_in1,and_in2;
output  [bits-1:0] and_out;
output  and_N;
output reg and_V =0;

output reg and_C = 0;

genvar i;
generate
	for (i=0; i<(bits); i=i+1) begin
		and ANDG(and_out[i],and_in1[i],and_in2[i]);
	end	
endgenerate


assign and_N = and_out [bits-1];

endmodule


module compuerta_or(or_in1,or_in2,or_out,or_N,or_V,or_C);
parameter bits = 4;
input wire [bits-1:0] or_in1,or_in2;
output wire [bits-1:0]  or_out;
output wire or_N;
output reg or_C=0,or_V =0;
genvar j;
generate
	for (j=0; j<(bits); j=j+1) begin
		or ORG(or_out[j],or_in1[j],or_in2[j]);
	end	
endgenerate


assign or_N=or_out [bits-1];


endmodule




module compuerta_not(not_in1,not_in2,not_Fin,not_out,not_N,not_V,not_C);
parameter bits = 4;
input wire [bits-1:0] not_in1,not_in2;
input wire not_Fin;
output wire [bits-1:0] not_out;
output wire not_N;
output reg not_C=0,not_V =0;
reg [bits-1:0] not_w;
genvar k;
always @(not_Fin or not_in1 or not_in2) begin
case (not_Fin)
	1'b0 : not_w=not_in1;
	1'b1 : not_w=not_in2;
endcase
end

generate
	for(k=0; k<(bits); k=k+1) begin
		not NOTG(not_out[k],not_w[k]);
	end	
endgenerate






assign not_N=not_out [bits-1];

endmodule 

module compuerta_xor(xor_in1,xor_in2,xor_out,xor_N,xor_V,xor_C);
parameter bits = 4;
input wire [bits-1:0] xor_in1,xor_in2;
output wire [bits-1:0]  xor_out;
output wire xor_N;
output reg xor_C=0,xor_V =0;
genvar l;
generate
	for(l=0; l<(bits); l=l+1) begin
		xor XORG(xor_out[l],xor_in1[l],xor_in2[l]);
	end	
endgenerate



assign xor_N=xor_out [bits-1];
endmodule




