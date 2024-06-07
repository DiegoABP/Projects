`timescale 1ns/1ps
module PROCESSOR(
    input clk, rst, //reloj de 2Mhz, reset (activo en bajo)
    output [31:0] ProgAddress, input [31:0] ProgIn,  //Bus de dirección y datos de entrada para programa (desde ROM)
    output [31:0] DataAddress, //Bus de dirección para lado de Datos
	input [31:0] DataIn,   //Bus de datos de entrada desde lado de Datos
	output [31:0] DataOut, //Bus de datos de salida hacia lado de Datos
	output wr //Bit de escritura para lado de Datos.
    );
   wire [4:0] rs1;
   wire  [4:0] rs2;
   wire  [4:0] rd;
   wire  [20:0] inm; 
   wire  [11:0] off;
   wire  [6:0] OpI;
   wire  [31:0] ins;
   wire [31:0] r1d;
   wire  [31:0] r2d;
   reg  [31:0] datard;
   wire  [31:0] resALU;
   wire  z;
   wire  [1:0]sel;
   wire  we;
   wire [2:0] ALUop;
   wire  [31:0] ResI;
   wire [31:0] PCOffset;
   wire [31:0] PC;
   wire [3:0] enp;
   reg [7:0] S;
   
    MainFSM fsm(.OpI(OpI),.en(enp),.clk(clk),.datain(ProgIn),.S(S),.ins(ins),.sel(sel),.ALUop(ALUop));
    ProgramCounter prc(.en(enp),.Pcp(PCOffset),.S(S),.clk(clk),.rst(rst),.z(z),.PC(ProgAddress));
    Deco dec(.en(enp),.Entrada(ins),.clk(clk),.ORegistro1(rs1),.ORegistro2(rs2),.ORegistroD(rd),.OpI(OpI),.inmediato(inm),.Offset(off));
    RegisterFile register(.en(enp),.clk(clk), .address1(rs1),.address2(rs2),.address3(rd),.enw(we),.r3(datard),.r1d(r1d),.r2d(r2d));
    OpInmediatas op(.en(enp),.OpI(OpI),.clk(clk),.inmediato(inm),.Offset(off),.ResI(ResI),.PCOffset(PCOffset));
    ALU alu(.en(enp),.a(r1d),.b(r2d),.control(ALUop),.result(resALU),.z(z));
    Selector slc(.en(enp),.rd1(r1d),.rd2(r2d),.r3(datard),.ALUr(resALU),.ResI(ResI),.sel(sel),.clk(clk),.we(we),.wem(wr),.address(DataAddress),.dataout(DataOut));
 
    always @(posedge clk) begin 
    if (ProgAddress==0 && rst==0 ) begin 
        S = 8'b00000001; 
    end
    else begin  
        case(OpI)
            //add
            7'b0110011: begin 
            datard=DataOut;
            end
            //lw
            7'b0000011: begin datard=DataIn;
            end
        endcase
        case (enp)
            4'b0001: begin S= 8'b00000010; end
            4'b0010: begin S= 8'b00000100; end
            4'b0100: begin S= 8'b00001000; end
            4'b1000: begin S= 8'b00000001; end
        endcase
    end
    end
endmodule