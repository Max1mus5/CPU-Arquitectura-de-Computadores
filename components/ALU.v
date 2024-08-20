module ALU(
    input wire [31:0] a,    // Operando A
    input wire [31:0] b,    // Operando B
    input wire [2:0] op,    // Código de operación
    output reg [31:0] result, // Resultado
    output wire zero        // Bandera de cero
);

    // Operaciones: 
    // 000 - Suma
    // 001 - Resta
    // 010 - AND
    // 011 - OR
    // 100 - XOR
    // 101 - NOR
    // 110 - Operación no definida
    // 111 - Operación no definida

    always @(*) begin
        case (op)
            3'b000: result = a + b;    // Suma
            3'b001: result = a - b;    // Resta
            3'b010: result = a & b;    // AND
            3'b011: result = a | b;    // OR
            3'b100: result = a ^ b;    // XOR
            3'b101: result = ~(a | b); // NOR
            default: result = 32'h00000000; // Operación no definida
        endcase
    end

    assign zero = (result == 32'b0);

endmodule
