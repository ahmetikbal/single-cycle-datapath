// Zero Extension Module
// Extends a 16-bit immediate value to 32 bits with zeros
// Used for instructions that require zero extension rather than sign extension

module zeroext(in1, out1);
    input [15:0] in1;
    output [31:0] out1;
    
    // Zero extend the input by concatenating 16 zeros to the MSB side
    assign out1 = {16'b0, in1};
endmodule
