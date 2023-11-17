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
input [511:0] block,
output [31:0] H_0,H_1,H_2,H_3,H_4,
output done
    );

reg [2:0] state; 
reg [2:0] next_state;  

reg tmp_done;


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
  reg [31 : 0] a, tmp_a;
  reg [31 : 0] b, tmp_b;
  reg [31 : 0] c;
  reg [31 : 0] d;
  reg [31 : 0] e;
  
//H
  reg [31 : 0] H0;
  reg [31 : 0] H1;
  reg [31 : 0] H2;
  reg [31 : 0] H3;
  reg [31 : 0] H4;
  
//F and T 
  reg [31:0] F;
  reg [31:0] T;
  reg [31:0] K;  
  
  reg [31 : 0] w_reg [3:0]; 
  

 ///////////////////////////////////////////////////////////////////////

    always @ (posedge clk or posedge rst) 
    begin: States
    if(rst) begin  
    //tmp_done <=1; 
    state <= 0; 
            end
    
    else 
    state<=next_state; 
    
    end 
    //////////////////////////////////////////////////////////
    always@(state, block,  rst )
    begin: STATE
        integer i; 
        if(rst) begin  
         for (i = 0 ; i < 16 ; i = i + 1)begin
            w_mem[i] = 32'h0; end
            
       H0 = H0_0;
       H1 = H0_1; 
       H2 = H0_2;
       H3 = H0_3; 
       H4 = H0_4; 
                 end
   
    else begin 
                 
    case(state) 
    3'b000: begin //Set W 0-15
        if(done)begin 
          w_mem[15] = block[511 : 480];
          w_mem[14] = block[479 : 448];
          w_mem[13] = block[447 : 416];
          w_mem[12] = block[415 : 384];
          w_mem[11] = block[383 : 352];
          w_mem[10] = block[351 : 320];
          w_mem[9] = block[319 : 288];
          w_mem[8] = block[287 : 256];
          w_mem[7] = block[255 : 224];
          w_mem[6] = block[223 : 192];
          w_mem[5] = block[191 : 160];
          w_mem[4] = block[159 : 128];
          w_mem[3] = block[127 : 96];
          w_mem[2] = block[95 : 64];
          w_mem[1] = block[63 : 32];
          w_mem[0] = block[31 : 0];
           
         next_state = 1; 
          end
             
              
         end
        
    3'b001:    //Set W 16-79               
        begin: W_schedule
        integer i,j; 
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
            
            a = H0;
            b= H1; 
            c = H2; 
            d = H3; 
            e = H4; 
            
            next_state = 2;  
            end  
    3'b010:  begin: Workingvariables_0_t_19
        integer i,j; 
        for (i = 0 ; i < 20 ; i = i + 1)begin
         
            T = tmp_a +F + e + K +  w_mem[i];
            e = d; 
            d = c; 
            c = tmp_b; 
            b = a; 
            a = T; 
            
            
            end 
            next_state = 3; 
            end
            
      3'b011:  begin: Workingvariables_20_t_39
        integer i,j; 
        for (i = 20 ; i < 39 ; i = i + 1)begin
            
            T = tmp_a +F + e + K +  w_mem[i];
            e = d; 
            d = c; 
            c = tmp_b; 
            b = a; 
            a = T;
            end 
            next_state = 4; 
            end
      
      3'b100:  begin: Workingvariables_40_t_59
        integer i,j; 
        for (i = 20 ; i < 39 ; i = i + 1)begin
            
            T = tmp_a +F + e + K +  w_mem[i];
            e = d; 
            d = c; 
            c = tmp_b; 
            b = a; 
            a = T;
  
            end 
            next_state = 5; 
            end
   
     3'b101:  begin: Workingvariables_60_t_79
        integer i,j; 
        for (i = 60 ; i < 79 ; i = i + 1)begin
            
            T = tmp_a +F + e + K +  w_mem[i];
            e = d; 
            d = c; 
            c = tmp_b; 
            b = a; 
            a = T;
  
            end
             
            next_state = 6; 
            end
      
      3'b110:  begin
      
             H0 = a + H0; 
             H1 = b + H1; 
             H2 = c + H2; 
             H3 = d + H3; 
             H4 = e + H4; 
               
           
                next_state = 7;   
                    end
      
      3'b111:  begin
       // Ends here 
                    end
    
    endcase
    end
    end 
 ///////////////////////////////////////////////////////////////////////
 /*always @( next_state) 
 begin 
 if(next_state == 7) 
 tmp_done = 1; 
 else
 tmp_done =0; 
 end
 */
 ///////////////////////////////////////////////////////////////////////

  always@(next_state)
    begin
    if (next_state == 2) begin
    K = 32'h5a827999 ;
    F =( (b & c) ^ (b & d) );
    tmp_a = (a<<5);
    tmp_b = (b<<30); 
    end
    
    if (next_state ==3)begin 
    K = 32'h6ed9eba1;
    F =( b ^ c ^ d );
    tmp_a = (a<<5);
    tmp_b = (b<<30); 
    end 
      if (next_state ==4)begin 
    K = 32'h8f1bbcdc ;
    F =( (b & c) ^ (b & d) ^ (c & d) );
    tmp_a = (a<<5);
    tmp_b = (b<<30); 
    end  
    
      if (next_state ==5)begin 
    K = 32'hca62c1d6;
    F =( b ^ c ^ d );
    tmp_a = (a<<5);
    tmp_b = (b<<30); 
    end 
   
   
    end
  ///////////////////////////////////////////////////////////////////////
  
  
   assign H_0 = a + H0; 
   assign H_1 = b + H1; 
   assign H_2 = c + H2; 
   assign H_3 = d + H3; 
   assign H_4 = e + H4; 
   assign done =tmp_done; 
   
endmodule
