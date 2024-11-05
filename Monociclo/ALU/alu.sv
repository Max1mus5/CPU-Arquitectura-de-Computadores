module ArithmeticLogicUnit (
    input  logic [31:0] operandA,     // First input operand
    input  logic [31:0] operandB,     // Second input operand
    input  logic [3:0]  operation,    // Operation selector
    output logic [31:0] result        // Operation result
);

    // Combinational logic block for ALU operations
    always_comb begin
        case(operation)
            // Arithmetic Operations
            4'b0000: result = operandA + operandB;                    // Addition
            4'b1000: result = operandA - operandB;                    // Subtraction
            
            // Logical Operations
            4'b0111: result = operandA & operandB;                    // Bitwise AND
            4'b0110: result = operandA | operandB;                    // Bitwise OR
            4'b0100: result = operandA ^ operandB;                    // Bitwise XOR
            
            // Shift Operations
            4'b0001: result = operandA << operandB;                   // Logical left shift
            4'b0105: result = operandA >> operandB;                   // Logical right shift
            4'b1101: result = operandA >>> operandB;                  // Arithmetic right shift
            4'b0010: result = $signed(operandA) << $signed(operandB); // Arithmetic left shift
            
            // Comparison Operations
            4'b0011: result = ($signed(operandA) < $signed(operandB)) ? 32'h1 : 32'h0; // Signed comparison
            
            // Default case
            default: result = operandA;                               // Pass through operandA
        endcase
    end

endmodule