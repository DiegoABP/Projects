`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.04.2021 02:25:52
// Design Name: 
// Module Name: Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Top(
    input [31:0] AT,
    input [31:0] BT,
    input ModoT,
    input BotonT,
    input clk,
    output reg [31:0] ResultadoT=0,
    output reg [3:0]led 
    );
    wire [3:0] enT;
    wire  cambioT;
    
    wire [31:0] numT,numrT,numsT;
    wire FSenal,cmpT;
    reg [31:0] cmpTO;
    //Variables señal del boton
    reg BAnT = 0;
    wire BotonsT,BSiT;
    //Contador de las operaciones
    reg [3:0]i=0;
    reg [2:0]j=0;
 
   Senal ST(.BAc(BotonT),.clk(clk),.cambio(cambioT),.BAn(BAnT),.BSi(BSiT),.Botons(BotonsT));
   Maquina_de_Estados MT(.Boton(BotonsT),.Modo(ModoT),.clk(clk),.Op(i),.en(enT),.cambio(cambioT));
   Sumador SuT(.A(AT),.B(BT),.en(enT),.outcomp(cmpT),.num(numT),.numr(numrT),.numsO(numsT)); 
    
always @(posedge clk)begin
led=enT;
if (cmpT==1)
cmpTO=32'b00000000000000000000000000000001;
else
cmpTO=32'b00000000000000000000000000000000;
if (ModoT) begin
    if (cambioT)begin
    case (i)
                3'b000: ResultadoT = cmpTO;
                3'b001: ResultadoT = numrT;
                3'b010: ResultadoT = numsT;
                3'b011: ResultadoT = numT;
    
    endcase
    i=i+1;
end
end
if (!ModoT)begin
    
    case (i)
                3'b001: ResultadoT = cmpTO;
                3'b010: ResultadoT = numrT;
                3'b011: ResultadoT = numsT;
                3'b100: ResultadoT = numT;
    
    endcase
    i=i+1;
    end



BAnT = BSiT;
if (i == 3'b110)begin
ResultadoT='b0;
i=0;
end
end
endmodule
