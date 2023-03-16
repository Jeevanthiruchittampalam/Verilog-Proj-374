module CPU_ALU_2(

input clk,
input signed [31:0] A, //input coming from bus
input wire[31:0] B, //temporary register to hold B value. Coming from YData! 
//input wire[31:0] Y, //temporary register to hold A value

input wire [4:0] opcode,

output reg [63:0] C_register
//output reg[31:0] HIGH_ALU_OUTPUT,
//output reg[31:0] LOW_ALU_OUTPUT

);

reg[31:0] RLo, RHi; //results
//reg prod[63:0];


wire [31:0] ror_res, rol_res;
rotate_right ror(ror_res, A, B);
rotate_left rol(rol_res, A, B);

wire [63:0] mult_res;
multiplier_ALU mult(A, B, mult_res);

//dision
wire[31:0] div_res, remainder;
wire ready;
reg sign = 0;
divider div(A, B, div_res);

//module divider(clk, reset, Dividend, Divisor, Quotient, Remainder);

//addition time
wire [31:0] adder_sum;
wire adder_cout; 

add_32_bit ANDER(.Ra(A), .Rb(B), .cin(1'd0), .sum(adder_sum), .cout(adder_cout));

//SUBtraction
wire[31:0] sub_sum;
wire sum_cout;

sub_32_bit SUBBER(.Ra(A),.Rb(B),.cin(1'd0), .sum(sub_sum),.cout(sum_cout));




	always @(*) begin
	
        RLo <= 32'h1;
        RHi <= 32'h1;
	
			case(opcode)
			
					5'b00001: begin //Addition 
							RLo <= adder_sum[31:0];
							//RLo <= A + B; 
							RHi <= 32'b0;
						end 
					
					5'b00010: begin //Subtraction
						RLo <= sub_sum[31:0];
						RHi <= 32'b0;
						end
						
					5'b00011: begin // Multiplication
						RLo <= mult_res[31:0];
						RHi <= mult_res[63:32];
						end 
						
					5'b00100: begin //Division
						RHi <= div_res[31:0];
						RLo <= div_res[31:0];
						//RLo<=A/B;
						//RHi<=32'b0;
						end
						
					5'b00101: begin //AND
						RLo <= A & B;
						RHi <= 32'b0;
						end
						
					5'b00110: begin //OR
						RLo <= A | B;
						RHi <= 32'b0;
						end
						
					5'b00111: begin //NEG
						RLo <= ~B + 1;
						RHi <= 32'b0;
						end
						
					5'b01000: begin //NOT
						RLo <= ~B;
						RHi <= 32'b0;
						end
						
					5'b01001: begin //SHRA
						RLo <= $signed(A) >>> B;
						RHi <= 32'b0;
						end 
						
					5'b01010: begin //SHL
						RLo <= A << B;
						RHi <= 32'b0;
						end 
						
					5'b01011: begin //SHR
						RLo <= A >>> B;
						RHi <= 32'b0;
						end
						
					5'b01100: begin //ROL
						RLo <= rol_res;
						RHi <= 32'b0;
						end
							
					5'b01101: begin//ROR
						RLo <= ror_res;
						RHi <= 32'b0;
						end 
						
					5'b01110: begin //INCPC
						RLo <= B + 1;
						RHi <= 32'b0;
						
					default: 
						C_register[63:0] = 64'b0;
				endcase
					//RHi <= 32'b1;
					C_register[63:32] = RHi;
					C_register[31:0] = RLo;
		
		end

endmodule
