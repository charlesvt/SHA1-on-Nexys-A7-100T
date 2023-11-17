//Author: Charles T.
module nbit_mux #(parameter DATA_SIZE = 8)(
    input [2**DATA_SIZE-1:0] muxNx1_d,
    input [DATA_SIZE-1:0] muxNx1_s,
    output muxNx1_y
    );
    
    // Instantiate Mux Based off Parameter DATA_SIZE
    genvar i,j;
    wire [2**(DATA_SIZE+1)-2:0] tmp;
    generate
        for(i=0;i<DATA_SIZE;i=i+1)
        begin
            for(j=0;j<2**(DATA_SIZE-1-i);j=j+1)
            begin
                mux_2x1 GEN_MUX(
                    .mux2x1_d(tmp[2*j+1+2**(DATA_SIZE+1)-2**(DATA_SIZE+1-i):2*j+2**(DATA_SIZE+1)-2**(DATA_SIZE+1-i)]),
                    .mux2x1_s(muxNx1_s[i]),
                    .mux2x1_y(tmp[j+2**(DATA_SIZE+1)-2**(DATA_SIZE-i)])
                );
            end
        end
    endgenerate
    
    assign tmp[2**DATA_SIZE-1:0] = muxNx1_d;
    assign muxNx1_y = tmp[2**(DATA_SIZE+1)-2];
    
endmodule