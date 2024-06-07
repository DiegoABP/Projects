module adder(A,B,cin,Sc,Co,N,V);
parameter bits=4;
input signed [bits-1:0] A;
input signed [bits-1:0] B;
input cin;
output signed [bits-1:0] Sc;
output Co;
output N,V;

wire signed [bits:0] S;
wire Ck,Ne;

carry_lookahead_adderr #(.bits(bits))CLv(.A(A),.B(B),.cin(cin),.S(S),.Ck(Ck));

assign Sc=S[bits-1:0];
assign Co=S[bits];
assign N=S[bits-1];
assign V=Co^Ck;

endmodule
