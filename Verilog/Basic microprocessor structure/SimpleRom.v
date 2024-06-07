// MODELO DE COMPORTAMIENTO - NO SINTETIZABLE!!!

`timescale 1ns/1ps
module SimpleRom(input [31:0]A, output [31:0]Do);
    reg [31:0] MATRIX [14:0];
    
    initial begin
        $readmemb("rom_content_t.mem", MATRIX); //cargar contenido de archivo de memoria
    end    
    
    assign #25 Do = MATRIX[A]; //simulando 25ns de retraso (un poco más real)
    
endmodule


