module divider(
  input wire clk,
  input wire rst,
  input wire [31:0] dividend,
  input wire [31:0] divisor,
  output reg [31:0] quotient
);
  reg [31:0] dividend_temp = 0;
  reg [31:0] divisor_temp = 0;
  reg [31:0] bit_temp = 0;
  integer i;

  always @(posedge clk) begin
    if (rst) begin
      dividend_temp <= 0;
      divisor_temp <= 0;
      bit_temp <= 0;
      quotient <= 0;
    end else begin
      dividend_temp <= dividend;
      divisor_temp <= divisor;
      bit_temp <= {bit_temp[30:0],1'b0};
      for (i=0; i<32; i=i+1) begin
        if (dividend_temp >= divisor_temp) begin
          dividend_temp <= dividend_temp - divisor_temp;
          quotient <= quotient + bit_temp;
        end
        divisor_temp <= {1'b0, divisor_temp[31:1]};
        bit_temp <= {1'b0, bit_temp[31:1]};
      end
    end
  end
endmodule
