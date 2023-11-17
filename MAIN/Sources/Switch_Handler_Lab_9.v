`timescale 1ns / 1ps
module Switch_Handler_Lab_9(
    input [2:0] h_select,
    input [4:0] SW,
    input clk,
    input rst,
    input push,
    output [4:0] h0,
    output [4:0] h1,
    output [4:0] h2,
    output [2:0] h3,
    output [4:0] h4,
    output [4:0] h5
    );
    
    reg [4:0] h0_tmp = 5'b0; 
    reg [4:0] h1_tmp = 3'd10; 
    reg [4:0] h2_tmp = 4'd27; 
    reg [2:0] h3_tmp = 5'd17;
    reg [4:0] h4_tmp = 5'd0; 
    reg [4:0] h5_tmp = 5'd0; 
    
    always @(posedge clk or negedge rst) begin
        if(rst) begin
            h0_tmp <= 3'b0; 
            h1_tmp <= 3'b0; 
            h2_tmp <= 4'b0; 
            h3_tmp <= 5'd17;
            h4_tmp <= 5'd27; 
            h5_tmp <= 5'd10;  
        end
        else
            if(push) begin: Push_Values
                case(h_select)
                    0: begin: enables_mode
                        h0_tmp[4] <= SW[4];     //clk_wiz_rst
                        h0_tmp[3] <= SW[3];     //AN_dec_en
                        h0_tmp[2] <= SW[2];     //AN_cnt_rst
                        h0_tmp[1] <= SW[1];     //vga_rst
                        h0_tmp[0] <= SW[0];     //sha_rst
                    end
                    1: begin: sha_div
                        h1_tmp <= SW;      //SHA CLOCK 
                    end
                    2: begin: ref_div
                        h2_tmp <= SW;       //ref_div
                    end
                    3: begin: hash_sel
                        h3_tmp <= SW[2:0];       //hash
                    end
                    4: begin: empty0
                        h4_tmp <= h4_tmp; 
                    end
                    5: begin: empty1
                        h5_tmp <= h5_tmp;
                    end
                    default: begin: Maintain_Values
                        h0_tmp <= h0_tmp; 
                        h1_tmp <= h1_tmp; 
                        h2_tmp <= h2_tmp; 
                        h3_tmp <= h3_tmp;
                        h4_tmp <= h4_tmp; 
                        h5_tmp <= h5_tmp;
                    end
                endcase
            end
    end
    
    assign h0 = h0_tmp;
    assign h1 = h1_tmp;
    assign h2 = h2_tmp;
    assign h3 = h3_tmp;
    assign h4 = h4_tmp;
    assign h5 = h5_tmp;
endmodule
