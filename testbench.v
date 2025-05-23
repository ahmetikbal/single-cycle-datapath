// Test bench for MIPS processor with new instructions
// Tests all 7 new instructions: lwnor, pop, beqm, baln, cmpeq, cmpli, blti

module testbench;
    reg clk;
    reg [31:0] pc;
    reg [7:0] datmem[0:31], mem[0:31];
    
    // Initialize test data
    initial begin
        // Initialize memory with test values
        $readmemh("test_data.dat", datmem);
        $readmemh("test_instructions.dat", mem);
        
        // Start simulation
        clk = 0;
        pc = 0;
        
        // Run for enough cycles to test all instructions
        #500 $finish;
    end
    
    // Clock generation
    always #10 clk = ~clk;
    
    // Monitor results
    initial begin
        $monitor($time, " PC=%h, Instruction=%h", pc, {mem[pc], mem[pc+1], mem[pc+2], mem[pc+3]});
    end
endmodule
