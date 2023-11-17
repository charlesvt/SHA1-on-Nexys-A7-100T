`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2022 10:50:30 AM
// Design Name: 
// Module Name: top_tb
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


module top_tb(

    );
    reg sys_rst_tb;
    reg sys_clk_tb;
    reg UART_rst_tb;
    reg UART_Rx_tb;
    reg sha_rst_tb;
    reg AN_cnt_rst_tb;
    reg div_clk_rst_tb;
    reg [1:0] h_sel_tb;
    reg [4:0] SW_tb;
    reg push_tb;
    wire UART_rx_empty_tb;
    wire [6:0] SEG_tb;
    wire DP_tb;
    wire [7:0] AN_tb;
    wire [4:0] LED_tb;
    wire [3:0] o_red_tb;
    wire [3:0] o_green_tb;
    wire [3:0] o_blue_tb;
    wire o_hsync_tb;
    wire o_vsync_tb;
    
    top DUT (
        .sys_rst(sys_rst_tb),
        .sys_clk(sys_clk_tb),
        .UART_rst(UART_rst_tb),
        .UART_Rx(UART_Rx_tb),
        .sha_rst(sha_rst_tb),
        .AN_cnt_rst(AN_cnt_rst_tb),
        .div_clk_rst(div_clk_rst_tb),
        .h_sel(h_sel_tb),
        .SW(SW_tb),
        .push(push_tb),
        .UART_rx_empty(UART_rx_empty_tb),
        .SEG(SEG_tb),
        .DP(DP_tb),
        .AN(AN_tb),
        .LED(LED_tb),
        .o_red(o_red_tb),
        .o_green(o_green_tb),
        .o_blue(o_blue_tb),
        .o_hsync(o_hsync_tb),
        .o_vsync(o_vsync_tb)
    );
    
    initial begin
        sys_clk_tb = 0;
        sys_rst_tb = 1;
        UART_rst_tb = 1;
        sha_rst_tb = 1;
        AN_cnt_rst_tb = 1;
        UART_Rx_tb = 0;
        div_clk_rst_tb = 1;
        #2 div_clk_rst_tb = 0;
        #1 h_sel_tb = 2'b00;
        #1 SW_tb = 5'b10111;
        #1 push_tb = 1;
        #3 push_tb = 0;
        #100 h_sel_tb = 2'b00;
        #1 SW_tb = 5'b00000;
        #1 push_tb = 1;
        #3 push_tb = 0;
        #1 h_sel_tb = 2'b01;
        #1 SW_tb = 5'b00110;
        #1 push_tb = 1;
        #3 push_tb = 0;
        #1 h_sel_tb = 2'b10;
        #1 SW_tb = 5'b10011;
        #1 push_tb = 1;
        #3 push_tb = 0;
        #1 h_sel_tb = 2'b11;
        #1 SW_tb = 5'b101;
        #1 push_tb = 1;
        #3 push_tb = 0; 
        #3 sys_rst_tb = 0;
        #1 AN_cnt_rst_tb = 0;
        #4 UART_rst_tb = 0;
        #10 sha_rst_tb = 0;
        #10 UART_Rx_tb = 1;
        
    end
    
    always begin
        #1 sys_clk_tb = ~sys_clk_tb;
    end
    
endmodule
