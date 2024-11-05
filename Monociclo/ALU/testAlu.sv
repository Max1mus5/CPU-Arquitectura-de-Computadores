module ALU_testbench();
    // Signal declarations
    logic [31:0] operandA;
    logic [31:0] operandB;
    logic [3:0]  operation;
    logic [31:0] result;
    
    // Instantiate the ALU
    ArithmeticLogicUnit dut(
        .operandA(operandA),
        .operandB(operandB),
        .operation(operation),
        .result(result)
    );
    
    // Test stimulus
    initial begin
        // Test 1: Addition
        operandA = 32'h5; operandB = 32'h3; operation = 4'b0000;
        #10;
        if (result !== 32'h8) $display("Addition failed");
        
        // Test 2: Subtraction
        operandA = 32'h5; operandB = 32'h3; operation = 4'b1000;
        #10;
        if (result !== 32'h2) $display("Subtraction failed");
        
        // Test 3: Bitwise AND
        operandA = 32'hF0F0; operandB = 32'hFF00; operation = 4'b0111;
        #10;
        if (result !== 32'hF000) $display("AND failed");
        
        // Test 4: Bitwise OR
        operandA = 32'hF0F0; operandB = 32'h0F0F; operation = 4'b0110;
        #10;
        if (result !== 32'hFFFF) $display("OR failed");
        
        // Test 5: Bitwise XOR
        operandA = 32'hFFFF; operandB = 32'hF0F0; operation = 4'b0100;
        #10;
        if (result !== 32'h0F0F) $display("XOR failed");
        
        // Test 6: Logical left shift
        operandA = 32'h1; operandB = 32'h2; operation = 4'b0001;
        #10;
        if (result !== 32'h4) $display("Left shift failed");
        
        // Test 7: Logical right shift
        operandA = 32'h8; operandB = 32'h1; operation = 4'b0101;
        #10;
        if (result !== 32'h4) $display("Right shift failed");
        
        // Test 8: Arithmetic right shift
        operandA = 32'h80000000; operandB = 32'h1; operation = 4'b1101;
        #10;
        if (result !== 32'hC0000000) $display("Arithmetic right shift failed");
        
        // Test 9: Arithmetic left shift
        operandA = 32'h1; operandB = 32'h2; operation = 4'b0010;
        #10;
        if (result !== 32'h4) $display("Arithmetic left shift failed");
        
        // Test 10: Signed comparison
        operandA = 32'hFFFFFFFF; operandB = 32'h1; operation = 4'b0011;
        #10;
        if (result !== 32'h1) $display("Signed comparison failed");
        
        // Test 11: Default case
        operandA = 32'h5; operandB = 32'h3; operation = 4'b1111;
        #10;
        if (result !== operandA) $display("Default case failed");
        
        $display("All tests completed!");
        $finish;
    end
    
    // Waveform generation
    initial begin
        $dumpfile("alu_test.vcd");
        $dumpvars(0, ALU_testbench);
    end

endmodule