`timescale 1ns / 1ps
module top (
    input sys_rst,
    input sys_clk,
    input UART_rst,
    input UART_Rx,
    input sha_rst,
    input AN_cnt_rst,
    //input [511:0] UART_r_data,
    input div_clk_rst,
    input [1:0] h_sel,
    input [4:0] SW,
    input push,
    output UART_rx_empty,
    output [6:0] SEG,
    output DP,
    output [7:0] AN,
    output [4:0] LED,
    output [3:0] o_red,
    output [3:0] o_green,
    output [3:0] o_blue,
    output o_hsync,
    output o_vsync
);
    wire [4:0] h0_tmp;
    wire [4:0] h1_tmp;
    wire [4:0] h2_tmp;
    wire [2:0] h3_tmp;
    wire [511:0] UART_r_data;
    
    UART_Driver #(.DBIT(512),.SB_TICK(1024)) UART_DRIVER(
        .clk(sys_clk),
        .rst(sys_rst),
        .r_data(UART_r_data),
        .rd_uart(h0_tmp[0]),
        .rx_empty(UART_rx_empty),
        .rx(UART_Rx),
        .w_data(),
        .wr_uart(),
        .TIMER_FINAL_VALUE()
    );

    Switch_Handler_Lab_9 SW_HANDLER(
        .h_select({0,h_sel}),
        .SW(SW),
        .clk(sys_clk),
        .rst(sys_rst),
        .push(push),
        .h0(h0_tmp),
        .h1(h1_tmp),
        .h2(h2_tmp),
        .h3(h3_tmp),
        .h4(),
        .h5()
    );
    
    wire [159:0] hash_tmp;
    wire sha_clk;
    wire ref_clk;
    
    Clock_Divider CLK_DIV(
        .sys_clk(sys_clk),
        .sys_rst(div_clk_rst),
        .div1(h1_tmp),
        .div2(h2_tmp),
        .clk1(sha_clk),
        .clk2(ref_clk)
    );
    
    sha_core SHA_CORE(
        .clk(sha_clk),
        .rst(sha_rst),
        .block(UART_r_data),
        .H_0(hash_tmp[31:0]),
        .H_1(hash_tmp[63:32]),
        .H_2(hash_tmp[95:64]),
        .H_3(hash_tmp[127:96]),
        .H_4(hash_tmp[159:128])
    );
    
    wire [31:0] selected_hash;
    hash_selector HASH_SEL(
        .load_in({96'b0,hash_tmp}),
        .select(h3_tmp),
        .out (selected_hash),
        .led(LED)
    );
    
    display_driver_8dig DISP_DRIVER(
        .in(selected_hash),
        .clk(ref_clk),
        .dec_en(h0_tmp[3]),
        .cnt_rst(AN_cnt_rst),
        .seg(SEG),
        .dp(DP),
        .an(AN)
    );
    
    wire clk25MHz;
    
    clk_wiz_0 clk_div0(
        .reset(h0_tmp[4]),
        .clk_in1(sys_clk),
        .clk_25MHz(clk25MHz),
        .locked()
    ); 
    
    vga_driver VGA_DRIVER(
        .clk(clk25MHz),
        .rst(h0_tmp[1]),
        .hash(hash_tmp),
        .o_hsync(o_hsync),
        .o_vsync(o_vsync),
        .o_red(o_red),
        .o_blue(o_blue),
        .o_green(o_green) 
    );
    
    
    
endmodule
