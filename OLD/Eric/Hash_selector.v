`timescale 1ns / 1ps
module Hash_selector(
            input    wire       [31:0] i_input,
            input    wire       [2:0]  i_select,
            output   wire       [31:0] o_P
    );

                     wire         [15:0]tmp_P0; 
                     wire         [7:0] tmp_P1; 
                     wire         [3:0] tmp_P2; 
                     wire         [1:0] tmp_P3; 

        genvar i, j, w;

         generate 
          for( i = 0; i < 16; i = i+1) 
          begin

         Mux2_1 Gen1 (
             .i_I0                      (i_input [(2i)]),
             .i_I1                      (i_input [(2i) +1]),
             .i_S                       (i_select[0]),
             .P                         (tmp_P0[i])
            );
           end 

          for( j = 0; j < 8; j = j+1) 
          begin

         Mux2_1 Gen2 (
             .i_I0                        (tmp_P0[(2j)]),
             .i_I1                        (tmp_P0[(2j)+1]),
             .i_S                         (i_select[1]),
             .o_P                         (tmp_P1[j])
            );
           end 

          for(w = 0; w < 4; w = w+1) 
          begin

         Mux2_1 Gen3 (
             .i_I0                        ( tmp_P1[(2w)] ),
             .i_I1                        ( tmp_P1[ (2w) +1]),
             .i_S                         (i_select[2]),
             .o_P                         (o_P)
            );
           end 


        endmodule