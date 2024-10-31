module ImmGen(instruction, immediateSource, immediateExtended);

    input logic [24:0] instruction;      // Instrucción de 25 bits como entrada
    input logic [2:0] immediateSource;    // Fuente del valor inmediato (3 bits)
    output logic [31:0] immediateExtended; // Valor inmediato extendido a 32 bits

    always @* begin
        // Selecciona el tipo de extensión del inmediato basado en immediateSource
        case(immediateSource)
            3'b000: begin
                // Extensión de inmediato tipo 0: toma los bits [24:13] de la instrucción
                immediateExtended[11:0] = instruction[24:13];
                // Extiende el signo: copia el bit más significativo (bit 11) a los bits superiores
                immediateExtended[31:12] = {20{immediateExtended[11]}};
            end
            3'b001: begin
                // Extensión de inmediato tipo 1: combina bits específicos de la instrucción
                immediateExtended[11:0] = {instruction[24:18], instruction[4:0]};
                // Extiende el signo como en el caso anterior
                immediateExtended[31:12] = {20{immediateExtended[11]}};
            end
            3'b010: begin
                // Extensión de inmediato tipo 2: toma los bits [24:5] de la instrucción
                immediateExtended[20:0] = {instruction[24:5]};
                // Extiende el signo a los bits superiores
                immediateExtended[31:21] = {10{immediateExtended[20]}};
            end
            3'b101: begin
                // Extensión de inmediato tipo 3: reorganiza y combina bits específicos
                immediateExtended[12:0] = {instruction[24], instruction[0], instruction[23:18], instruction[4:1], 1'b0};
                // Extiende el signo para ocupar los bits superiores
                immediateExtended[31:13] = {19{immediateExtended[12]}};
            end
            3'b110: begin
                // Extensión de inmediato tipo 4: combina varios bits de la instrucción
                immediateExtended[20:0] = {instruction[24], instruction[12:5], instruction[13], instruction[23:14], 1'b0};
                // Extiende el signo a los bits superiores
                immediateExtended[31:21] = {11{immediateExtended[20]}};
            end
            default: immediateExtended = 32'h0; // Valor por defecto si immediateSource no coincide
        endcase
    end
endmodule
