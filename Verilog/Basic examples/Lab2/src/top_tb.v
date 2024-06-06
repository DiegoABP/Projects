`timescale 1us/10ns //el timescale se escoge apropiadamente al sistema
//`timescale 1ns/1ps

module top_tb;

//variables "independientes" --> las modifico en el testbench
reg [3:0]in1,in2,in3,in4;
reg [1:0]en;

wire [3:0]out;

top uu(.in1(in1),.in2(in2),.in3(in3),.in4(in4), .en(en), .out(out));

initial begin
$dumpfile("wave_top_tb.vcd"); //Crear el archivo vcd

$dumpvars(0,top_tb); //Seleciona todas las variables en el diseño
//$dumpvars(1,top_tb); //variables solo en el primer nivel jerárquico
//$dumpvars(2,top_tb); //vriables hasta el segindo nivel jerárquico

//$dumpvars(0, top_tb.uu); //un bloque específico
//$dumpvars(1, top_tb.uu); //un bloque específico
//$dumpvars(1, top_tb.uu.u0.a); //una variable específica

end

initial begin
	en=0;
	forever begin //corre por siempre!
		#10 en=en+1;
	end
end

initial begin
	$display("****************************************************");
	$display(" --- Inicio de la simulacion -----------------------");
	$display("****************************************************");
	in1= 4'b1010;
	in2= 4'he;
	in3= 4'd5;
	in4= 12;
	#40
	in1=in1+1;
	in2<=in2+1;
	$display("Usando $display T=%0t in1=0x%0h in2=0x%0h", $time, in1,in2);
	$strobe("Usando $display T=%0t in1=0x%0h in2=0x%0h", $time, in1,in2);
	#10
	$display("Usando $display T=%0t in1=0x%0h in2=0x%0h", $time, in1,in2);
	$strobe("Usando $display T=%0t in1=0x%0h in2=0x%0h", $time, in1,in2);
	#100
	in3=in3+1;
	#140
	in4=in4+1;
	#200 
	$display("****************************************************");
	$display(" --- Fin de la simulacion --------------------------");
	$display("****************************************************");
	$finish;
end

initial begin
	$monitor("Usando $monitor in3=0x%0h, in4=0x%0h", in3, in4);
end

endmodule
