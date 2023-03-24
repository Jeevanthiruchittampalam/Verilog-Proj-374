module select_and_encode(
				input [31:0] instruction,
			   input Gra,
			   input Grb,
			   input Grc,
				input Rin, 
				input Rout,
				input BAout,
				output [31:0] Cdata,
				output[15:0] ctrl_in, ctrl_out);
				
				
				wire[3:0] ra, rb, rc, decoder_in;
				//assign ra = instruction[26:23];
				//assign rb = instruction[22:19];
				//assign rc = instruction[18:15];
				
				//assign decoder_in = Gra ? ra :
											//Grb ? rb : 
											//Grc ? rc: 
											//4'b0000;
				assign decoder_in = (instruction[26:23]&{4{Gra}}) | (instruction[22:19]&{4{Grb}}) | (instruction[18:15]&{4{Grc}});
											
											
				wire[15:0] decoder_out;
				decoder_4_to_16 y(decoder_in, decoder_out);
				
				wire Rout_en;
				assign Rout_en = BAout | Rout;
				assign ctrl_in = Rin ? decoder_out : 16'b0; 
				assign ctrl_out = Rout_en ? decoder_out : 16'b0; 
											
				assign Cdata = (instruction[18] == 1) ? {{13{1'b1}}, instruction[18:0]} : {13'b0, instruction[18:0]};
											
				endmodule
				
				

