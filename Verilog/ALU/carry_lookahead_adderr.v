module carry_lookahead_adderr(A,B,cin,S,Ck);
parameter bits=4;
input signed [bits-1:0] A;
input signed [bits-1:0] B;
input cin;
output signed [bits:0] S;
output Ck;
wire  signed [bits:0] C; 
wire  signed [bits-1:0] G, P;
assign C[0]=cin ;

genvar i;
generate
	for (i=0; i<(bits); i=i+1) begin
		and ANDG(G[i],A[i],B[i]);
		xor XORP(P[i],A[i],B[i]);
	end	
endgenerate
genvar j;
generate
	for (j=1; j<(bits+1); j=j+1) begin
		assign C[j]=G[j-1]|(P[j-1]&C[j-1]);
	end
endgenerate
genvar k;
generate
	for (k=0; k<(bits); k=k+1) begin
		xor XORS(S[k],P[k],C[k]);
	end
endgenerate
assign S[bits]=C[bits];
//assign Co=S[bits];
assign Ck=C[bits-1];  
 
endmodule 
