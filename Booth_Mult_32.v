module Booth_Mult_32 (output reg [63:0] product, input [31:0] a, b, input wire clk);
  reg [31:0] a_reg, b_reg, sum;
  reg [32:0] c_out;
  reg [31:0] c_in;
  reg [31:0] c_reg;
  reg [63:0] acc;
  reg [1:0] state;
  integer i;

  // register the inputs
  always @(*) begin
    a_reg = a;
    b_reg = b;
  end

  // initializations
  initial begin
    c_in = 0;
    c_reg = 0;
    acc = 0;
    state = 2'b00;
    product = 0;
  end

  // perform the multiplication
  always @(posedge clk) begin
    case (state)
      2'b00: begin
        if (b_reg[0] == 1'b1) begin
          acc = acc + a_reg;
        end
        if (b_reg[1] == 1'b1) begin
          acc = acc + (a_reg << 1);
        end
        b_reg = b_reg >> 2;
        a_reg = a_reg << 2;
        state = 2'b01;
      end
      2'b01: begin
        if (b_reg[0] == 1'b1) begin
          acc = acc - a_reg;
        end
        if (b_reg[1] == 1'b1) begin
          acc = acc - (a_reg << 1);
        end
        b_reg = b_reg >> 2;
        a_reg = a_reg << 2;
        state = 2'b10;
      end
      2'b10: begin
        if (b_reg[0] == 1'b1) begin
          acc = acc + a_reg;
        end
        if (b_reg[1] == 1'b1) begin
          acc = acc + (a_reg << 1);
        end
        b_reg = b_reg >> 2;
        a_reg = a_reg << 2;
        state = 2'b11;
      end
      2'b11: begin
        if (b_reg[0] == 1'b1) begin
          acc = acc - a_reg;
        end
        if (b_reg[1] == 1'b1) begin
          acc = acc - (a_reg << 1);
        end
        b_reg = b_reg >> 2;
        a_reg = a_reg << 2;
        state = 2'b00;
      end
    endcase
    product = acc;
  end
endmodule
