`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2022 05:13:11 AM
// Design Name: 
// Module Name: switch_handler
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module switch_handler(
    input [1:0] h_select,
    input [4:0] SW,
    input clk,
    input rst,
    input push,
    output reg [4:0] h0,
    output reg [4:0] h1,
    output reg [4:0] h2,
    output reg [2:0] h3
);
    
    always @(posedge clk or negedge rst) begin
        if(rst) begin
            h0 <= 5'b00000;
            h1 <= 5'd10;
            h2 <= 5'd27;
            h3 <= 3'd0;
        end
    else
        if(push==1) begin: Push_Values
            case(h_select)
                0: begin: enables_mode
                    h0[4] <= SW[4];    //clk_wiz_rst    
                    h0[3] <= SW[3];    //AN_dec_en
                    h0[2] <= SW[2];    //AN_cnt_rst
                    h0[1] <= SW[1];    //vga_rst
                    h0[0] <= SW[0];    //sha_rst
                end
                1: begin: sha_div
                    h1 <= SW;
                end
                2: begin: ref_rate
                    h2 <= SW;
                end
                3: begin: hash_sel
                    h3 <= SW[2:0];
                end
                default: begin: Maintain_Value
                   h0 <= h0; 
                   h1 <= h1; 
                   h2 <= h2; 
                   h3 <= h3;
                end
            endcase
        end
    end
    
endmodule