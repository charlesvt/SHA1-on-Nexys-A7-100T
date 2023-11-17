`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2022 05:19:48 PM
// Design Name: 
// Module Name: sha_core
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


module sha_core(
input clk,rst,
input [6:0] w_adress,
input [511:0] block,
output w
    );

reg [1:0] state; 
reg [1:0] next_state;  

reg start;
reg mem_ctrl; 

reg [31 : 0] w_mem [79 : 0];
reg [31:0] w_mem00_new;
reg [31:0] w_mem01_new;
reg [31:0] w_mem02_new;
reg [31:0] w_mem03_new;
reg [31:0] w_mem04_new;
reg [31:0] w_mem05_new;
reg [31:0] w_mem06_new;
reg [31:0] w_mem07_new;
reg [31:0] w_mem08_new;
reg [31:0] w_mem09_new;
reg [31:0] w_mem10_new;
reg [31:0] w_mem11_new;
reg [31:0]  w_mem12_new; 
reg [31:0]  w_mem13_new;
reg [31:0] w_mem14_new; 
reg [31:0] w_mem15_new; 
    
    //Intial H0 H1 H2 H3 H4
  parameter H0_0 = 32'h67452301;
  parameter H0_1 = 32'hefcdab89;
  parameter H0_2 = 32'h98badcfe;
  parameter H0_3 = 32'h10325476;
  parameter H0_4 = 32'hc3d2e1f0;
  
  //Active registers 
  reg [31 : 0] a;
  reg [31 : 0] b;
  reg [31 : 0] c;
  reg [31 : 0] d;
  reg [31 : 0] e;
  
//H
  reg [31 : 0] H0;
  reg [31 : 0] H1;
  reg [31 : 0] H2;
  reg [31 : 0] H3;
  reg [31 : 0] H4;
  
  
  reg [31 : 0] w_reg [3:0]; 
  integer count = 16; 
 ///////////////////////////////////////////////////////////////////////

    always @ (posedge clk or posedge rst) 
    begin: W_mem_update
   
    integer i; 
    if(rst) begin
    start <=0; 
    mem_ctrl<=0; 
    state <= 0; 
          for (i = 0 ; i < 16 ; i = i + 1)begin
            w_mem[i] <= 32'h0; end
            
                    H0 <= H0_0;
                    H1 <= H0_1; 
                    H2 <= H0_2;
                    H3 <= H0_3; 
                    H4 <= H0_4; 

    end
    
    else 
    state<=next_state; 
    
    end 
    
    always@(state or mem_ctrl)
    begin 
    
    case(state) 
    0: begin
          if (mem_ctrl )
          begin
          w_mem00_new = block[511 : 480];
          w_mem01_new = block[479 : 448];
          w_mem02_new = block[447 : 416];
          w_mem03_new = block[415 : 384];
          w_mem04_new = block[383 : 352];
          w_mem05_new = block[351 : 320];
          w_mem06_new = block[319 : 288];
          w_mem07_new = block[287 : 256];
          w_mem08_new = block[255 : 224];
          w_mem09_new = block[223 : 192];
          w_mem10_new = block[191 : 160];
          w_mem11_new = block[159 : 128];
          w_mem12_new = block[127 : 96];
          w_mem13_new = block[95 : 64];
          w_mem14_new = block[63 : 32];
          w_mem15_new = block[31 : 0];
           
         next_state = 1; 
         end
        end
    1:    //Set W 0-15
        if (mem_ctrl )
        begin
            begin
              w_mem[00] = w_mem00_new;
              w_mem[01] = w_mem01_new;
              w_mem[02] = w_mem02_new;
              w_mem[03] = w_mem03_new;
              w_mem[04] = w_mem04_new;
              w_mem[05] = w_mem05_new;
              w_mem[06] = w_mem06_new;
              w_mem[07] = w_mem07_new;
              w_mem[08] = w_mem08_new;
              w_mem[09] = w_mem09_new;
              w_mem[10] = w_mem10_new;
              w_mem[11] = w_mem11_new;
              w_mem[12] = w_mem12_new;
              w_mem[13] = w_mem13_new;
              w_mem[14] = w_mem14_new;
              w_mem[15] = w_mem15_new;
              mem_ctrl =0; 
              start =1; 
              next_state = 0; 
            end 
            end
      
    endcase
    end
    
 ///////////////////////////////////////////////////////////////////////
    always@(block)
    begin 
    mem_ctrl<=~mem_ctrl; 
    end  
 ///////////////////////////////////////////////////////////////////////
 integer j; 
  always@(posedge start)
    begin: Message_Schedule
   
    integer i; 
    if(start) begin
    //start =0; 
          for (i = 16 ; i < 80 ; i = i + 1)begin
         #1   j = i -3; 
          w_reg[0] = w_mem[j];
           #1 j =i - 8; 
          w_reg[1] = w_mem[j];
         #1 j =i - 14; 
          w_reg[2] = w_mem[j];
          #1 j =i - 16; 
           w_reg[3] = w_mem[j]; 
           
           w_mem[i] = {w_reg[0] ^ w_reg[1]^w_reg[2]^w_reg[3]}<<1;
  
            end       
    end
    end  
    
    
endmodule
