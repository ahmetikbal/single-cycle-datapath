// Equality Comparator Module
// Compares two 32-bit values and outputs 1 if equal, 0 if not equal
// Used for beqm instruction and cmpeq instruction

module equality_comparator(a, b, is_equal);
    input [31:0] a;
    input [31:0] b;
    output is_equal;
    
    // Output 1 if inputs are equal, 0 otherwise
    assign is_equal = (a == b) ? 1'b1 : 1'b0;
endmodule
