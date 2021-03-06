/*
   This file was generated automatically by Alchitry Labs version 1.2.1.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module multiplier16_7 (
    input [15:0] a,
    input [15:0] b,
    output reg [15:0] mult
  );
  
  
  
  wire [(5'h10+0)*(5'h10+0)-1:0] M_and_gates_s;
  reg [(5'h10+0)*(5'h10+0)-1:0] M_and_gates_a;
  reg [(5'h10+0)*(5'h10+0)-1:0] M_and_gates_b;
  
  genvar GEN_and_gates0, GEN_and_gates1;
  generate
  for (GEN_and_gates0=0;GEN_and_gates0<5'h10;GEN_and_gates0=GEN_and_gates0+1) begin: and_gates_gen_0
    for (GEN_and_gates1=0;GEN_and_gates1<5'h10;GEN_and_gates1=GEN_and_gates1+1) begin: and_gates_gen_1
      and2_16 and_gates (
        .a(M_and_gates_a[GEN_and_gates0*(5'h10)*(1)+GEN_and_gates1*(1)+(1)-1-:(1)]),
        .b(M_and_gates_b[GEN_and_gates0*(5'h10)*(1)+GEN_and_gates1*(1)+(1)-1-:(1)]),
        .s(M_and_gates_s[GEN_and_gates0*(5'h10)*(1)+GEN_and_gates1*(1)+(1)-1-:(1)])
      );
    end
  end
  endgenerate
  
  wire [(4'hf+0)*16-1:0] M_add_s;
  reg [(4'hf+0)*16-1:0] M_add_a;
  reg [(4'hf+0)*16-1:0] M_add_b;
  
  genvar GEN_add0;
  generate
  for (GEN_add0=0;GEN_add0<4'hf;GEN_add0=GEN_add0+1) begin: add_gen_0
    basic_add16_17 add (
      .a(M_add_a[GEN_add0*(5'h10)+(5'h10)-1-:(5'h10)]),
      .b(M_add_b[GEN_add0*(5'h10)+(5'h10)-1-:(5'h10)]),
      .s(M_add_s[GEN_add0*(5'h10)+(5'h10)-1-:(5'h10)])
    );
  end
  endgenerate
  
  always @* begin
    M_and_gates_a[0+15-:16] = a[0+15-:16];
    M_and_gates_b[0+15-:16] = {5'h10{b[0+0-:1]}};
    M_and_gates_a[16+15-:16] = {a[0+14-:15], 1'h0};
    M_and_gates_b[16+15-:16] = {5'h10{b[1+0-:1]}};
    M_and_gates_a[32+15-:16] = {a[0+13-:14], 2'h0};
    M_and_gates_b[32+15-:16] = {5'h10{b[2+0-:1]}};
    M_and_gates_a[48+15-:16] = {a[0+12-:13], 3'h0};
    M_and_gates_b[48+15-:16] = {5'h10{b[3+0-:1]}};
    M_and_gates_a[64+15-:16] = {a[0+11-:12], 4'h0};
    M_and_gates_b[64+15-:16] = {5'h10{b[4+0-:1]}};
    M_and_gates_a[80+15-:16] = {a[0+10-:11], 5'h00};
    M_and_gates_b[80+15-:16] = {5'h10{b[5+0-:1]}};
    M_and_gates_a[96+15-:16] = {a[0+9-:10], 6'h00};
    M_and_gates_b[96+15-:16] = {5'h10{b[6+0-:1]}};
    M_and_gates_a[112+15-:16] = {a[0+8-:9], 7'h00};
    M_and_gates_b[112+15-:16] = {5'h10{b[7+0-:1]}};
    M_and_gates_a[128+15-:16] = {a[0+7-:8], 8'h00};
    M_and_gates_b[128+15-:16] = {5'h10{b[8+0-:1]}};
    M_and_gates_a[144+15-:16] = {a[0+6-:7], 9'h000};
    M_and_gates_b[144+15-:16] = {5'h10{b[9+0-:1]}};
    M_and_gates_a[160+15-:16] = {a[0+5-:6], 10'h000};
    M_and_gates_b[160+15-:16] = {5'h10{b[10+0-:1]}};
    M_and_gates_a[176+15-:16] = {a[0+4-:5], 11'h000};
    M_and_gates_b[176+15-:16] = {5'h10{b[11+0-:1]}};
    M_and_gates_a[192+15-:16] = {a[0+3-:4], 12'h000};
    M_and_gates_b[192+15-:16] = {5'h10{b[12+0-:1]}};
    M_and_gates_a[208+15-:16] = {a[0+2-:3], 13'h0000};
    M_and_gates_b[208+15-:16] = {5'h10{b[13+0-:1]}};
    M_and_gates_a[224+15-:16] = {a[0+1-:2], 14'h0000};
    M_and_gates_b[224+15-:16] = {5'h10{b[14+0-:1]}};
    M_and_gates_a[240+15-:16] = {a[0+0-:1], 15'h0000};
    M_and_gates_b[240+15-:16] = {5'h10{b[15+0-:1]}};
    M_add_a[0+15-:16] = M_and_gates_s[0+15-:16];
    M_add_b[0+15-:16] = M_and_gates_s[16+15-:16];
    M_add_a[16+15-:16] = M_add_s[0+15-:16];
    M_add_b[16+15-:16] = M_and_gates_s[32+15-:16];
    M_add_a[32+15-:16] = M_add_s[16+15-:16];
    M_add_b[32+15-:16] = M_and_gates_s[48+15-:16];
    M_add_a[48+15-:16] = M_add_s[32+15-:16];
    M_add_b[48+15-:16] = M_and_gates_s[64+15-:16];
    M_add_a[64+15-:16] = M_add_s[48+15-:16];
    M_add_b[64+15-:16] = M_and_gates_s[80+15-:16];
    M_add_a[80+15-:16] = M_add_s[64+15-:16];
    M_add_b[80+15-:16] = M_and_gates_s[96+15-:16];
    M_add_a[96+15-:16] = M_add_s[80+15-:16];
    M_add_b[96+15-:16] = M_and_gates_s[112+15-:16];
    M_add_a[112+15-:16] = M_add_s[96+15-:16];
    M_add_b[112+15-:16] = M_and_gates_s[128+15-:16];
    M_add_a[128+15-:16] = M_add_s[112+15-:16];
    M_add_b[128+15-:16] = M_and_gates_s[144+15-:16];
    M_add_a[144+15-:16] = M_add_s[128+15-:16];
    M_add_b[144+15-:16] = M_and_gates_s[160+15-:16];
    M_add_a[160+15-:16] = M_add_s[144+15-:16];
    M_add_b[160+15-:16] = M_and_gates_s[176+15-:16];
    M_add_a[176+15-:16] = M_add_s[160+15-:16];
    M_add_b[176+15-:16] = M_and_gates_s[192+15-:16];
    M_add_a[192+15-:16] = M_add_s[176+15-:16];
    M_add_b[192+15-:16] = M_and_gates_s[208+15-:16];
    M_add_a[208+15-:16] = M_add_s[192+15-:16];
    M_add_b[208+15-:16] = M_and_gates_s[224+15-:16];
    M_add_a[224+15-:16] = M_add_s[208+15-:16];
    M_add_b[224+15-:16] = M_and_gates_s[240+15-:16];
    mult = M_add_s[224+15-:16];
  end
endmodule
