/*~timescale 1ns/10ps

module t_Add_half();
	wire sum, c_out;
	reg a,b;
	Add_half M1 (c_out, sum, a, b);
	initial begin
	#100 $finish;
	end
	initial begin
	#10 a = 0; b = 0;
	#10 b = 1;
	#10 a = 1;
	#10 b = 0;
	end
endmodule

*/