module R0_register(
	input enable, clk, clr,
	input [31:0] D,
	input BAout,
	output reg[31:0] Q
);

reg [31:0] connector;

	initial Q = 0;
	
	always @(posedge clk)
	begin
			if(clr) begin
						connector[31:0] = 32'b0;
						end
						
				else if(enable) begin
						
						 connector[31:0] = D[31:0];
						
						end
				
				Q[31:0] = connector[31:0] & ~{32{BAout}};
				end
				
			 
endmodule
