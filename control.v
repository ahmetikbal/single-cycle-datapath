// Added support for new instructions: lwnor, pop, beqm, baln, cmpeq, cmpli, blti

module control(in, regdest, alusrc, memtoreg, regwrite, memread, memwrite, branch, 
                       aluop1, aluop0, jump, link, is_pop, is_lwnor, is_beqm, is_cmpeq, 
                       is_cmpli, is_blti, branch_on_n);
    input [5:0] in;
    output regdest, alusrc, memtoreg, regwrite, memread, memwrite, branch, aluop1, aluop0;
    output jump, link, is_pop, is_lwnor, is_beqm, is_cmpeq, is_cmpli, is_blti, branch_on_n;
    
    wire rformat, lw, sw, beq;
    
    // Original instruction decoding
    assign rformat = ~|in;
    assign lw = in[5] & (~in[4]) & (~in[3]) & (~in[2]) & in[1] & in[0];
    assign sw = in[5] & (~in[4]) & in[3] & (~in[2]) & in[1] & in[0];
    assign beq = ~in[5] & (~in[4]) & (~in[3]) & in[2] & (~in[1]) & (~in[0]);
    
    // New instruction decoding
    wire pop, cmpli, blti, baln;
    assign pop = (in == 6'b010011);    // opcode=19
    assign cmpli = (in == 6'b100110);  // opcode=38
    assign blti = (in == 6'b101100);   // opcode=44
    assign baln = (in == 6'b011011);   // opcode=27
    
    // Original control signals
    assign regdest = rformat;
    assign alusrc = lw | sw | pop | cmpli | blti;  // Modified for new I-type instructions
    assign memtoreg = lw | pop;  // Modified for pop instruction
    assign regwrite = rformat | lw | pop | cmpli;  // Modified for new instructions that write to registers
    assign memread = lw | pop;   // Modified for pop instruction
    assign memwrite = sw;
    assign branch = beq | blti;  // Modified for blti instruction
    assign aluop1 = rformat;
    assign aluop0 = beq;
    
    // New control signals
    assign jump = baln;          // Jump signal for baln instruction
    assign link = baln;          // Link signal for baln instruction (store return address)
    assign is_pop = pop;         // Signal for pop instruction
    assign is_lwnor = rformat;   // lwnor is R-type, will be further decoded by function code
    assign is_beqm = rformat;    // beqm is R-type, will be further decoded by function code
    assign is_cmpeq = rformat;   // cmpeq is R-type, will be further decoded by function code
    assign is_cmpli = cmpli;     // Signal for cmpli instruction
    assign is_blti = blti;       // Signal for blti instruction
    assign branch_on_n = baln;   // Branch on negative flag for baln instruction
endmodule
