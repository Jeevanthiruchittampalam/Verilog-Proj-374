module program_counter_register (
	input wire write, increment, clk, clr,
	input [31:0] D,
	output reg [31:0] Q
);

initial Q = 0;

always @(posedge clk)

begin

		if(clr)
					Q = 0;
		else if(write)
					Q = D;
					
			else if (increment)
					Q = Q + 1;
					
			end
endmodule
