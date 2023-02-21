module encoder_32_to_5 (
input wire r0Signal,
input wire r1Signal,
input wire r2Signal,
input wire r3Signal,
input wire r4Signal,
input wire r5Signal,
input wire r6Signal,
input wire r7Signal,
input wire r8Signal,
input wire r9Signal,
input wire r10Signal,
input wire r11Signal,
input wire r12Signal,
input wire r13Signal,
input wire r14Signal,
input wire r15Signal,
input wire HISignal,
input wire LOSignal,
input wire ZHISignal,
input wire ZLOSignal,
input wire PCSignal,
input wire MDRSignal,
input wire InportSignal,
input wire CSignal,

output reg [4:0] encoderOutput
);

	always@(*) begin
      if (r0Signal == 1)
         encoderOutput = 5'b00001;
      else if(r1Signal == 1)
         encoderOutput = 5'b00010;
      else if(r2Signal == 1)
         encoderOutput = 5'b00011;
      else if(r3Signal == 1)
         encoderOutput = 5'b00100;
      else if(r4Signal == 1)
         encoderOutput = 5'b00101;
      else if(r5Signal == 1)
         encoderOutput = 5'b00110;
      else if(r6Signal == 1)
         encoderOutput = 5'b00111;
      else if(r7Signal == 1)
         encoderOutput = 5'b01000;
      else if(r9Signal == 1)
         encoderOutput = 5'b01001;
      else if(r10Signal == 1)
         encoderOutput = 5'b01010;
      else if(r11Signal == 1)
         encoderOutput = 5'b01011;
      else if(r11Signal == 1)
         encoderOutput = 5'b01100;
      else if(r12Signal == 1)
         encoderOutput = 5'b01101;
      else if(r13Signal == 1)
         encoderOutput = 5'b01110;
      else if(r14Signal == 1)
         encoderOutput = 5'b01111;
      else if(r15Signal == 1)
         encoderOutput = 5'b10000;
      else if (HISignal == 1)
         encoderOutput = 5'b10001;
      else if (LOSignal == 1)
         encoderOutput = 5'b10010;
      else if (ZHISignal == 1)
         encoderOutput = 5'b10011;
      else if (ZLOSignal == 1)
         encoderOutput = 5'b10100;
      else if (PCSignal == 1)
         encoderOutput = 5'b10101;
      else if (MDRSignal == 1)
         encoderOutput = 5'b10110;
      else if (InportSignal == 1)
         encoderOutput = 5'b10111;
      else if (CSignal == 1)
         encoderOutput = 5'b11000;
      //else encoderOuput = 0;  //default?

   end

endmodule
