/*
   This file was generated automatically by Alchitry Labs version 1.2.1.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module full_adder_15 (
    input a,
    input b,
    input cin,
    output reg s,
    output reg cout
  );
  
  
  
  always @* begin
    s = a ^ b ^ cin;
    cout = (a & b) | (a & cin) | (b & cin);
  end
endmodule
