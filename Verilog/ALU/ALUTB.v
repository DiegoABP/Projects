//`timescale 1ns/1ps
`timescale 1us/10ns
module ALUTB;

reg signed [3:0] A,AS,AI,AD,AA,AO,AN,AX,AL,AR;
reg signed [3:0] B,BS,BI,BD,BA,BO,BN,BX,BL,BR;

reg FlagIn,FlagInS,FlagInI,FlagInD,FlagInA,FlagInO,FlagInN,FlagInX,FlagInL,FlagInR;
wire signed[3:0] Result,ResultS,ResultI,ResultD,ResultA,ResultO,ResultN,ResultX,ResultL,ResultR;
wire [3:0]Flags,FlagsS,FlagsI,FlagsD,FlagsA,FlagsO,FlagsN,FlagsX,FlagsL,FlagsR;

ALU  #(.bits(4),.ALUControl(4'h0))ADDER(.ALUA(A),.ALUB(B),.ALUFlagIn(FlagIn),.ALUResult(Result),.ALUFlags(Flags));
ALU  #(.bits(4),.ALUControl(4'h1))SUB(.ALUA(AS),.ALUB(BS),.ALUFlagIn(FlagInS),.ALUResult(ResultS),.ALUFlags(FlagsS));
ALU  #(.bits(4),.ALUControl(4'h2))INC(.ALUA(AI),.ALUB(BI),.ALUFlagIn(FlagInI),.ALUResult(ResultI),.ALUFlags(FlagsI));
ALU  #(.bits(4),.ALUControl(4'h3))DEC(.ALUA(AD),.ALUB(BD),.ALUFlagIn(FlagInD),.ALUResult(ResultD),.ALUFlags(FlagsD));
ALU  #(.bits(4),.ALUControl(4'h4))AND(.ALUA(AA),.ALUB(BA),.ALUFlagIn(FlagInA),.ALUResult(ResultA),.ALUFlags(FlagsA));
ALU  #(.bits(4),.ALUControl(4'h5))OR(.ALUA(AO),.ALUB(BO),.ALUFlagIn(FlagInO),.ALUResult(ResultO),.ALUFlags(FlagsO));
ALU  #(.bits(4),.ALUControl(4'h6))NOT(.ALUA(AN),.ALUB(BN),.ALUFlagIn(FlagInN),.ALUResult(ResultN),.ALUFlags(FlagsN));
ALU  #(.bits(4),.ALUControl(4'h7))XOR(.ALUA(AX),.ALUB(BX),.ALUFlagIn(FlagInX),.ALUResult(ResultX),.ALUFlags(FlagsX));
ALU  #(.bits(4),.ALUControl(4'h8))SL(.ALUA(AL),.ALUB(BL),.ALUFlagIn(FlagInL),.ALUResult(ResultL),.ALUFlags(FlagsL));
ALU  #(.bits(4),.ALUControl(4'h9))SR(.ALUA(AR),.ALUB(BR),.ALUFlagIn(FlagInR),.ALUResult(ResultR),.ALUFlags(FlagsR));
initial begin
$dumpfile("wave_ALU.vcd");
$dumpvars(0,ALUTB); 
end
//---------------------------------------------------------------------------------------------------------------------------------

initial begin
//Adder
A=4'b1111;B=4'b1100;FlagIn=1'b0;
#10; A=4'b0111;B=4'b0001;FlagIn=1'b1;
#10; A=4'b1010;B=4'b1110;FlagIn=1'b0;
#10; A=4'b0011;B=4'b0100;FlagIn=1'b0;
#10; A=4'b1011;B=4'b0101;FlagIn=1'b0;
#10; A=4'b1001;B=4'b1111;FlagIn=1'b1;
#10; A=4'b1000;B=4'b1000;FlagIn=1'b0;
#10; A=4'b1000;B=4'b1000;FlagIn=1'b1;
#10; A=4'b0111;B=4'b0111;FlagIn=1'b0;
#10; A=4'b0111;B=4'b0111;FlagIn=1'b1;
#10; A=4'b0001;B=4'b0000;FlagIn=1'b1;
#10; A=4'b0011;B=4'b0011;FlagIn=1'b1;#10; 
end

initial begin
//Substractor
AS=4'b1111;BS=4'b1100;FlagInS=1'b0;
#10; AS=4'b0111;BS=4'b0001;FlagInS=1'b1;
#10; AS=4'b1010;BS=4'b1110;FlagInS=1'b0;
#10; AS=4'b0011;BS=4'b0100;FlagInS=1'b0;
#10; AS=4'b1011;BS=4'b0101;FlagInS=1'b0;
#10; AS=4'b1001;BS=4'b1111;FlagInS=1'b1;
#10; AS=4'b0110;BS=4'b0010;FlagInS=1'b0;
#10; AS=4'b0111;BS=4'b1001;FlagInS=1'b0;
#10; AS=4'b0111;BS=4'b1001;FlagInS=1'b1;
#10; AS=4'b1000;BS=4'b1000;FlagInS=1'b0;
#10; AS=4'b1000;BS=4'b1000;FlagInS=1'b1;#10; 
end

initial begin
//Incremento
AI=4'b0001;BI=4'b0111;FlagInI=1'b0;
#10;AI=4'b0001;BI=4'b0111;FlagInI=1'b1;
#10;AI=4'b1111;BI=4'b0111;FlagInI=1'b0;
#10;AI=4'b0001;BI=4'b0011;FlagInI=1'b1;
#10;AI=4'b1110;BI=4'b1100;FlagInI=1'b1;
#10;AI=4'b0100;BI=4'b0001;FlagInI=1'b0;
#10;AI=4'b1111;BI=4'b1000;FlagInI=1'b1;
#10;AI=4'b0011;BI=4'b0101;FlagInI=1'b0;
#10;AI=4'b0111;BI=4'b1001;FlagInI=1'b1;
#10;AI=4'b1001;BI=4'b1111;FlagInI=1'b0;
#10;AI=4'b1100;BI=4'b1010;FlagInI=1'b0;
#10;AI=4'b1000;BI=4'b0000;FlagInI=1'b1;#10;
end

initial begin
//Decremento
AD=4'b0001;BD=4'b0111;FlagInD=1'b0;
#10;AD=4'b0001;BD=4'b0111;FlagInD=1'b1;
#10;AD=4'b0001;BD=4'b0011;FlagInD=1'b1;
#10;AD=4'b1110;BD=4'b1100;FlagInD=1'b1;
#10;AD=4'b0100;BD=4'b0001;FlagInD=1'b0;
#10;AD=4'b1111;BD=4'b1000;FlagInD=1'b1;
#10;AD=4'b0011;BD=4'b0101;FlagInD=1'b0;
#10;AD=4'b0111;BD=4'b1001;FlagInD=1'b1;
#10;AD=4'b1001;BD=4'b1111;FlagInD=1'b0;
#10;AD=4'b1100;BD=4'b1010;FlagInD=1'b0;
#10;AD=4'b1000;BD=4'b0000;FlagInD=1'b1;
#10;AD=4'b0000;BD=4'b1000;FlagInD=1'b1;
#10;AD=4'b0000;BD=4'b1000;FlagInD=1'b0;#10; 
end
initial begin
//and
AA=4'b0001;BA=4'b0111;FlagInA=1'b0;
#10;AA=4'b0001;BA=4'b0111;FlagInA=1'b1;
#10;AA=4'b0001;BA=4'b0011;FlagInA=1'b1;
#10;AA=4'b1110;BA=4'b1100;FlagInA=1'b1;
#10;AA=4'b0100;BA=4'b0001;FlagInA=1'b0;
#10;AA=4'b1111;BA=4'b1000;FlagInA=1'b1;
#10;AA=4'b0011;BA=4'b0101;FlagInA=1'b0;
#10;AA=4'b0111;BA=4'b1001;FlagInA=1'b1;
#10;AA=4'b1001;BA=4'b1111;FlagInA=1'b0;
#10;AA=4'b1100;BA=4'b1010;FlagInA=1'b0;
#10;AA=4'b1000;BA=4'b0000;FlagInA=1'b1;
#10;AA=4'b0000;BA=4'b1000;FlagInA=1'b1;
#10;AA=4'b0000;BA=4'b1000;FlagInA=1'b0;#10; 
end
initial begin
//or
AO=4'b0001;BO=4'b0111;FlagInO=1'b0;
#10;AO=4'b0001;BO=4'b0111;FlagInO=1'b1;
#10;AO=4'b0001;BO=4'b0011;FlagInO=1'b1;
#10;AO=4'b1110;BO=4'b1100;FlagInO=1'b1;
#10;AO=4'b0100;BO=4'b0001;FlagInO=1'b0;
#10;AO=4'b1111;BO=4'b1000;FlagInO=1'b1;
#10;AO=4'b0011;BO=4'b0101;FlagInO=1'b0;
#10;AO=4'b0111;BO=4'b1001;FlagInO=1'b1;
#10;AO=4'b1001;BO=4'b1111;FlagInO=1'b0;
#10;AO=4'b1100;BO=4'b1010;FlagInO=1'b0;
#10;AO=4'b1000;BO=4'b0000;FlagInO=1'b1;
#10;AO=4'b0000;BO=4'b1000;FlagInO=1'b1;
#10;AO=4'b0000;BO=4'b1000;FlagInO=1'b0;#10; 
end
initial begin
//not
AN=4'b0001;BN=4'b0111;FlagInN=1'b0;
#10;AN=4'b0001;BN=4'b0111;FlagInN=1'b1;
#10;AN=4'b0001;BN=4'b0011;FlagInN=1'b1;
#10;AN=4'b1110;BN=4'b1100;FlagInN=1'b1;
#10;AN=4'b0100;BN=4'b0001;FlagInN=1'b0;
#10;AN=4'b1111;BN=4'b1000;FlagInN=1'b1;
#10;AN=4'b0011;BN=4'b0101;FlagInN=1'b0;
#10;AN=4'b0111;BN=4'b1001;FlagInN=1'b1;
#10;AN=4'b1001;BN=4'b1111;FlagInN=1'b0;
#10;AN=4'b1100;BN=4'b1010;FlagInN=1'b0;
#10;AN=4'b1000;BN=4'b0000;FlagInN=1'b1;
#10;AN=4'b0000;BN=4'b1000;FlagInN=1'b1;
#10;AN=4'b0000;BN=4'b1000;FlagInN=1'b0;#10; 
end

initial begin
//xor
AX=4'b0001;BX=4'b0111;FlagInX=1'b0;
#10;AX=4'b0001;BX=4'b0111;FlagInX=1'b1;
#10;AX=4'b0001;BX=4'b0011;FlagInX=1'b1;
#10;AX=4'b1110;BX=4'b1100;FlagInX=1'b1;
#10;AX=4'b0100;BX=4'b0001;FlagInX=1'b0;
#10;AX=4'b1111;BX=4'b1000;FlagInX=1'b1;
#10;AX=4'b0011;BX=4'b0101;FlagInX=1'b0;
#10;AX=4'b0111;BX=4'b1001;FlagInX=1'b1;
#10;AX=4'b1001;BX=4'b1111;FlagInX=1'b0;
#10;AX=4'b1100;BX=4'b1010;FlagInX=1'b0;
#10;AX=4'b1000;BX=4'b0000;FlagInX=1'b1;
#10;AX=4'b0000;BX=4'b1000;FlagInX=1'b1;
#10;AX=4'b0000;BX=4'b1000;FlagInX=1'b0;#10; 
end
initial begin
//shiftL
AL=4'b0001;BL=4'b0111;FlagInL=1'b0;
#10;AL=4'b0001;BL=4'b0111;FlagInL=1'b1;
#10;AL=4'b0001;BL=4'b0011;FlagInL=1'b1;
#10;AL=4'b1110;BL=4'b1100;FlagInL=1'b1;
#10;AL=4'b0100;BL=4'b0001;FlagInL=1'b0;
#10;AL=4'b1111;BL=4'b1000;FlagInL=1'b1;
#10;AL=4'b0011;BL=4'b0101;FlagInL=1'b0;
#10;AL=4'b0111;BL=4'b1001;FlagInL=1'b1;
#10;AL=4'b1001;BL=4'b1111;FlagInL=1'b0;
#10;AL=4'b1100;BL=4'b1010;FlagInL=1'b0;
#10;AL=4'b1000;BL=4'b0000;FlagInL=1'b1;
#10;AL=4'b0000;BL=4'b1000;FlagInL=1'b1;
#10;AL=4'b0000;BL=4'b1000;FlagInL=1'b0;#10; 
end
initial begin
//shiftR
AR=4'b0001;BR=4'b0111;FlagInR=1'b0;
#10;AR=4'b0001;BR=4'b0011;FlagInR=1'b1;
#10;AR=4'b0001;BR=4'b0001;FlagInR=1'b1;
#10;AR=4'b1110;BR=4'b0010;FlagInR=1'b1;
#10;AR=4'b0100;BR=4'b0001;FlagInR=1'b0;
#10;AR=4'b1111;BR=4'b0001;FlagInR=1'b1;
#10;AR=4'b0011;BR=4'b0011;FlagInR=1'b0;
#10;AR=4'b0111;BR=4'b0011;FlagInR=1'b1;
#10;AR=4'b1001;BR=4'b0011;FlagInR=1'b0;
#10;AR=4'b1100;BR=4'b0010;FlagInR=1'b0;
#10;AR=4'b1000;BR=4'b0000;FlagInR=1'b1;
#10;AR=4'b0000;BR=4'b1000;FlagInR=1'b1;
#10;AR=4'b1101;BR=4'b0010;FlagInR=1'b0;#10; 
 
end

endmodule


