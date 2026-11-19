`timescale 1ns / 1ps

//SubBytes alters each byte via an S-Box (lookup table). The resulting value is determined by the value of the most and least significant nibbles.
//This step confuses the input from the output, preventing linearity and making statistical cryptoanalysis more difficult.

module aes_subbytes(
    input wire [127:0] b_in,
    output wire [127:0] b_out
);
    aes_sbox sb0 (.in(b_in[7:0]), .out(b_out[7:0]));
    aes_sbox sb1 (.in(b_in[15:8]), .out(b_out[15:8]));
    aes_sbox sb2 (.in(b_in[23:16]), .out(b_out[23:16]));
    aes_sbox sb3 (.in(b_in[31:24]), .out(b_out[31:24]));
    aes_sbox sb4 (.in(b_in[39:32]), .out(b_out[39:32]));
    aes_sbox sb5 (.in(b_in[47:40]), .out(b_out[47:40]));
    aes_sbox sb6 (.in(b_in[55:48]), .out(b_out[55:48]));
    aes_sbox sb7 (.in(b_in[63:56]), .out(b_out[63:56]));
    aes_sbox sb8 (.in(b_in[71:64]), .out(b_out[71:64]));
    aes_sbox sb9 (.in(b_in[79:72]), .out(b_out[79:72]));
    aes_sbox sb10 (.in(b_in[87:80]), .out(b_out[87:80]));
    aes_sbox sb11 (.in(b_in[95:88]), .out(b_out[95:88]));
    aes_sbox sb12 (.in(b_in[103:96]), .out(b_out[103:96]));
    aes_sbox sb13 (.in(b_in[111:104]), .out(b_out[111:104]));
    aes_sbox sb14 (.in(b_in[119:112]), .out(b_out[119:112]));
    aes_sbox sb15 (.in(b_in[127:120]), .out(b_out[127:120]));
endmodule
