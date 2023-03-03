module MDR_register (
input clk, clr, MDR_read, MDR_enable,
input [31:0] BusMuxOut, MDataIn,  //BusMuxOut is from bus, MDataIn is from memory chip
output wire [31:0] Q
);

wire [31:0] S; //connects the 2_to_1 multiplexer to the register

multiplexer_2_to_1 my_MDR_Multiplexer(

	.inputOne(BusMuxOut),
	.inputTwo(MDataIn),
	.signal(MDR_read),
	.out(S)
);

general_register my_MDR_register(
	.enable(MDR_enable),
	.clk(clk),
	.clr(clr),
	.D(S),
	.Q(Q)
);

endmodule

