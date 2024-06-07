`timescale 1us/10ns
module ALU(ALUA, ALUB, ALUFlagIn, ALUResult, ALUFlags);

parameter bits = 4;
parameter ALUControl=4'h0;
//Entradas------------------------------------------------------------------------
input signed [bits-1:0] ALUA ;
input signed [bits-1:0] ALUB ;
//input [3:0] ALUControl ; // add = 4'h0, sub = 4'h1, inc = 4'h2, dec = 4'h3,
                        // and = 4'h4, or = 4'h5, not = 4'h6, xor = 4'h7,
                        // shl = 4'h8, shr = 4'h9
input ALUFlagIn;

//Salidas-------------------------------------------------------------------------
output signed [bits-1:0] ALUResult;
output [3:0] ALUFlags;

//Intermedio
wire C,N; 
wire V;//Negative,Zero,CarryOut,Overflow
reg Z;

//Funcionamiento------------------------------------------------------------------

generate
case (ALUControl)
	4'h0 : adder #(.bits(bits))F0(.A(ALUA),.B(ALUB),.cin(ALUFlagIn),.Sc(ALUResult),.Co(C),.N(N),.V(V));
	4'h1 : subtractor #(.bits(bits))F1(.A(ALUA),.B(ALUB),.cin(ALUFlagIn),.Sc(ALUResult),.Co(C),.N(N),.V(V));
	4'h2 : incremento #(.bits(bits))F2(.A(ALUA),.B(ALUB),.cin(ALUFlagIn),.Sc(ALUResult),.Co(C),.N(N),.V(V));
	4'h3 : decremento #(.bits(bits))F3(.A(ALUA),.B(ALUB),.cin(ALUFlagIn),.Sc(ALUResult),.Co(C),.N(N),.V(V));
	4'h4 : compuerta_and  #(.bits(bits))F4(.and_in1(ALUA),.and_in2(ALUB),.and_out(ALUResult),.and_N(N),.and_V(V),.and_C(C));
	4'h5 : compuerta_or   #(.bits(bits))F5(.or_in1(ALUA),.or_in2(ALUB),.or_out(ALUResult),.or_N(N),.or_V(V),.or_C(C));
	4'h6 : compuerta_not  #(.bits(bits))F6(.not_in1(ALUA),.not_in2(ALUB),.not_Fin(ALUFlagIn),.not_out(ALUResult),.not_N(N),.not_V(V),.not_C(C));
	4'h7 : compuerta_xor  #(.bits(bits))F7(.xor_in1(ALUA),.xor_in2(ALUB),.xor_out(ALUResult),.xor_N(N),.xor_V(V),.xor_C(C));
	4'h8 : shiftL #(.bits(bits)) F8(.SL_inA(ALUA), .SL_inB(ALUB),.SL_Fin(ALUFlagIn), .SL_out(ALUResult),.SL_C(C),.SL_N(N),.SL_V(V));
	4'h9 : shiftR #(.bits(bits)) F9(.SR_inA(ALUA), .SR_inB(ALUB),.SR_Fin(ALUFlagIn), .SR_out(ALUResult),.SR_C(C),.SR_N(N),.SR_V(V));
	endcase
endgenerate


always@ (ALUResult) begin


if (ALUResult==0) Z=1;
else Z=0;
end
assign ALUFlags={N,Z,C,V};

endmodule
