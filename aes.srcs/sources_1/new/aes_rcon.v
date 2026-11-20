`timescale 1ns / 1ps

//Round constant generator for key schedule. The round constant prevents repeated patterns in the round key.

module aes_rcon(
    input wire [3:0] round,
    output wire [31:0] out
);
    reg [7:0] rc;
    
    initial rc <= 0;

    always @(*) begin
        case (round)
            default: rc <= 0;
            1: rc <= 8'h01;
            2: rc <= 8'h02;
            3: rc <= 8'h04;
            4: rc <= 8'h08;
            5: rc <= 8'h10;
            6: rc <= 8'h20;
            7: rc <= 8'h40;
            8: rc <= 8'h80;
            9: rc <= 8'h1B;
            10: rc <= 8'h36;
        endcase
    end

    assign out = {rc, 24'b0};
endmodule