// Added support for NOR operation and new R-type instructions

module alucont(aluop1, aluop0, f5, f4, f3, f2, f1, f0, gout);
    input aluop1, aluop0, f5, f4, f3, f2, f1, f0;
    output [2:0] gout;
    reg [2:0] gout;
    
    // Function codes for new R-type instructions
    wire lwnor, beqm, cmpeq;
    assign lwnor = (f5 == 0) && (f4 == 0) && (f3 == 0) && (f2 == 1) && (f1 == 0) && (f0 == 1); // func=23 (010111)
    assign beqm = (f5 == 0) && (f4 == 0) && (f3 == 0) && (f2 == 1) && (f1 == 1) && (f0 == 0);  // func=24 (011000)
    assign cmpeq = (f5 == 1) && (f4 == 0) && (f3 == 1) && (f2 == 1) && (f1 == 1) && (f0 == 0); // func=46 (101110)
    
    always @(aluop1 or aluop0 or f5 or f4 or f3 or f2 or f1 or f0 or lwnor or beqm or cmpeq)
    begin
        if(~(aluop1|aluop0))  gout=3'b010;  // Default: ADD for lw/sw/addi
        if(aluop0) gout=3'b110;             // SUB for beq
        if(aluop1)                          // R-type instructions
        begin
            if (~(f3|f2|f1|f0)) gout=3'b010;    // function code=0000, ALU control=010 (add)
            if (f1&f3) gout=3'b111;             // function code=1x1x, ALU control=111 (set on less than)
            if (f1&~(f3)) gout=3'b110;          // function code=0x10, ALU control=110 (sub)
            if (f2&f0) gout=3'b001;             // function code=x1x1, ALU control=001 (or)
            if (f2&~(f0)) gout=3'b000;          // function code=x1x0, ALU control=000 (and)
            
            // New instruction support
            if (lwnor) gout=3'b011;             // NOR operation for lwnor
            if (cmpeq) gout=3'b110;             // SUB operation for cmpeq (to check equality)
        end
    end
endmodule
