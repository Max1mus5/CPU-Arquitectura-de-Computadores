`timescale 1ns/1ps

module ImmGen_tb;

    // Señales de entrada y salida
    reg [24:0] instruction;         // Instrucción de 25 bits
    reg [2:0] immediateSource;      // Fuente del valor inmediato
    wire [31:0] immediateExtended;  // Valor inmediato extendido a 32 bits

    // Instancia del módulo ImmGen
    ImmGen uut (
        .instruction(instruction),
        .immediateSource(immediateSource),
        .immediateExtended(immediateExtended)
    );

    // Proceso de simulación
    initial begin
        // Caso de prueba: Tipo I (addi y similares)
        instruction = 25'b0000000000000000000000000; // 0
        immediateSource = 3'b000;
        #10;
        $display("Type I | instruction: %b, immediateExtended: %h", instruction, immediateExtended);

        instruction = 25'b0000000000000001111111111; // 511
        #10;
        $display("Type I | instruction: %b, immediateExtended: %h", instruction, immediateExtended);

        instruction = 25'b1111111111111111111111111; // -1 (en 2's complement)
        immediateSource = 3'b000;
        #10;
        $display("Type I | instruction: %b, immediateExtended: %h", instruction, immediateExtended);

        // Caso de prueba: Tipo S
        instruction = 25'b0000001111111000000000001; // 0x3FC001 (sin signo)
        immediateSource = 3'b001;
        #10;
        $display("Type S | instruction: %b, immediateExtended: %h", instruction, immediateExtended);

        // Caso de prueba: Tipo U (lui y similares)
        instruction = 25'b1111111111111111111111111; // 0x1FFFFF (sin signo)
        immediateSource = 3'b010;
        #10;
        $display("Type U | instruction: %b, immediateExtended: %h", instruction, immediateExtended);

        // Caso de prueba: Tipo B
        instruction = 25'b0000011111100000000000001; // 0x100001 que en binario es 100001 (sin signo) en decimal es 257
        immediateSource = 3'b101;
        #10;
        $display("Type B | instruction: %b, immediateExtended: %h", instruction, immediateExtended);

        // Caso de prueba: Tipo J
        instruction = 25'b1111100000111111111111111; // en decimal es -2048 y usamos el signo de 2's complement
        immediateSource = 3'b110;
        #10;
        $display("Type J | instruction: %b, immediateExtended: %h", instruction, immediateExtended);

        // Fin de la simulación
        $finish;
    end

    // Guardado de señales en un archivo VCD para visualización
    initial begin
        $dumpfile("ImmGen_tb.vcd");
        $dumpvars(0, ImmGen_tb);
    end

endmodule
