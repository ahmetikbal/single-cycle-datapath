// Status Register Module
// Stores Z (zero), N (negative), and V (overflow) flags
// Used by conditional branch instructions

module status_register(clk, alu_result, zout, nout, vout);
    input clk;
    input [31:0] alu_result;
    input zout;  // Zero flag from ALU
    output reg nout;  // Negative flag
    output reg vout;  // Overflow flag (not fully implemented in this version)
    
    // Update status register on positive clock edge
    always @(posedge clk) begin
        // N flag - set if result is negative (MSB is 1)
        nout <= alu_result[31];
        
        // V flag - overflow detection would require additional logic
        // For this implementation, we'll set it to 0 as it's not fully used
        vout <= 1'b0;
    end
endmodule
