//This ones makes a bit more sense

`timescale 1ns/10ps
module ctrl_unit(
	output reg Gra, Grb, Grc, Rin, Rout, MDRin, MDRout, BAout, Cout, ZLowout, PCin, IRin,
	output reg HIout, LOout, InPortout, OPin, LOin, ZHighout, HIin, Yin, Zin, PCout,
	output reg IncPC, MARin, read, wren, clr, conffin, Run,
	output  reg [3:0] ALUselect,
	input [31:0] IR,
	input clk, reset, stop, conffout
); 

parameter	
	reset_state = 7'b0000000, 
	fetch0 = 7'b0000001, 
	fetch1 = 7'b0000010, 
	fetch2 = 7'b0000011,
	ld = 7'b0000100,
	ld2 = 7'b0000101,
	ld3 = 7'b0000110,
	ld4 = 7'b0000111,
	ld5 = 7'b0001000,
	ldi = 7'b0001001,
	ldi2 = 7'b0001010,
	ldi3 = 7'b0001011,
	st = 7'b0001100,
	st2 = 7'b0001101,
	st3 = 7'b0001110,
	st4 = 7'b0001111,
	st5 = 7'b0010000,
	addi = 7'b0010001,
	addi2 = 7'b0010010,
	addi3 = 7'b0010011,
	ori = 7'b0010100,
	ori2 = 7'b0010101,
	ori3 = 7'b0010110,
	andi = 7'b0010111,
	andi2 = 7'b0011000,
	andi3 = 7'b0011001,
	br = 7'b0011010,
	br2 = 7'b0011011,
	br3 = 7'b0011100,
	br4 = 7'b0011101,
	jr = 7'b0011110,
	jal = 7'b0011111,
	jal2 = 7'b0100000,
	mfhi = 7'b0100001,
	mflo = 7'b0100010,
	in = 7'b0100011,
	out = 7'b0100100,
	add = 7'b0100101,
	add2 = 7'b0100110,
	add3 = 7'b0100111,
	add4 = 7'b0101000,
	sub = 7'b0101001,
	sub2 = 7'b0101010,
	sub3 = 7'b0101011,
	sub4 = 7'b0101100,
	shr = 7'b0101101,
	shr2 = 7'b0101110,
	shr3 = 7'b0101111,
	shr4 = 7'b0110000,
	shr5 = 7'b0110001,
	shl = 7'b0110010,
	shl2 = 7'b0110011,
	shl3 = 7'b0110100,
	shl4 = 7'b0110101,
	shl5 = 7'b0110110,
	ror = 7'b0110111,
	ror2 = 7'b0111000,
	ror3 = 7'b0111001,
	ror4 = 7'b0111010,
	ror5 = 7'b0111011,
	ror6 = 7'b0111100,
	rol = 7'b0111101,
	rol2 = 7'b0111110,
	rol3 = 7'b0111111,
	rol4 = 7'b1000001,
	rol5 = 7'b1000010,
	rol6 = 7'b1000011,
	or1 = 7'b1000100,
	or2 = 7'b1000101,
	or3 = 7'b1000110,
	and1 = 7'b1000111,
	and2 = 7'b1001000,
	and3 = 7'b1001001,
	mul = 7'b1001010,
	mul2 = 7'b1001011,
	mul3 = 7'b1001100,
	mul4 = 7'b1001101,
	mul5 = 7'b1001110,
	div = 7'b1001111,
	div2 = 7'b1010000,
	div3 = 7'b1010001,
	div4 = 7'b1010010,
	neg = 7'b1010011,
	neg2 = 7'b1010100,
	neg3 = 7'b1010101,
	not1 = 7'b1010110,
	not2 = 7'b1010111,
	not3 = 7'b1011000,
	nop = 7'b1011001,
	nop2 = 7'b1011010,
	halt = 7'b1011011,
	halt2= 7'b1011100;
			
	reg[6:0] Present_state =reset_state;
	
always @(posedge clk, posedge reset)
	begin
		if(reset) #40 Present_state = reset_state;
		else if(stop) #40 Present_state = halt;
		else case(Present_state)
			reset_state		:		#40 Present_state=fetch0;
			fetch0			:		#40 Present_state=fetch1;
			fetch1			:		#40 Present_state=fetch2;
			fetch2			:		#40 
			
			begin	
				case(IR[31:27])	
					5'b00000	:	Present_state=ld;
					5'b00001 :	Present_state=ldi; 
					5'b00010	:	Present_state=st;
					5'b00011	:	Present_state=add;
					5'b00100	:	Present_state=sub;
					5'b00101	:	Present_state=shr;
					5'b00110	:	Present_state=shl;
					5'b00111	:	Present_state=ror;
					5'b01000	:	Present_state=rol;
					5'b01001	:	Present_state=and1;
					5'b01010	:	Present_state=or1;
					5'b01011	:	Present_state=addi;
					5'b01100	:	Present_state=andi;
					5'b01101	:	Present_state=ori;
					5'b01110	:	Present_state=mul;
					5'b01111	:	Present_state=div;
					5'b10000	:	Present_state=neg;
					5'b10001	:	Present_state=not1;
					5'b10010	:	Present_state=br;
					5'b10011	:	Present_state=jr;
					5'b10100	:	Present_state=jal;
					5'b10101	:	Present_state=in;
					5'b10110	:	Present_state=out;
					5'b10111	:	Present_state=mfhi;
					5'b11000	:	Present_state=mflo;
					5'b11001	:	Present_state=nop;
					5'b11010	:	Present_state=halt;	
				endcase
			end
			
			//ld						
			ld			:		#40 Present_state=ld2;
			ld2		:		#40 Present_state=ld3;
			ld3		:		#40 Present_state=ld4;
			ld4		:		#40 Present_state=ld5;
			ld5		:		#40 Present_state=reset_state; 
			
			//ldi
			ldi		:		#40 Present_state=ldi2;
			ldi2		:		#40 Present_state=ldi3;
			ldi3		:		#40 Present_state=reset_state; 
			
			//st
			st			:		#40 Present_state=st2;
			st2		:		#40 Present_state=st3;
			st3		:		#40 Present_state=st4;
			st4		:		#40 Present_state=st5;
			st5		:		#40 Present_state=reset_state; 
			
			//addi			
			addi		:		#40 Present_state=addi2;
			addi2		:		#40 Present_state=addi3;
			addi3		:		#40 Present_state=reset_state; 
			
			//ori
			ori		:		#40 Present_state=ori2;
			ori2		:		#40 Present_state=ori3;
			ori3		:		#40 Present_state=reset_state; 
				
			//andi
			andi		:		#40 Present_state=andi2;
			andi2		:		#40 Present_state=andi3; 
			andi3		:		#40 Present_state=reset_state; 
			
			//br
			br			:		#40 Present_state=br2;
			br2		:		#40 Present_state=br3;
			br3		: 		#40 Present_state=br4;
			br4	   :		#40 Present_state=reset_state; 
			
			//jal
			jal		: 		#40 Present_state=jal2;
			jal2 	   :		#40 Present_state=reset_state; 
			
			//add
			add		:		#40 Present_state=add2;
			add2		:		#40 Present_state=add3;
			add3		:		#40 Present_state=add4;
			add4		:		#40 Present_state=reset_state; 
			
			//sub
			sub		:		#40 Present_state=sub2;
			sub2		:		#40 Present_state=sub3;
			sub3		:		#40 Present_state=sub4;
			sub4		:		#40 Present_state=reset_state; 
			
			//shr
			shr		:		#40 Present_state=shr2;
			shr2		:		#40 Present_state=shr3;
			shr3		:		#40 Present_state=shr4;
			shr4		:		#40 Present_state=shr5;
			shr5		:		#40 Present_state=reset_state; 
			
			//shl
			shl		:		#40 Present_state=shl2;
			shl2		:		#40 Present_state=shl3;
			shl3		:		#40 Present_state=shl4;
			shl4		:		#40 Present_state=shl5;
			shl5		:		#40 Present_state=reset_state; 
			
			//ror
			ror 		:		#40 Present_state=ror2;
			ror2 		:		#40 Present_state=ror3;
			ror3 		:		#40 Present_state=ror4;
			ror4 		:		#40 Present_state=ror5;
			ror5 		:		#40 Present_state=reset_state;
			
			//rol
			rol 		:		#40 Present_state=rol2;
			rol2 		:		#40 Present_state=rol3;
			rol3 		:		#40 Present_state=rol4;
			rol4 		:		#40 Present_state=rol5;
			rol5 		:		#40 Present_state=rol6;
			rol6		:		#40 Present_state=reset_state; 
			
			//and
			and1 		:		#40 Present_state=and2;
			and2 		:		#40 Present_state=and3;
			and3		:		#40 Present_state=reset_state; 
			
			//or
			or1		:		#40 Present_state=or2;
			or2		:		#40 Present_state=or3;
			or3		:		#40 Present_state=reset_state;
			
			//mul
			mul		:		#40 Present_state=mul2;
			mul2		:		#40 Present_state=mul3;
			mul3		:		#40 Present_state=mul4;
			mul4		:		#40 Present_state=mul5;
			mul5		:		#40 Present_state=reset_state; 
			
			//div
			div		:		#40 Present_state=div2;
			div2		:		#40 Present_state=div3;
			div3		:		#40 Present_state=div4;
			div4		:		#40 Present_state=reset_state; 
			
			//neg
			neg 		:		#40 Present_state=neg2;
			neg2		:		#40 Present_state=neg3;
			neg3		:		#40 Present_state=reset_state; 
			
			//not
			not1		:		#40 Present_state=not2;
			not2		:		#40 Present_state=not3;
			not3		:		#40 Present_state=reset_state; 
			
			//nop
			nop		:		#40 Present_state=reset_state;
			
			//halt
			halt		:		#40 Present_state=halt;
			
			//mfhi
			mfhi		:		#40 Present_state=reset_state;
			
			//mflo
			mflo		:		#40 Present_state=reset_state;
			
			//jr
			jr			:		#40 Present_state=reset_state; 
			endcase
		end
		

always@(Present_state)
begin
	case(Present_state)
		reset_state:begin
			Gra <= 0; Grb <= 0; Grc <= 0; Rin <= 0;Rout <= 0;MDRin <= 0;MDRout <= 0;BAout <= 0;Cout <= 0;ZLowout <= 0;
			PCin <= 0;IRin <= 0;HIout <= 0;LOout <= 0;InPortout <= 0;OPin <= 0;LOin <= 0;ZHighout <= 0;HIin <= 0;
			Yin <= 0; Zin <= 0; PCout <= 0; IncPC <= 0;MARin <= 0;
			read <= 0; wren <= 0;clr <= 0;ALUselect <= 4'b0000;
			conffin <= 0; Run <=1;
		end
		fetch0: begin
			PCout <= 1;MARin <= 1;ALUselect <= 4'b0100; Zin <= 1;
		end 
		fetch1: begin
			MARin <= 0;PCout <= 0;ALUselect <= 4'b0000;Zin <= 0;
			ZLowout <= 1;PCin <= 1;read <= 1;MDRin <=1;
		end
		fetch2: begin
			ZLowout <= 0;MDRin <= 0;PCin <= 0;read <= 0;
			MDRout <= 1;IRin <= 1;
		end
//ld
//---------------------------------
		ld:
			begin
			IRin <= 0;
			MDRout <= 0;
			
			Yin <= 1;
			Grb <= 1;
			BAout <= 1;
		end
		
		ld2:
			begin
			Grb <= 0;
			Yin <= 0;
			BAout <= 0;
			

			Cout <= 1;
			Zin <= 1;
			
			#20
			ALUselect <= 4'b0001;
		end
		
		ld3:
			begin
			Cout <= 0;
			Zin <= 0;

			
			ZLowout <= 1;
			MARin <= 1;
		end
		
		ld4: begin
			ZLowout <= 0;
			MARin <= 0;
			
			MDRin <= 1;
			read <= 1;
		end
		
		ld5: begin
			MDRin <= 0;
			read <= 0;
			
			MDRout <= 1;
			Gra <= 1;
			Rin <= 1;
		end

//ldi
//---------------------------------
		ldi: begin
			MDRout <= 0; IRin <= 0;
			Grb <=1; BAout<=1; Yin <=1; 
		end
		ldi2: begin
			Grb <=0; BAout<=0; Yin <=0; 
			Cout <=1;  Zin<=1;
			#20
			ALUselect <=4'b0001;  
		end

		ldi3: begin
			Cout <=0;  Zin<=0;
			Gra<=1;ZLowout <=1;  Rin<=1; 
		end
		
//st
//---------------------------------
		st: begin
			MDRout <= 0; IRin <= 0;	
			Grb <=1; BAout<=1; Yin <=1; 
		end
		st2: begin
			Grb <=0; BAout<=0; Yin <=0; 
			Cout <=1; Zin<=1;
			#20
			ALUselect <=4'b0001;  
		end
		st3: begin
			Cout <=0; Zin<=0;
			ZLowout <=1; MARin<=1; 
		end
		st4: begin
			ZLowout <=0; MARin<=0;	
			Rout <= 1; Gra <=1;
			wren<=1; MDRin<=1;
		end
		st5: begin
			wren<=0; MDRin<=0;
			Rout <= 0; Gra <=0;	
			MDRout<=1; Gra<=1;Rin<=1;
		end
//addi
//---------------------------------
		addi: begin
			MDRout <= 0; IRin <= 0;
			Grb <=1; Rout<=1; Yin <=1; 
		end
		addi2: begin
			Grb <=0; Rout<=0; Yin <=0; 
			Cout <=1; Zin<=1; 
			#20
			ALUselect <= 4'b0001;  
		end
		addi3: begin
			Cout <=0; Zin<=0;
			ZLowout <=1; Gra<=1; Rin<=1; 
		end
	
//ori
//---------------------------------
		ori: begin
			MDRout <= 0; IRin <= 0;
			Grb <=1; Rout<=1; Yin <=1; 
		end
		ori2: begin
			Grb <=0; Rout<=0; Yin <=0; 
			Cout <=1; Zin<=1; 
			#20
			ALUselect <= 4'b0111;  
		end
		ori3: begin
			Cout <=0; Zin<=0;
			ZLowout <=1; Gra<=1; Rin<=1; 
		end

//andi
//---------------------------------
		andi: begin
			MDRout <= 0; IRin <= 0;
			Grb <=1; Rout<=1; Yin <=1; 
		end
		andi2: begin
			Grb <=0; Rout<=0; Yin <=0; 
			Cout <=1; Zin<=1; 
			#20
			ALUselect <= 4'b0110;  
		end
		andi3: begin
			Cout <=0; Zin<=0;
			ZLowout <=1; Gra<=1; Rin<=1; 
		end
		
//br
//---------------------------------
		br: begin
			MDRout <= 0; IRin <= 0;
			Gra <=1; Rout<=1; conffin <=1; 
		end
		br2: begin
			Gra <=0; Rout<=0; conffin <=0; 
			PCout<=1; Yin<=1; 
		end
		br3: begin
			PCout<=0; Yin<=0;
			Cout<=1;  Zin <=1; 
			#20
			ALUselect <=4'b0001;  
		end
		br4: begin
			Cout<=0;  Zin <=0; 
			ZLowout<=1;  
			if(conffout==1)
				PCin <= 1;
		end
		
//jr
//---------------------------------
		jr: begin
			MDRout <= 0; IRin <= 0;
			Gra <=1; Rout<=1; PCin <=1; 
		end
		
//jal
//---------------------------------
		jal: begin
			MDRout <= 0; IRin <= 0;
			Grb <=1; Rin<=1; PCout <=1;	
		end
		
		jal2: begin
			Grb <=0; Rin<=0; PCout <=0;
			
			Gra <=1; Rout<=1; PCin<=1;
		end	
	
//mfhi	
//---------------------------------
		mfhi: begin
			MDRout <= 0; IRin <= 0;
			Gra <=1; Rin<=1; HIout <=1;	
		end
		
//mflo
//---------------------------------
		mflo: begin
			MDRout <= 0; IRin <= 0;
			Gra <=1; Rin<=1; LOout <=1;	
		end
		
//in
//---------------------------------
		in: begin
			MDRout <= 0; IRin <= 0;
			Gra <=1; Rin<=1; InPortout <=1; 
		end
		
//out
//---------------------------------
		out: begin
			MDRout <= 0; IRin <= 0;
			Gra <=1; Rout<=1; OPin <=1; 

		end
		

//OR
//---------------------------------
		or1: begin
			MDRout <= 0; IRin <= 0;
			Grb <=1; Rout <=1; Yin <=1;
		end
		or2: begin
			Grb <=0; Yin <=0;
			Grc <= 1; Rout <= 1; Zin<=1;
			#20
			ALUselect <= 4'b0111;  
		end
		or3: begin
			Grc <= 0; Rout <= 0; Zin<=0; 
			Gra<=1; ZLowout<=1; Rin <=1;
		end
		
//AND	
//---------------------------------		
		and1: begin
			MDRout <= 0; IRin <= 0;
			Grb <=1; Rout <=1; Yin <=1;
		end
		and2: begin
			Grb <=0; Yin <=0;
			Grc <= 1; Rout <= 1; Zin<=1;
			#20
			ALUselect <= 4'b0110;  
		end
		and3: begin
			Grc <= 0; Rout <= 0; Zin<=0; 
			Gra<=1; ZLowout<=1; Rin <=1;
		end

//ADD
//---------------------------------
		add: begin
			MDRout <= 0; IRin <= 0;
			Grb <=1; Rout <=1; Yin <=1;
		end
		add2: begin
			Grb <=0; Yin <=0;
			Grc <= 1; Rout <= 1; Zin<=1;
			#20
			ALUselect <= 4'b0001;  
		end
		add3: begin
			Grc <= 0; Rout <= 0; Zin<=0; 
			Gra<=1; ZLowout<=1; Rin <=1;
		end
		
//SUB
//---------------------------------
		sub: begin
			MDRout <= 0; IRin <= 0;
			Grb <=1; Rout <=1; Yin <=1;
		end
		sub2: begin
			Grb <=0; Yin <=0;
			Grc <= 1; Rout <= 1; Zin<=1;
			#20
			ALUselect <= 4'b0010; 
		end
		sub3: begin
			Grc <= 0; Rout <= 0; Zin<=0; 
			Gra<=1; ZLowout<=1; Rin <=1;
		end

//MUL
//---------------------------------		
		mul: begin
		MDRout <= 0; IRin <= 0;
			Gra <=1; Rout <=1; Yin <=1;
		end
		mul2: begin
			Gra <=0; Yin <=0;
			Grb <= 1; Rout <= 1; Zin<=1;
			#20
		ALUselect <= 4'b0011;
		end
		mul3: begin
			Grb <= 0; Rout <= 0; Zin<=0; 
			ZLowout<=1; LOin <=1;
		end
		mul4: begin
			LOin <=0; ZLowout<=0; ZHighout <=1; HIin <= 1; 
		end
		
//DIV
//---------------------------------
	div: begin
	MDRout <= 0; IRin <= 0;
		Gra <=1; Rout <=1; Yin <=1;
	end
	div2: begin
		Gra <=0; Yin <=0;
		Grb <= 1; Rout <= 1; Zin<=1;
		#20
		ALUselect <= 4'b0101; 
	end
	div3: begin
		Grb <= 0; Rout <= 0; Zin<=0; 
		ZLowout<=1; LOin <=1;
	end
	div4: begin
		LOin <=0; ZLowout<=0; ZHighout <=1; HIin <= 1; 
		end
	
//SHR
//---------------------------------
		shr: begin
			MDRout <= 0; IRin <= 0;
			Grb <=1; Rout <=1; Yin <=1;
		end
		shr2: begin
			Grb <=0; Yin <=0;
			Grc <= 1; Rout <= 1; Zin<=1;
			#20
			ALUselect <= 4'b1101; 
		end
		shr3: begin
			Grc <= 0; Rout <= 0; Zin<=0; 
			Gra<=1; ZLowout<=1; Rin <=1;
		end
	
//SHL
//---------------------------------
		shl: begin
			MDRout <= 0; IRin <= 0;
			Grb <=1; Rout <=1; Yin <=1;
		end
		shl2: begin
			Grb <=0; Yin <=0;
			Grc <= 1; Rout <= 1; Zin<=1;
			#20
			ALUselect <= 4'b1100; 
		end
		shl3: begin
			Grc <= 0; Rout <= 0; Zin<=0; 
			Gra<=1; ZLowout<=1; Rin <=1;
		end
	
//ROR
//---------------------------------
		ror: begin
			MDRout <= 0; IRin <= 0;
			Grb <=1; Rout <=1; Yin <=1;
		end
		ror2: begin
			Grb <=0; Yin <=0;
			Grc <= 1; Rout <= 1; Zin<=1;
			#20
			ALUselect <= 4'b1111; 
		end
		ror3: begin
			Grc <= 0; Rout <= 0; Zin<=0; 
			Gra<=1; ZLowout<=1; Rin <=1;
		end
	
//ROL
//---------------------------------
		rol: begin
			MDRout <= 0; IRin <= 0;
			Grb <=1; Rout <=1; Yin <=1;
		end
		rol2: begin
			Grb <=0; Yin <=0;
			Grc <= 1; Rout <= 1; Zin<=1;
			#20
			ALUselect <= 4'b1110; 
		end
		rol3: begin
			Grc <= 0; Rout <= 0; Zin<=0; 
			Gra<=1; ZLowout<=1; Rin <=1;
		end
	
//NEG
//---------------------------------
	neg: begin
		MDRout <= 0; IRin <= 0;
		Grb<=1;Rout <=1;
	end
	neg2: begin
		Grb<=0; ALUselect <= 4'b1000; 
		 Zin <=1;Rout <=0;
	end
	neg3: begin
		Gra<=1; ZLowout<=1;Rin <=1; 
	end

//NOT
//---------------------------------
	not1: begin
		MDRout <= 0; IRin <= 0;
		Grb<=1;Rout <=1;
	end
	not2: begin
		Grb<=0;
		ALUselect <= 4'b1010; Zin <=1;Rout <=0;
	end
	not3: begin
		Gra<=1; ZLowout<=1;Rin <=1; 
	end

//NOP
//---------------------------------
	nop:begin
	
	end
	
	nop2:begin
	
	end

// HALT
//---------------------------------
	halt:begin 
		Run <= 0;
	end

	
	endcase
end
endmodule
			
