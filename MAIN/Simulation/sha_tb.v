`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2022 12:09:03 PM
// Design Name: 
// Module Name: sha_tb
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


module sha_tb;
reg clk,rst;
reg [511:0] block;
 wire [31:0] H_0;
 wire [31:0] H_1;
 wire [31:0] H_2;
 wire [31:0] H_3;
 wire [31:0] H_4;
 
sha_core DUT(
.clk(clk),.rst(rst),
.block(block),
.H_0(H_0),
.H_1(H_1),
.H_2(H_2),
.H_3(H_3),
.H_4(H_4)
   
    );
    
    
    initial 
    begin 
    rst = 1; clk = 0; 
    
    #2 block = 0; 
    #3 rst = 0;   
    end 
    
    always 
    #2 clk <=~clk; 
endmodule
