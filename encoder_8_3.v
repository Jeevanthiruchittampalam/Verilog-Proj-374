module encoder_8_3 (output reg [2:0] Code, input [7:0] Data);
	always @(Data)
	begin
		if (Data == 8'b00000001) Code = 0; else
		if (Data == 8'b00000010) Code = 1; else
		if (Data == 8'b00000100) Code = 2; else
		if (Data == 8'b00001000) Code = 3; else
		if (Data == 8'b00010000) Code = 4; else
		if (Data == 8'b00100000) Code = 5; else
		if (Data == 8'b01000000) Code = 6; else
		if (Data == 8'b10000000) Code = 7; else Code = 3'bx;
	end
	
	
endmodule
