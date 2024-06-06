module MuxP (    input         in_bus, input       sel, output                   out);
parameter  WIDTH    = 8;
parameter  CHANNELS = 4;

integer i;


reg      input_array ;
assign  out = input_array;
always @*
    for(i=0; i<CHANNELS; i=i+1)
        input_array = in_bus;
function integer clogb2;
  input depth;
  integer i,result;
  begin
    for (i = 0; 2 ** i < depth; i = i + 1)
      result = i + 1;
    clogb2 = result;
  end
endfunction
endmodule
