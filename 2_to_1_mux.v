`timescale 1ns/10ps

module 2_to_1_mux (
input wire [31:0] inputOne, 
input wire {31:0] inputTwo, 
input wire signal, 
output reg [31:0] out
);

always@(*)begin
			if (signal) begin
				out[31:0] <= inputTwo[31:0];
				
			end
			else begin
				out[31:0] <= inputOne[31:0]
			end
			
	end
	
endmodule
