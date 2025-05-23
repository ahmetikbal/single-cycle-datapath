// Multiplexer 3-to-1 32-bit
// Used for selecting between three 32-bit inputs
// Needed for new instructions that require additional datapath options

module mult3_to_1_32(out, i0, i1, i2, s);
    output [31:0] out;
    input [31:0] i0, i1, i2;
    input [1:0] s;
    
    // Select output based on select bits
    assign out = (s == 2'b00) ? i0 : 
                 (s == 2'b01) ? i1 : 
                 (s == 2'b10) ? i2 : i0; // Default to i0 if invalid select
endmodule
