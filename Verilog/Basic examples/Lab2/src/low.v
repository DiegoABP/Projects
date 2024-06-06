`timescale 1ns/1ps

module low(a,b,c,d,sel,q);

input a,b,c,d;
input [1:0] sel;

output q;

wire s1n, s0n;

wire y0,y1,y2,y3;

not u0(s1n,sel[1]);
not u1(s0n,sel[0]);

and u2(y0,a,   s1n,s0n   );
and u3(y1,b,   s1n,sel[0]);
and u4(y2,c,sel[1],s0n   );
and u5(y3,d,sel[1],sel[0]);

or u6(q,y0,y1,y2,y3);

endmodule
