module subtractor(A,B,cin,Sc,N,V,Co);
parameter bits=4;
input signed[bits-1:0] A;
input signed [bits-1:0] B;
input cin;
wire signed [bits:0] S;
output signed [bits-1:0] Sc;
wire signed [bits-1:0] Bc=-B;
output Co;
output N,V;
wire Ck;
carry_lookahead_adderr #(.bits(bits))CLS(.A(A),.B(Bc),.cin(cin),.S(S),.Ck(Ck));
assign Sc=S[bits-1:0];
assign Co=S[bits];
assign N=S[bits-1];
assign V=Co^Ck;


endmodule
