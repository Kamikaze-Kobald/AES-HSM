`timescale 1ns / 1ps

//S-Box of each byte in the word.

module aes_subword(
    input wire [31:0] in,
    output wire [31:0] out
);
    aes_sbox sb0(.in(in[7:0]), .out(out[7:0]));
    aes_sbox sb1(.in(in[15:8]), .out(out[15:8]));
    aes_sbox sb2(.in(in[23:16]), .out(out[23:16]));
    aes_sbox sb3(.in(in[31:24]), .out(out[31:24]));
endmodule
