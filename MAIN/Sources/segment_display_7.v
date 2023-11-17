module segment_display_7(
    input [3:0] SW,
    output DP,
    output [6:0] SEG
    );
    reg [6:0] SEG_tmp;
    
    always @ (SW)
        begin
            case(SW)                            // Display for each number
                4'h0: SEG_tmp = 7'b0000001;
                4'h1: SEG_tmp = 7'b1001111;
                4'h2: SEG_tmp = 7'b0010010;
                4'h3: SEG_tmp = 7'b0000110;
                4'h4: SEG_tmp = 7'b1001100;
                4'h5: SEG_tmp = 7'b0100100;
                4'h6: SEG_tmp = 7'b0100000;
                4'h7: SEG_tmp = 7'b0001111;
                4'h8: SEG_tmp = 7'b0000000;
                4'h9: SEG_tmp = 7'b0000100;
                4'ha: SEG_tmp = 7'b0001000;
                4'hb: SEG_tmp = 7'b1100000;
                4'hc: SEG_tmp = 7'b0110001;
                4'hd: SEG_tmp = 7'b1000010;
                4'he: SEG_tmp = 7'b0110000;
                4'hf: SEG_tmp = 7'b0111000;
                default: SEG_tmp = 7'dZ;
            endcase
        end
    assign SEG = SEG_tmp;
    assign DP = 1'b1;                           // Turn off decimal point
endmodule
