`timescale 1us/10ns
module ContadorTB;

reg clk;

wire out1; 
reg reset1;


wire [3:0] out2; 
reg reset2;


wire [7:0] out3; 
reg reset3;



contador b(clk,reset1,out1);
contador #(.nbits(4))bb(clk,reset2,out2);
contador #(.nbits(8))bbb(clk,reset3,out3);
integer errores =0;

initial begin
$dumpfile("wave_Contador.vcd");
$dumpvars(0,ContadorTB); 
end

initial begin
clk=0;

forever
begin




clk=~clk; 




#10;






end
end


initial begin
reset1=1;
reset2=1;
reset3=1;
forever
begin

if (out1!=1)
reset1=0;
else
reset1=1;

if (out2!=3)
reset2=0;
else
reset2=1;


if (out3!=7)
reset3=0;
else
reset3=1; 

#1

if (out1==0)begin
if (reset1==0)
errores=errores+1;
end

if (out2==0)begin
if (reset2==0)
errores=errores+1;
end

if (out3==0)begin
if (reset3==0)
errores=errores+1;
end

#19;
end


end



initial begin
#500;
if (errores==0)
$display ("No hay errores");
else
$display ("Se encontraron","%d",errores," errores");
 $finish;
end
endmodule

