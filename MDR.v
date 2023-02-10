module MDR (
  input clk, mdr_read, clr, MDRin,
  input [31:0] BusMuxOut, Mdatain,
  output [31:0] q,
);

wire [31:0] S;

endmodule

2_to_1_mux my_mux (
  .input1(BusMuxOut),
  .input2(Mdatain),
  .signal(mdr_read),
  .out(S)
);

reg_32_bits my_reg (
  .clk(clk),
  .clear(clr),
  .enable(MDRin),
  .d(S),
  .q(q)
);

