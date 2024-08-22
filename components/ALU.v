module ALU(
    input wire [31:0] a,    // Operando A
    input wire [31:0] b,    // Operando B
    input wire [3:0] ALU_op,    // Código de operación ALU de 4 bits
    output reg [31:0] result, // Resultado
    output wire zero        // Bandera de cero
);

    // Operaciones: 
    // 0000 - Suma
    // 0001 - Resta
    // 0010 - A < B
    // 0011 - A < B (unsigned)
    // 0100 - AND
    // 0101 - OR
    // 0110 - XOR
    // 0111 - NOR
    // 1100 - Corrimiento a la derecha
    // 1101 - Corrimiento a la izquierda
 

    always @(*) begin
        case (ALU_op)
            4'b0000: result = a + b;    // Suma
            4'b0001: result = a - b;    // Resta
            4'b0010: result = (a < b) ? 1 : 0;    // A < B
            4'b0011: result = (a < b) ? 1 : 0;    // A < B (unsigned)
            4'b0100: result = a & b;    // AND
            4'b0101: result = a | b;    // OR
            4'b0110: result = a ^ b;    // XOR
            4'b0111: result = ~(a | b); // NOR
            4'b1100: result = a >> 1;   // Corrimiento a la derecha
            4'b1101: result = a << 1;   // Corrimiento a la izquierda
            default: result = 32'h00000000; // Operación no definida
        endcase
    end

    assign zero = (result == 32'b0);

endmodule
