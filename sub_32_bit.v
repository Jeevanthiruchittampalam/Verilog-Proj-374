`timescale 1ns / 1ps

module sub_32_bit(input wire [31:0] Ra, input wire [31:0] Rb, input wire cin, output wire [31:0] sum, output wire cout);
	wire [31:0] tempValue; 
	
	add_32_bit add(.Ra(Ra), .Rb(~Rb+1),.cin(cin),.sum(sum),.cout(cout));
endmodule