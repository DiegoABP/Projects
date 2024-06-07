`timescale 1ns / 1ps
// MODELO DE COMPORTAMIENTO - NO SINTETIZABLE!!!

/*
SPI modo 1, datos muestreados en el flanco negativo, datos colocados en el flanco positivo
Clock en cero durante estado "idle"

MSB primero!
*/
module SPI_MEM(input CLK,CS,MOSI, output MISO);
    reg [4:0] conta;
    reg [7:0] regIn;
    reg [31:0] regOut;
    reg [7:0] address;
    3:00 09/06/2021
    reg [31:0] MATRIX [255:0];
    reg MISO_aux;
    initial begin
        $readmemh("SPIContent.mem", MATRIX); //cargar contenido de archivo de memoria
        regIn=0;//inicializar variables
        conta=0;
        address=0;
        regOut=0;
    end    
    
    //salida de datos
    //MSB primero
    always @(posedge CLK or posedge CS) begin
        if(CS) begin
            regOut<=0;
            MISO_aux<=0;
        end else begin
            MISO_aux<=regOut[31];
            regOut<={regOut[30:0],1'b0};
        end
    end
    
    //Captura de dirección en los primeros 8 bits
    //MSB primero!
    always @(negedge CLK or posedge CS) begin
        if(CS) begin
            regIn<=0;
            conta<=0;
        end else begin 
            if(conta<7) begin
                conta<=conta+1;
                regIn<={regIn[6:0],MOSI};
            end if(conta==7) begin
                conta<=8;
                address<={regIn[6:0],MOSI};
                regOut<=MATRIX[{regIn[6:0],MOSI}];//extraer el dato de la matriz de memoria
            end 
        end
    end
    assign #20 MISO=MISO_aux; //retardo de 20ns para agregar un poco de realismo
endmodule
