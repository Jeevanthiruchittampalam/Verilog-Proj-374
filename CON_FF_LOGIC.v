
module CON_FF_LOGIC (
input[31:0] instruction,
input signed [31:0] bus,
input CONin, clk, 
output out

);

wire [3:0] con_en;
decoder_2_to_4 dec(instruction[20:19], con_en);

wire eval, eq, neq, gte, lt;

assign eq = ((bus == 0) & con_en[0]) ? 1'b1 : 1'b0;
assign neq = ((bus != 0) & con_en[1]) ? 1'b1 : 1'b0;
assign gte = ((bus >= 0) & con_en[2])  ? 1'b1 : 1'b0;
assign lt = ((bus <+0) & con_en[3]) ? 1'b1 : 1'b0;

assign eval = eq | neq | gte | lt;
s_ff_logic ff(eval, clk, 1'b0, CONin, out);

endmodule 


module s_ff_logic(
	input enable, clk, clr,
	input D,
	output reg Q
);

	initial Q = 0;
	
	always @(posedge clk)
	begin
			if(clr) begin
						Q = 1'b0;
						end
						
				else if(enable) begin
						
						Q = D;
						
						end
				
				end
endmodule



//ir inputs, bus inputs, 


