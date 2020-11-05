/*
   This file was generated automatically by Alchitry Labs version 1.2.1.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module two_compliment16_18 (
    input [15:0] inp,
    output reg [15:0] out
  );
  
  
  
  wire [(5'h10+0)-1:0] M_xorgate_out;
  reg [(5'h10+0)-1:0] M_xorgate_a;
  reg [(5'h10+0)-1:0] M_xorgate_b;
  
  genvar GEN_xorgate0;
  generate
  for (GEN_xorgate0=0;GEN_xorgate0<5'h10;GEN_xorgate0=GEN_xorgate0+1) begin: xorgate_gen_0
    xor2_19 xorgate (
      .a(M_xorgate_a[GEN_xorgate0*(1)+(1)-1-:(1)]),
      .b(M_xorgate_b[GEN_xorgate0*(1)+(1)-1-:(1)]),
      .out(M_xorgate_out[GEN_xorgate0*(1)+(1)-1-:(1)])
    );
  end
  endgenerate
  
  wire [16-1:0] M_adder_s;
  reg [16-1:0] M_adder_a;
  reg [16-1:0] M_adder_b;
  basic_add16_17 adder (
    .a(M_adder_a),
    .b(M_adder_b),
    .s(M_adder_s)
  );
  
  always @* begin
    M_xorgate_a = inp;
    M_xorgate_b = 16'hffff;
    M_adder_a = M_xorgate_out;
    M_adder_b = 16'h0001;
    out = M_adder_s;
  end
endmodule
