module BusMultiplexado(in1,in2,in3,in4,sel);
parameter BUS_WIDTH = 4;
output reg out;
input reg [BUS_WIDTH-1:0] in1,in2,in3,in4;
input [1:0] sel;
always@(sel or a or b or c or d)
begin
	case(sel)
		2'b00: out = a;
		2'b01: out = b;
		2'b10: out = c;
		2'b11: out = d;
	endcase
end
endmodule




