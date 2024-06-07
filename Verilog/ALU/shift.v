module shiftL (SL_inA, SL_inB,SL_Fin, SL_out,SL_C, SL_N,SL_V);
parameter bits = 4;

input wire [bits-1:0] SL_inA;
input wire [bits-1:0] SL_inB;
input wire SL_Fin;

output reg [bits-1:0] SL_out;
output reg SL_N,SL_C;
output reg SL_V= 0;
integer i;
reg [bits-1:0]carryL;

always @(SL_Fin or SL_inB)

begin
assign carryL = bits-SL_inB;
assign SL_C = SL_inA [carryL];

if (SL_inB==0)
assign SL_C=0;

if (SL_inB>= bits+1)
assign SL_C=SL_Fin;

if (SL_Fin==0)

SL_out = SL_inA << SL_inB;

else begin

SL_out=SL_inA;

for (i=0; i<SL_inB; i=i+1)begin
	 SL_out = (SL_out << 1);
	 SL_out[0] = 1;
	end
end
assign SL_N=SL_out[bits-1];
end
endmodule


module shiftR (SR_inA, SR_inB,SR_Fin, SR_out,SR_C,SR_N,SR_V);

parameter bits = 4;

input wire [bits-1:0] SR_inA,SR_inB;

input wire SR_Fin;

output reg [bits-1:0] SR_out;
output reg SR_N, SR_C;
output reg SR_V= 0;
integer j;


always @(SR_Fin or SR_inB)

begin

assign SR_C= SR_inA [SR_inB-1];
if (SR_inB==0 )
assign SR_C=0;

if (SR_inB>= bits+1)
assign SR_C=SR_Fin;

if (SR_Fin==0)
	 SR_out = (SR_inA >> SR_inB);


else begin

SR_out=SR_inA;
for (j=0; j<SR_inB; j=j+1)begin
	 SR_out = (SR_out >> 1) ;
	  SR_out[bits-1] = 1;
	end
end
assign SR_N=SR_out[bits-1];
end
endmodule




