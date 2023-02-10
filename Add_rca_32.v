module Add_rca_32 (output c_out, output [31:0] sum, input [31:0] a, b, input c_in);
	wire [31:0] c_in16;
	Add_rca_16 M1 (c_in16, sum[15:0], a[15:0], b[15:0], c_in);
	Add_rca_16 M2 (c_out, sum[31:16], a[31:16], b[31:16], c_in16);
	
endmodule
