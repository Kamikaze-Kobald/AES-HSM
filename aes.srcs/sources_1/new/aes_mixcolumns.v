`timescale 1ns / 1ps

//Permutes columns via Galois-field polynomial operations, which are scary and complicated.
//Thankfully, these operations can be simplified to a xor-based matrix multiplication on each column:
// 2 3 1 1 | b0
// 1 2 3 1 | b1
// 1 1 2 3 | b2
// 3 1 1 2 | b3
//Which can be further reduced into combinational logic, as shown below. Multiplication is replaced by bitwise and, and addition is replaced by bitwise xor.

//This step is important for diffusion, ensuring each byte's final value is dependant on each other byte in the block and destroying patterns in the plaintext.

module aes_mixcolumns(
    input wire [127:0] b_in,
    output wire [127:0] b_out
);
    assign b_out[7:0] = (2 & b_in[7:0]) ^ (3 & b_in[15:8]) ^ b_in[23:16] ^ b_in[31:24];
    assign b_out[15:8] = b_in[7:0] ^ (2 & b_in[15:8]) ^ (3 & b_in[23:16]) ^ b_in[31:24];
    assign b_out[23:16] = b_in[7:0] ^ b_in[15:8] ^ (2 & b_in[23:16]) ^ (3 & b_in[31:24]);
    assign b_out[31:24] = (3 & b_in[7:0]) ^ b_in[15:8] ^ b_in[23:16] ^ (2 & b_in[31:24]);

    assign b_out[39:32] = (2 & b_in[39:32]) ^ (3 & b_in[47:40]) ^ b_in[55:48] ^ b_in[63:56];
    assign b_out[47:40] = b_in[39:32] ^ (2 & b_in[47:40]) ^ (3 & b_in[55:48]) ^ b_in[63:56];
    assign b_out[55:48] = b_in[39:32] ^ b_in[47:40] ^ (2 & b_in[55:48]) ^ (3 & b_in[63:56]);
    assign b_out[63:56] = (3 & b_in[39:32]) ^ b_in[47:40] ^ b_in[55:48] ^ (2 & b_in[63:56]);

    assign b_out[71:64] = (2 & b_in[71:64]) ^ (3 & b_in[79:72]) ^ b_in[87:80] ^ b_in[95:88];
    assign b_out[79:72] = b_in[71:64] ^ (2 & b_in[79:72]) ^ (3 & b_in[87:80]) ^ b_in[95:88];
    assign b_out[87:80] = b_in[71:64] ^ b_in[79:72] ^ (2 & b_in[87:80]) ^ (3 & b_in[95:88]);
    assign b_out[95:88] = (3 & b_in[71:64]) ^ b_in[79:72] ^ b_in[87:80] ^ (2 & b_in[95:88]);

    assign b_out[103:96] = (2 & b_in[103:96]) ^ (3 & b_in[111:104]) ^ b_in[119:112] ^ b_in[127:120];
    assign b_out[111:104] = b_in[103:96] ^ (2 & b_in[111:104]) ^ (3 & b_in[119:112]) ^ b_in[127:120];
    assign b_out[119:112] = b_in[103:96] ^ b_in[111:104] ^ (2 & b_in[119:112]) ^ (3 & b_in[127:120]);
    assign b_out[127:120] = (3 & b_in[103:96]) ^ b_in[111:104] ^ b_in[119:112] ^ (2 & b_in[127:120]);
endmodule

//for i in [0,1,2,3]
//assign b_out[{32 * i + 7}:{32 * i}] = (2 & b_in[{32 * i + 7}:{32 * i}]) ^ (3 & b_in[{32 * i + 15}:{32 * i + 8}]) ^ b_in[{32 * i + 23}:{32 * i + 16}] ^ b_in[{32 * i + 31}:{32 * i + 24}];
//assign b_out[{32 * i + 15}:{32 * i + 8}] = b_in[{32 * i + 7}:{32 * i}] ^ (2 & b_in[{32 * i + 15}:{32 * i + 8}]) ^ (3 & b_in[{32 * i + 23}:{32 * i + 16}]) ^ b_in[{32 * i + 31}:{32 * i + 24}];
//assign b_out[{32 * i + 23}:{32 * i + 16}] = b_in[{32 * i + 7}:{32 * i}] ^ b_in[{32 * i + 15}:{32 * i + 8}] ^ (2 & b_in[{32 * i + 23}:{32 * i + 16}]) ^ (3 & b_in[{32 * i + 31}:{32 * i + 24}]);\n
//assign b_out[{32 * i + 31}:{32 * i + 24}] = (3 & b_in[{32 * i + 7}:{32 * i}]) ^ b_in[{32 * i + 15}:{32 * i + 8}] ^ b_in[{32 * i + 23}:{32 * i + 16}] ^ (2 & b_in[{32 * i + 31}:{32 * i + 24}]);