`timescale 1ns / 1ps

//A unique key generated from the original for each round of encryption.

module aes_roundkey(
    input wire [127:0] key,
    input wire clk,
    input wire enable,
    input wire rst,
    output wire [127:0] out
);
    reg [127:0] current = 0; //Current key.
    reg [3:0] round = 0; //Current round. 0 means use original key.
    reg [127:0] previous = 0;
    
    wire [31:0] s;
    wire [31:0] r;
    wire [31:0] c;

    aes_rotword rot(.in(previous[31:0]), .out(s));
    aes_subword sub(.in(r), .out(s));
    aes_rcon con(.round(round + 1'b1), .out(c));
    
    wire [31:0] n0; //Intermediate for new val.
    wire [31:0] n1;
    wire [31:0] n2;
    wire [31:0] n3;
    
    assign n0 = previous[31:0] ^ s ^ c;
    assign n1 = previous[63:32] ^ current[31:0];
    assign n2 = previous[95:64] ^ current[63:32];
    assign n3 = previous[127:96] ^ current[95:64];
    
    initial begin
        current <= key;
        previous <= key;
        round <= 0;
    end

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            current <= key;
            previous <= key;
            round <= 0;
        end
        else if (enable && round < 10) begin
            round <= round + 1'b1;
            previous <= current;
            current <= {n3, n2, n1, n0};
        end
    end
    
    assign out = current;
endmodule