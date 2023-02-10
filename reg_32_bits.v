`timescale 1ns/10ps

module reg_32_bits #(parameter qInitial = 0)(
	input wire clk,
	input wire clr,
	input wire enable,
	input wire [31:0] d,
	output reg [31:0] q
	
);

	initial q = qInitial;
	always@(posedge clk)
	begin
			if (clr) begin
						q[31:0] = 32'b0;
						
			end
			else if(enable) begin
						q[31:0] = d[31:0];
			end
			
	end
	
endmodule

