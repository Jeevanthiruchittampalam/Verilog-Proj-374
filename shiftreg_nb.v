~timescale 1ns/10ps

//4 bit serial shift register without blocking assignment operators '='

module shiftreg_nb(
output reg A,
input E, clk, rst);

reg B, C, D;

always @(posedge clk, posedge rst) begin
if (rst == 1'b1) begin A <= 0; B <=0; C <=0; D<=0; end
else begin 
A <=B;
B <= C;
C<=D;
D<=E;
end
end
endmodule
