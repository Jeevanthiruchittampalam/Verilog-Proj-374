`timescale 1ns/10ps

module 32_CLA(sum, c_4, A, B, C_0);
input [32:0]A,B;
input c_0;
output [32:0] sum;
output c_4;
wire p0,p1,p2,p3, g0,g1,g2,g3;
wire c1,c2,c3,c4;

p0= A[0]^B[0];
p1=A[1]^B[1];
p2=A[2]^B[2];
p3=A[3]^B[3];

g0 = A[0]&B[0];
g1=A[1]&B[1];
g2=A[2]&B[2];
g3=A[3]&B[3];


assign
c1 = g0 | (p0 & c_0),
c2 = g1 | (p1 & g0) | (p1 & p0 & c_0),
c3 = g2 | (p2 & g1) | (p2 & p1 & g0) | (p2 & p1 & p0 & c_0),
c4 = g3 | (p3 & g2) | (p3 & p2 & p1 & g1) | (p3 & p2 & p1 & g0) | (p3 & p2 & p1 & p0 & c_0);

assign

sum[0] = p0^c_0,
sum[1] = p1^c1,
sum[2] = p2^c2,
sum[3] = p3^c3,
c_4 = c4;

endmodule
