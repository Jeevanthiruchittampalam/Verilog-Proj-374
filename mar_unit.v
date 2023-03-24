module mar_unit(
	input wire MARin,	
	input wire clk, 
	input wire rst,
	input wire [31:0] bus_contents,
	output [8:0] q
);
		
	wire [31:0] MAR_data_out;
	
	general_register MAR(MARin, clk, rst, bus_contents, MAR_data_out);
	
	assign q = MAR_data_out[8:0];
	
endmodule