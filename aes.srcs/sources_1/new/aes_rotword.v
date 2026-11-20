`timescale 1ns / 1ps

module aes_rotword(
    input wire [31:0] in,
    output wire [31:0] out
);
    assign out = {in[23:16], in[15:8], in[7:0], in[31:24]};
endmodule