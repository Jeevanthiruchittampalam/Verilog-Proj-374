`timescale 1ns/10ps

//code for the alu

module ALU(


//ports

  input clk, clr,
  input wire [31:0] a,
  input wire [31:0] b,
  input wire [31:0] y,
  //for operator, can't be 4 bits because there could be
  //more than 16 functions
  input wire [4:0] opcode,
  //output is 64 bits to allow for a wider variety of operations
  output reg [63:0] C_Register
  
  

);

  wire [31:0] carry; //for adder
  wire addtemp;
  wire subtemp;
  wire multtemp;
  wire divtemp;

//Define operations

localparam ALU_OP_AND = 5'b00000;
localparam ALU_OP_OR = 5'b00001;
localparam ALU_OP_SHR = 5'b00010;
localparam ALU_OP_SHL = 5'b00011;
localparam ALU_OP_XOR = 5'b00100;
localparam ALU_OP_NOT = 5'b00101;
localparam ALU_OP_SHRX = 5'b00110;
localparam ALU_OP_SHLX = 5'b00111;
localparam ALU_OP_SHRA = 5'b01000;
localparam ALU_OP_ROR = 5'b01001;
localparam ALU_OP_ROL = 5'b01010;
localparam ALU_OP_NEG = 5'b01011;
localparam ALU_OP_NAND = 5'b01110;
localparam ALU_OP_NOR = 5'b01111;
localparam ALU_OP_XNOR = 5'b10000;
localparam ALU_OP_ADD = 5'b10001;
localparam ALU_OP_SUB = 5'b10010;
localparam ALU_OP_MUL = 5'b10011;
localparam ALU_OP_DIV = 5'b10100;


//Add_rca_32 (output c_out, output [31:0] sum, input [31:0] a, b, input c_in);

Add_rca_32 my_32_add(
	.c_in(32'd0),
	.a(a),
	.b(b),
	.sum(addtemp),
	.c_out(carry)
);

sub_rca_32 my_32_sub(
	.c_in(32'd0),
	.a(a),
	.b(b),
	.sum(subtemp),
	.c_out(carry)
);

//module Booth_Mult_32 (output [63:0] product, input [31:0] a, b);
Booth_Mult_32 my_32_mult(
	.a(a),
	.b(b),
	.product(multtemp)
);

divider my_32_divider(
	.clk(clk),
	.rst(clr),
	.dividend(a),
	.divisor(b),
	.quotient(divtemp)
);
 

//Choose operation based on 'op' input

always@(*) begin
	//setting result to 0 by default, and the 0 flag to 0 by default
	//zero_flag = 1'b0;

	case(opcode)
		ALU_OP_AND: C_Register = a & b;
		ALU_OP_OR: C_Register = a | b;
		ALU_OP_XOR: C_Register = a ^ b;
		ALU_OP_NOT: C_Register = ~a;
		ALU_OP_SHR: C_Register = a>>1;
		ALU_OP_SHL: C_Register = a<<1; 
		ALU_OP_SHRA: C_Register = a>>b;
		ALU_OP_ROR: C_Register = {a[31:1],a[0]};
		ALU_OP_ROL: C_Register = {a[0], a[31:0]};
		ALU_OP_NEG: C_Register = ~a + 1'b1;
		ALU_OP_NOR: C_Register = ~(a | b);
		ALU_OP_NAND: C_Register = ~(a & b);
		ALU_OP_XNOR: C_Register = ~(a ^ b);
		ALU_OP_ADD: C_Register = addtemp;
		ALU_OP_SUB: C_Register = subtemp; 
		ALU_OP_MUL: C_Register = multtemp;
		ALU_OP_DIV: C_Register = divtemp;
		
		
		default: C_Register = 32'b0;
		
	endcase
	
	
	//If the output is 0, set the 0 flag to 1. this 
	//information can be used by other parts of the system to make decisions, such as whether to take a certain branch in a program or not,
	//based on the outcome of the ALU
	
	//if (C_Register == 32'b0) zero_flag = 1'b1;
	
end

//Update zero flag based on result?

endmodule




