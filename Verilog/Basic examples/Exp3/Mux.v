module mux_4x1(a,b,c,d,sel,out);
parameter WIDTH = 16;
output reg [WIDTH-1:0]out;
input [WIDTH-1:0]a,b,c,d;
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
