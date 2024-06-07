module incremento(A,B,Sc,cin,N,V,Co);
parameter bits=4;
input signed [bits-1:0] A;
input signed [bits-1:0] B;
input cin;
wire signed [bits-1:0] C=1;
wire signed [bits:0] S;
wire Ck; 
reg [bits-1:0] Op;
output signed [bits-1:0] Sc;
output Co;
output N,V;
always @(cin or A or B) begin
case (cin)
	1'b0 : Op=A;
	1'b1 : Op=B;
endcase
end
carry_lookahead_adderr #(.bits(bits))CLv(.A(Op),.B(C),.cin(1'b0),.S(S),.Ck(Ck));
assign Co=S[bits];
assign Sc=S[bits-1:0];

assign N=Co|S[bits-1];
assign V=Co^Ck;
endmodule 

