`timescale 1ns / 1ps
module Switch_Handler_Lab_9(
    input [1:0] h_select,
    input [4:0] SW,
    input clk,
    input rst,
    input push,
    output [3:0] h0,
    output [4:0] h1,
    output [4:0] h2,
    output [2:0] h3
    );
    
    reg [3:0] h0_tmp = 4'b0; 
    reg [4:0] h1_tmp = 5'b1010; 
    reg [4:0] h2_tmp = 5'd27; 
    reg [2:0] h3_tmp = 3'd0;
    
    always @(posedge clk or negedge rst) begin
        if(rst) begin
            h0_tmp <= 4'b0; 
            h1_tmp <= 5'b1010; 
            h2_tmp <= 5'd27; 
            h3_tmp <= 3'd0;
 
        end
        else
            if(push) begin: Push_Values
                case(h_select)
                    0: begin: enables_mode
                        h0_tmp[4] <= SW[4];     //rand_cnt_rst
                        h0_tmp[3] <= SW[3];     //AN_dec_rst
                        h0_tmp[2] <= SW[2];     //AN_dec_en
                        h0_tmp[1] <= SW[1];     //mode
                        h0_tmp[0] <= SW[0];     //count_en
                    end
                    1: begin: load_select
                        h1_tmp <= SW[2:0];      //8 Anodes 
                    end
                    2: begin: seed
                        h2_tmp <= SW[3:0];
                    end
                    3: begin: ref_div
                        h3_tmp <= SW; 
                    end
                    4: begin: load_cnt_div
                        h4_tmp <= SW; 
                    end
                    5: begin: rand_cnt_div
                        h5_tmp <= SW;
                    end
                    default: begin: Maintain_Values
                        h0_tmp <= h0_tmp; 
                        h1_tmp <= h1_tmp; 
                        h2_tmp <= h2_tmp; 
                        h3_tmp <= h3_tmp;
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