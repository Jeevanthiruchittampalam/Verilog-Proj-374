module z_register_64_bits(
input ZIn, ZLowSelect, ZHighSelect, clk, clr,
//Zin is enable, ZLow/High Select selects which is outputted
input[63:0] D,
output reg [31:0] ZHighDataOut, ZLowDataOut

);

	always @(posedge clk)
			if(clr) begin
						ZHighDataOut = 32'h00000000;
						ZLowDataOut = 32'h00000000;
					end
					
			else if(ZIn) begin
					if(ZLowSelect)
							ZLowDataOut = D[31:0];
							
					else if(ZHighSelect)
							ZHighDataOut=D[63:32];
							
					end
					
endmodule

