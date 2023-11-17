//Author: Charles T.
module mux_2x1(
    input [1:0] mux2x1_d,
    input mux2x1_s,
    output mux2x1_y
    );
    
    assign mux2x1_y = (mux2x1_d[0]&~mux2x1_s)|(mux2x1_d[1]&mux2x1_s);

endmodule
