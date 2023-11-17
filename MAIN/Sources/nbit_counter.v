//Author: Andrew K.
module nbit_counter #(parameter DATA_SIZE = 64)(    // Allow parameter size
    input clk, reset,                               // Inputs
    output [DATA_SIZE-1:0] counter                  // Outputs
    );
        reg [DATA_SIZE-1:0] counter_up;             // Temp Register
        always @(posedge clk)                       // At every positive clock edge
        begin
            if(reset)                               // Check if reset is on
                counter_up <= 0;                    // Reset count
            else
                counter_up <= counter_up + 1;       // Else keep counting
        end 
        assign counter = counter_up;                // Assign from temp register
endmodule
