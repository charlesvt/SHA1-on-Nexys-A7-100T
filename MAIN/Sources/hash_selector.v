`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2022 05:10:03 AM
// Design Name: 
// Module Name: hash_selector
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


module hash_selector(
    input [255:0] load_in,       // Inputs
    input [2:0] select,
    output [31:0] out,            // Output
    output [4:0] led
);
reg [31:0] out0;             // Temp register to transfer values
reg [4:0] led0;
always @ (select, load_in)
    begin 
        case (select)                           // Assign output dependent on select bits
            3'b000: begin
                out0 = load_in[31:0];        // Choose first 4 bits
                led0 = 4'b0001;
            end
            3'b001: begin 
                out0 = load_in[63:32];        // Choose 2nd set of 4 bits
                led0 = 4'b0010;
            end
            3'b010: begin
                out0 = load_in[95:64];       // 3rd Set
                led0 = 4'b0100;
            end
            3'b011: begin
                out0 = load_in[127:96];      // 4th Set
                led0 = 4'b1000;
            end
            3'b100: begin 
                out0 = load_in[159:128];      // ...
                led0 = 4'h1000;
            end
            3'b101: begin 
                out0 = load_in[191:160];
                led0 = 4'h0;
            end
            3'b110: begin 
                out0 = load_in[223:192];
                led0 = 4'h0;
            end
            3'b111: begin 
                out0 = load_in[255:224];
                out0 = 4'h0;
            end
            default: begin 
                out0 = 32'hZZZZZZZZ;            // Default Case
                led0 = 4'hZ;
            end
        endcase
    end
assign out = out0;    
assign led = led0;    
endmodule