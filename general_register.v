module general_register(
	input enable, clk, clr,
	input [31:0] D,
	output reg[31:0] Q
);

	initial Q = 0;
	
	always @(posedge clk)
	begin
			if(clr) begin
						Q[31:0] = 32'b0;
						end
						
				else if(enable) begin
						
						Q[31:0] = D[31:0];
						
						end
				
				end
endmodule
