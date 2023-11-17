module mux_8x1_4bit(
    input [31:0] load_in,       // Inputs
    input [2:0] select,
    output [3:0] out            // Output
    );
    reg [3:0] out0;             // Temp register to transfer values
    always @ (select, load_in)
        begin 
            case (select)                           // Assign output dependent on select bits
                3'b000: out0 = load_in[3:0];        // Choose first 4 bits
                3'b001: out0 = load_in[7:4];        // Choose 2nd set of 4 bits
                3'b010: out0 = load_in[11:8];       // 3rd Set
                3'b011: out0 = load_in[15:12];      // 4th Set
                3'b100: out0 = load_in[19:16];      // ...
                3'b101: out0 = load_in[23:20];
                3'b110: out0 = load_in[27:24];
                3'b111: out0 = load_in[31:28];
                default: out0 = 4'bZZZZ;            // Default Case
            endcase
        end
    assign out = out0;    
endmodule
