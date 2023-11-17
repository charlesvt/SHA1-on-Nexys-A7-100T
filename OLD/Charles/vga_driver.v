`timescale 1ns / 1ps

module vga_driver(
	input clk,           // 50 MHz
    input rst,
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

wire clk25MHz;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clk divider 50 MHz to 25 MHz
clk_wiz_0 clk_div0(
    .reset(rst),
    .clk_in1(clk),
    .clk_25MHz(clk25MHz),
    .locked()
    );  
// end clk divider 50 MHz to 25 MHz

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// counter and sync generation
always @(posedge clk25MHz)  // horizontal counter
    begin 
        if (counter_x < 799)
            counter_x <= counter_x + 1;  // horizontal counter (including off-screen horizontal 160 pixels) total of 800 pixels 
        else
            counter_x <= 0;              
    end  // always 

always @ (posedge clk25MHz)  // vertical counter
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
                    r_red <= 4'h8;
                    r_blue <= 4'h8;
                    r_green <= 4'h8;
                end
            else 
            if (counter_x >= 250 && counter_x < 358) //COL2
                begin 
                    r_red <= 4'h0;
                    r_blue <= 4'h0;
                    r_green <= 4'h0;
                end
            else 
                if (counter_x >= 357 && counter_x < 465) //COL3
                    begin 
                        r_red <= 4'h8;
                        r_blue <= 4'h8;
                        r_green <= 4'h8;
                    end
            else 
                if (counter_x >= 464 && counter_x < 572) //COL4
                    begin 
                        r_red <= 4'h0;
                        r_blue <= 4'h0;
                        r_green <= 4'h0;
                    end
            else 
                if (counter_x >= 571 && counter_x < 678) //COL5
                    begin 
                        r_red <= 4'h8;
                        r_blue <= 4'h8;
                        r_green <= 4'h8;
                    end
            else 
                if (counter_x >= 677 && counter_x < 784) //COL6
                    begin 
                        r_red <= 4'h0;
                        r_blue <= 4'h0;
                        r_green <= 4'h0;
                    end
        end //counter_y >= 145 && counter_y < 250
        ////////////////////////////////////////////////////////////////////////////////////// END ROW1
        
        ////////////////////////////////////////////////////////////////////////////////////// ROW2
        if (counter_y >= 195 && counter_y < 356) begin              
            if (counter_x >= 144 && counter_x < 251) //COL1
                begin 
                    r_red <= 4'h0;
                    r_blue <= 4'h0;
                    r_green <= 4'h0;
                end
            else 
            if (counter_x >= 250 && counter_x < 358) //COL2
                begin 
                    r_red <= 4'h8;
                    r_blue <= 4'h8;
                    r_green <= 4'h8;
                end
            else 
                if (counter_x >= 357 && counter_x < 465) //COL3
                    begin 
                        r_red <= 4'h0;
                        r_blue <= 4'h0;
                        r_green <= 4'h0;
                    end
            else 
                if (counter_x >= 464 && counter_x < 572) //COL4
                    begin 
                        r_red <= 4'h8;
                        r_blue <= 4'h8;
                        r_green <= 4'h8;
                    end
            else 
                if (counter_x >= 571 && counter_x < 678) //COL5
                    begin 
                        r_red <= 4'h0;
                        r_blue <= 4'h0;
                        r_green <= 4'h0;
                    end
            else 
                if (counter_x >= 677 && counter_x < 784) //COL6
                    begin 
                        r_red <= 4'h8;
                        r_blue <= 4'h8;
                        r_green <= 4'h8;
                    end
        end //counter_y >= 195 && counter_y < 356
        ////////////////////////////////////////////////////////////////////////////////////// END ROW2
        
        ////////////////////////////////////////////////////////////////////////////////////// ROW3
        if (counter_y >= 355 && counter_y < 515) begin              
            if (counter_x >= 144 && counter_x < 251) //COL1
            begin 
                r_red <= 4'h8;
                r_blue <= 4'h8;
                r_green <= 4'h8;
            end
        else 
        if (counter_x >= 250 && counter_x < 358) //COL2
            begin 
                r_red <= 4'h0;
                r_blue <= 4'h0;
                r_green <= 4'h0;
            end
        else 
            if (counter_x >= 357 && counter_x < 465) //COL3
                begin 
                    r_red <= 4'h8;
                    r_blue <= 4'h8;
                    r_green <= 4'h8;
                end
        else 
            if (counter_x >= 464 && counter_x < 572) //COL4
                begin 
                    r_red <= 4'h0;
                    r_blue <= 4'h0;
                    r_green <= 4'h0;
                end
        else 
            if (counter_x >= 571 && counter_x < 678) //COL5
                begin 
                    r_red <= 4'h8;
                    r_blue <= 4'h8;
                    r_green <= 4'h8;
                end
        else 
            if (counter_x >= 677 && counter_x < 784) //COL6
                begin 
                    r_red <= 4'h0;
                    r_blue <= 4'h0;
                    r_green <= 4'h0;
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