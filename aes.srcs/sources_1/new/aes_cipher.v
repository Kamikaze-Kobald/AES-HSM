`timescale 1ns / 1ps

//Encrypts. Not very optimized yet.

module aes_cipher(
    input wire enable,
    input wire clk,
    input wire rst,
    input wire [127:0] key,
    input wire [127:0] in,
    output wire [127:0] out,
    output reg done //High when dout is ready
);

    //0: Initial ARK
    //1-9: Rounds 1 thru 9
    //10: SB, SR, ARK
    //11: Data out

    reg [3:0] state;
    reg [127:0] current;
    wire [127:0] shifted;
    wire [127:0] mixed;
    wire [127:0] subbed;
    wire [127:0] rkey;

    assign out = current;

    aes_keyexpansion exp(.key(key), .clk(clk), .enable(enable), .rst(rst), .out(rkey));

    aes_subbytes sub(.b_in(current), .b_out(subbed));
    aes_shiftrows sft(.b_in(subbed), .b_out(shifted));
    aes_mixcolumns mix(.b_in(shifted), .b_out(mixed));

    initial begin
        state <= 0;
        done <= 0;
    end
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 0;
            done <= 0;
        end
        else if (!state && enable) begin
            state <= 1;
            current <= key ^ in; //Having AddRoundKey() as a separate module felt unnecessary.
        end
        else if (state < 11) begin
            state <= state + 1;
            current <= mixed ^ rkey;
        end
        else if (state == 11) begin
            state <= 0;
            current <= shifted ^ rkey;
            done <= 1;
        end
        else begin
            state <= 0;
            done <= 0;
        end
    end
endmodule