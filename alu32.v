// Added NOR operation (3'b011) and status flag outputs

module alu32(sum, a, b, zout, nout, vout, gin);
    output [31:0] sum;
    input [31:0] a, b; 
    input [2:0] gin; // ALU control line
    
    reg [31:0] sum;
    reg [31:0] less;
    
    output zout;  // Zero flag
    output nout;  // Negative flag
    output vout;  // Overflow flag
    
    reg zout;
    reg nout;
    reg vout;
    
    always @(a or b or gin)
    begin
        case(gin)
            3'b010: sum = a + b;           // ADD
            3'b110: sum = a + 1 + (~b);    // SUB
            3'b111: begin                  // SLT (Set on Less Than)
                less = a + 1 + (~b);
                if (less[31]) sum = 1;
                else sum = 0;
            end
            3'b000: sum = a & b;           // AND
            3'b001: sum = a | b;           // OR
            3'b011: sum = ~(a | b);        // NOR (added for lwnor instruction)
            default: sum = 32'bx;
        endcase
        
        // Set status flags
        zout = ~(|sum);                    // Zero flag - set if result is zero
        nout = sum[31];                    // Negative flag - set if MSB is 1
        vout = 1'b0;                       // Overflow flag - simplified implementation
    end
endmodule
