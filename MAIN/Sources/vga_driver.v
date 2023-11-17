`timescale 1ns / 1ps
//Author: Dominic Meads
//Modified By: Charles Tran
//Takes in values of the 160 bit hash and inputs them into VGA

module vga_driver(
	input clk,           // 50 MHz
    input rst,
    input [159:0] hash,
    output o_hsync,      // horizontal sync
    output o_vsync,         // vertical sync
    output [3:0] o_red,
    output [3:0] o_blue,
    output [3:0] o_green  
);

reg [9:0] counter_x = 0;  // horizontal counter
reg [9:0] counter_y = 0;  // vertical counter
reg [3:0] r_red = 0;
reg [3:0] r_blue = 0;
reg [3:0] r_green = 0;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clk divider 50 MHz to 25 MHz
 
// end clk divider 50 MHz to 25 MHz

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// counter and sync generation
always @(posedge clk)  // horizontal counter
    begin 
        if (counter_x < 799)
            counter_x <= counter_x + 1;  // horizontal counter (including off-screen horizontal 160 pixels) total of 800 pixels 
        else
            counter_x <= 0;              
    end  // always 

always @ (posedge clk)  // vertical counter
    begin 
        if (counter_x == 799)  // only counts up 1 count after horizontal finishes 800 counts
            begin
                if (counter_y < 525)  // vertical counter (including off-screen vertical 45 pixels) total of 525 pixels
                    counter_y <= counter_y + 1;
                else
                    counter_y <= 0;              
            end  // if (counter_x...
    end  // always
// end counter and sync generation  

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// hsync and vsync output assignments
assign o_hsync = (counter_x >= 0 && counter_x < 96) ? 1:0;  // hsync high for 96 counts                                                 
assign o_vsync = (counter_y >= 0 && counter_y < 2) ? 1:0;   // vsync high for 2 counts
// end hsync and vsync output assignments

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// pattern generate
    always @ (posedge clk)
    begin
        ////////////////////////////////////////////////////////////////////////////////////// ROW1
        if (counter_y >= 36 && counter_y < 196) begin              
            if (counter_x >= 144 && counter_x < 251) //COL1
                begin 
                    r_red <= {0,hash[2:0]};
                    r_blue <= {0,hash[5:3]};
                    r_green <= {0,hash[8:6]};
                end
            else 
            if (counter_x >= 250 && counter_x < 358) //COL2
                begin 
                    r_red <= {0,hash[11:9]};
                    r_blue <= {0,hash[14:12]};
                    r_green <= {0,hash[17:15]};
                end
            else 
            if (counter_x >= 357 && counter_x < 465) //COL3
                begin 
                    r_red <= {0,hash[20:18]};
                    r_blue <= {0,hash[23:21]};
                    r_green <= {0,hash[26:24]};
                end
            else 
            if (counter_x >= 464 && counter_x < 572) //COL4
                begin 
                    r_red <= {0,hash[29:27]};
                    r_blue <= {0,hash[32:30]};
                    r_green <= {0,hash[35:33]};
                end
            else 
            if (counter_x >= 571 && counter_x < 678) //COL5
                begin 
                    r_red <= {0,hash[38:36]};
                    r_blue <= {0,hash[41:39]};
                    r_green <= {0,hash[44:42]};
                end
            else 
            if (counter_x >= 677 && counter_x < 784) //COL6
                begin 
                    r_red <= {0,hash[47:45]};
                    r_blue <= {0,hash[50:48]};
                    r_green <= {0,hash[53:51]};
                end
        end //counter_y >= 145 && counter_y < 250
        ////////////////////////////////////////////////////////////////////////////////////// END ROW1
        
        ////////////////////////////////////////////////////////////////////////////////////// ROW2
        if (counter_y >= 195 && counter_y < 356) begin              
            if (counter_x >= 144 && counter_x < 251) //COL1
                begin 
                    r_red <= {0,hash[56:54]};
                    r_blue <= {0,hash[59:57]};
                    r_green <= {0,hash[62:60]};
                end
            else 
            if (counter_x >= 250 && counter_x < 358) //COL2
                begin 
                    r_red <= {0,hash[65:63]};
                    r_blue <= {0,hash[68:66]};
                    r_green <= {0,hash[71:69]};
                end
            else 
            if (counter_x >= 357 && counter_x < 465) //COL3
                begin 
                    r_red <= {0,hash[74:72]};
                    r_blue <= {0,hash[77:75]};
                    r_green <= {0,hash[80:78]};
                end
            else 
            if (counter_x >= 464 && counter_x < 572) //COL4
                begin 
                    r_red <= {0,hash[83:81]};
                    r_blue <= {0,hash[86:84]};
                    r_green <= {0,hash[89:87]};
                end
            else 
            if (counter_x >= 571 && counter_x < 678) //COL5
                begin 
                    r_red <= {0,hash[92:90]};
                    r_blue <= {0,hash[95:93]};
                    r_green <= {0,hash[98:96]};
                end
            else 
            if (counter_x >= 677 && counter_x < 784) //COL6
                begin 
                    r_red <= {0,hash[101:99]};
                    r_blue <= {0,hash[104:102]};
                    r_green <= {0,hash[107:105]};
                end
        end //counter_y >= 195 && counter_y < 356
        ////////////////////////////////////////////////////////////////////////////////////// END ROW2
        
        ////////////////////////////////////////////////////////////////////////////////////// ROW3
        if (counter_y >= 355 && counter_y < 515) begin              
            if (counter_x >= 144 && counter_x < 251) //COL1
                begin 
                    r_red <= {0,hash[110:108]};
                    r_blue <= {0,hash[113:111]};
                    r_green <= {0,hash[116:114]};
                end
            else 
            if (counter_x >= 250 && counter_x < 358) //COL2
                begin 
                    r_red <= {0,hash[119:117]};
                    r_blue <= {0,hash[122:120]};
                    r_green <= {0,hash[125:123]};
                end
            else 
            if (counter_x >= 357 && counter_x < 465) //COL3
                begin 
                    r_red <= {0,hash[128:126]};
                    r_blue <= {0,hash[131:129]};
                    r_green <= {0,hash[134:132]};
                end
            else 
            if (counter_x >= 464 && counter_x < 572) //COL4
                begin 
                    r_red <= {0,hash[137:135]};
                    r_blue <= {0,hash[140:138]};
                    r_green <= {0,hash[143:141]};
                end
            else 
            if (counter_x >= 571 && counter_x < 678) //COL5
                begin 
                    r_red <= {0,hash[146:144]};
                    r_blue <= {0,hash[149:147]};
                    r_green <= {0,hash[152:150]};
                end
            else 
            if (counter_x >= 677 && counter_x < 784) //COL6
                begin 
                    r_red <= {0,hash[155:153]};
                    r_blue <= {2'b0,hash[157:156]};
                    r_green <= {2'b0,hash[159:158]};
                end
        end //counter_y >= 355 && counter_y < 515
        ////////////////////////////////////////////////////////////////////////////////////// END ROW3

    end  // always
                    
// end pattern generate

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// color output assignments
// only output the colors if the counters are within the adressable video time constraints
assign o_red = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_red : 4'h0;
assign o_blue = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_blue : 4'h0;
assign o_green = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_green : 4'h0;
// end color output assignments

endmodule  // VGA_image_gen