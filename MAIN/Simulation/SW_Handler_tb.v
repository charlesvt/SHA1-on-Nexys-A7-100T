`timescale 1ns / 1ps

module SW_Handler_tb();
    reg [1:0] h_sel_tb;
    reg [4:0] SW_tb;
    reg clk_tb;
    reg rst_tb;
    reg push_tb;
    wire [4:0] h0_tb;
    wire [4:0] h1_tb;
    wire [4:0] h2_tb;
    wire [2:0] h3_tb;
    
    switch_handler dut(
        .h_select(h_sel_tb),
        .SW(SW_tb),
        .clk(clk_tb),
        .rst(rst_tb),
        .push(push_tb),
        .h0(h0_tb),
        .h1(h1_tb),
        .h2(h2_tb),
        .h3(h3_tb)
    );
    initial begin
        clk_tb = 0;
        rst_tb = 1;
        #2 h_sel_tb = 2'b00;
        #2 SW_tb = 5'b00110;
        #2 push_tb = 1;
        #3 push_tb = 0;
        #2 h_sel_tb = 2'b01;
        #2 SW_tb = 5'b00110;
        #2 push_tb = 1;
        #3 push_tb = 0;
        #2 h_sel_tb = 2'b10;
        #2 SW_tb = 5'b10011;
        #2 push_tb = 1;
        #3 push_tb = 0;
        #2 h_sel_tb = 2'b01;
        #2 SW_tb = 5'b00010;
        #2 push_tb = 1;
        #3 push_tb = 0;
        #2 h_sel_tb = 2'b10;
        #2 SW_tb = 5'b00011;
        #2 push_tb = 1;
        #3 push_tb = 0;
        #2 h_sel_tb = 2'b11;
        #2 h_sel_tb = 2'b11;
        #2 SW_tb = 5'b101;
        #2 push_tb = 1;
        #3 push_tb = 0; 
        #2 rst_tb = 0;
    end
    
    always begin
        #1 clk_tb = ~clk_tb;
    end
    
endmodule
