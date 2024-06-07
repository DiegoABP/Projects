// MODELO DE COMPORTAMIENTO - NO SINTETIZABLE!!!

`timescale 1ns/1ps
module SimpleRam(input [31:0]A, input [31:0] Di, input WR);
    reg [31:0] MATRIX [63:0];
    
    initial begin
        $readmemh("ram_ceros.mem", MATRIX); //cargar contenido de archivo de memoria
    end
    
    always @(*) begin
        if(WR==1)  MATRIX[A]=Di; //25ns de retardo de escritura
    end
    
     
endmodule
