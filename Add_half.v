`timescale 1ns/10ps

module Add_half (output c_out, sum, input a, b);
	xor (sum, a, b);
	and (c_out, a, b);
endmodule
