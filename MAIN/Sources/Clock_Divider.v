`timescale 1ns / 1ps

module Clock_Divider(
    input sys_clk,
    input sys_rst,
    input [4:0] div1, div2,
    output clk1, clk2

    );
    
    wire [31:0] cnt_tmp;
  
          nbit_counter #(.DATA_SIZE(32)) CLK_CNT(
              .clk(sys_clk),
              .reset(sys_rst),
              .counter(cnt_tmp)
          );
          
          nbit_mux #(.DATA_SIZE(5)) CLK_MUX1(
              .muxNx1_d(cnt_tmp),
              .muxNx1_s(div1),
              .muxNx1_y(clk1)
          );
          
          nbit_mux #(.DATA_SIZE(5))CLK_MUX2(
              .muxNx1_d(cnt_tmp),
              .muxNx1_s(div2),
              .muxNx1_y(clk2)
          );  
    
endmodule
