module contador(clk,reset,data);

parameter nbits = 2;
input wire clk;
input wire reset;
output reg [nbits-1:0] data = 0;  

always @(posedge clk) 
begin
if (reset==0)	begin
  data <= data + 1;
end
else begin
data=0;
end
end
endmodule
