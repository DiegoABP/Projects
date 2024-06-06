`timescale 1us/10ns
module BufferTB;
//Prueba 4 bits
reg [3:0] in,ina,inb,inc;
reg en,ena,enb,enc;
wire [3:0] out;

Buffer Bc(in,en,out);
Buffer BUc(ina,ena,out);
Buffer BUFc(inb,enb,out);
Buffer BUFFc(inc,enc,out);

//Prueba 8 bits
reg [7:0] ino,inao,inbo,inco;
reg eno,enao,enbo,enco;
wire [7:0] outo;
Buffer #(.bit(8))Bo(ino,eno,outo);
Buffer #(.bit(8))BUo(inao,enao,outo);
Buffer #(.bit(8))BUFo(inbo,enbo,outo);
Buffer #(.bit(8))BUFFo(inco,enco,outo);

//Prueba 16 bits
reg [15:0] ins,inas,inbs,incs;
reg ens,enas,enbs,encs;
wire [15:0] outs;
Buffer #(.bit(16))Bs(ins,ens,outs);
Buffer #(.bit(16))BUs(inas,enas,outs);
Buffer #(.bit(16))BUFs(inbs,enbs,outs);
Buffer #(.bit(16))BUFFs(incs,encs,outs);
initial begin
$dumpfile("wave_Buffer.vcd");
$dumpvars(0,BufferTB); 
end

integer i;
initial begin

in= 4'b0000;ina= 4'b0010;inb= 4'b1000;inc= 4'b0010;
en=0;ena=1;enb=0;enc=0;

ino= 8'b00000000;inao= 8'b01000000;inbo= 8'b00001100;inco= 8'b00010000;
eno=0;enao=0;enbo=1;enco=0;

ins= 16'b0000000000000000;inas= 16'b0000010000000000;inbs= 16'b0001100000000000;incs= 16'b0000000000111000;
ens=1;enas=0;enbs=0;encs=0;




for(i=0; i<51; i=i+1)begin
	
	enc=en;en=ena;ena=enb+i;enb=enc;
	in=in+1;
	ina=ina+1;
	inb=inb+1;
	inc=inc+1;
	

	enco=eno;eno=enao;enao=enbo+i;enbo=enco;
	ino=ino+1;
	inao=inao+1;
	inbo=inbo+1;
	inco=inco+1;
	
	encs=ens;ens=enas;enas=enbs+i;enbs=encs;
	ins=ins+1;
	inas=inas+1;
	inbs=inbs+1;
	incs=incs+1;
	
	#2;
end
en=0;ena=0;enb=0;enc=0;eno=0;enao=0;enbo=0;enco=0;ens=0;enas=0;enbs=0;encs=0;
in=in+1;
ina=ina+1;
inb=inb+1;
inc=inc+1;
ino=ino+1;
inao=inao+1;
inbo=inbo+1;
inco=inco+1;
ins=ins+1;
inas=inas+1;
inbs=inbs+1;
incs=incs+1;
	
end
endmodule
