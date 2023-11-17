`timescale 1ns / 1ps

module Clock_Divder_tb(

    );
    reg sys_clk_tb;
    reg sys_rst_tb;
    reg [4:0] div1_tb;
    reg [4:0] div2_tb;
    wire clk1_tb;
    wire clk2_tb;
    
    Clock_Divider DUT(
        .sys_clk(sys_clk_tb),
        .sys_rst(sys_rst_tb),
        .div1(div1_tb),
        .div2(div2_tb),
        .clk1(clk1_tb),
        .clk2(clk2_tb)
    );
    
    initial begin
        sys_clk_tb = 0;
        sys_rst_tb = 1;
        div1_tb = 5'd1;
        div2_tb = 5'd2;
        #2 sys_rst_tb = 0;
    end
    
    always begin 
        #1 sys_clk_tb = ~sys_clk_tb;
    end
    
endmodule
