module MDR (
  input clk, mdr_read, clr,
  input [31:0] BusMuxOut, Mdatain, MDRin,
  output wire [31:0] Q
);

wire [31:0] S;

mux_2_to_1 my_mux (
  .inputOne(BusMuxOut),
  .inputTwo(Mdatain),
  .signal(mdr_read),
  .out(S)
);

reg_32_bits my_reg (
  .clk(clk),
  .clr(clr),
  .enable(MDRin),
  .d(S),
  .q(Q)
);

endmodule
