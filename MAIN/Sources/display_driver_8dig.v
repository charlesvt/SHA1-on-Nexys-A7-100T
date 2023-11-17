module display_driver_8dig(
    input [31:0] in,     // Inputs
    input clk,
    input dec_en,
    input cnt_rst,
    output [6:0] seg,           // Outputs
    output dp,
    output [7:0] an
);
    wire [2:0] cnt_tmp;
    wire [3:0] mux_tmp;
    wire [7:0] dec_out_tmp;
    
    
    // Instantiate Blocks
    nbit_counter #(.DATA_SIZE(3)) AN_count(       
        .clk(clk),       // Link inputs/outputs
        .reset(cnt_rst),
        .counter(cnt_tmp)
    );
    
    mux_8x1_4bit GEN_MUX8X1_4BIT(
        .load_in(in),    // Link inputs/outputs
        .select(cnt_tmp),
        .out(mux_tmp)
        );
        
    dec_3x8 GEN_DEC3x8(
        .dec_en(dec_en),     // link inputs/outputs
        .dec_in(cnt_tmp),
        .dec_out(dec_out_tmp)
    );
    
    segment_display_7 GEN_7SEG_DISP(
        .SW(mux_tmp),
        .DP(dp),
        .SEG(seg)
    );
    
    assign an = ~dec_out_tmp;        // Active Low for Turning on Digits 
    
endmodule
