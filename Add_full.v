`timescale 1ns/10ps
module Add_full (output c_out, sum, input a, b, c_in);
	wire w1, w2, w3;
	
	Add_half M1(w2, w1, a , b);
	Add_half M2(w3, sum, c_in, w1);
	or (c_out, w3, w2);
	
endmodule
