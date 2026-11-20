`timescale 1ns / 1ps

//XORs with the round key, ensuring uniqueness from AES encryptions with other keys.

module aes_addroundkey(
    input wire [127:0] key,
    input wire round,
    input wire [127:0] b_in,
    output wire [127:0] b_out
);
    wire [127:0] rkey;
    
    aes_keyexpansion schedule (.in(key), .round(round), .out(rkey));
    
    assign b_out = b_in ^ rkey;
    
endmodule
