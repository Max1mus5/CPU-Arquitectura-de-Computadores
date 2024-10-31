`timescale 1ns/1ps

module BranchUnit_tb;

    // Señales de entrada
    reg [31:0] regValue1;            // Valor del registro 1 (rs1)
    reg [31:0] regValue2;            // Valor del registro 2 (rs2)
    reg [4:0] branchOperation;       // Operación de salto (BrOp)

    // Señal de salida
    wire nextPCSource;               // Señal de destino para el siguiente PC

    // Instancia del módulo BranchUnit
    BranchUnit uut (
        .regValue1(regValue1),
        .regValue2(regValue2),
        .branchOperation(branchOperation),
        .nextPCSource(nextPCSource)
    );

    // Proceso de simulación
    initial begin
        // Inicializa las señales
        regValue1 = 32'd0;             // Inicializa regValue1 a 0
        regValue2 = 32'd0;             // Inicializa regValue2 a 0
        branchOperation = 5'b00000;    // Inicializa branchOperation a 0

        // Espera un poco antes de comenzar las pruebas
        #10;

        // Prueba de salto incondicional
        branchOperation = 5'b10000;    // Salto incondicional
        #10;
        $display("Salto incondicional | nextPCSource: %b (esperado: 1)", nextPCSource);

        // Prueba de igualdad
        regValue1 = 32'd10;
        regValue2 = 32'd10;
        branchOperation = 5'b01000;    // Comparación de igualdad
        #10;
        $display("Igualdad | nextPCSource: %b (esperado: 1)", nextPCSource);

        // Prueba de desigualdad
        regValue1 = 32'd10;
        regValue2 = 32'd20;
        branchOperation = 5'b01001;    // Comparación de desigualdad
        #10;
        $display("Desigualdad | nextPCSource: %b (esperado: 0)", nextPCSource);

        // Prueba de menor (signed)
        regValue1 = 32'd10;
        regValue2 = 32'd20;
        branchOperation = 5'b01100;    // Comparación menor (signed)
        #10;
        $display("Menor (signed) | nextPCSource: %b (esperado: 1)", nextPCSource);

        // Prueba de mayor o igual (signed)
        regValue1 = 32'd20;
        regValue2 = 32'd10;
        branchOperation = 5'b01101;    // Comparación mayor o igual (signed)
        #10;
        $display("Mayor o igual (signed) | nextPCSource: %b (esperado: 1)", nextPCSource);

        // Prueba de menor (unsigned)
        regValue1 = 32'd10;
        regValue2 = 32'd20;
        branchOperation = 5'b01110;    // Comparación menor (unsigned)
        #10;
        $display("Menor (unsigned) | nextPCSource: %b (esperado: 1)", nextPCSource);

        // Prueba de mayor o igual (unsigned)
        regValue1 = 32'd20;
        regValue2 = 32'd10;
        branchOperation = 5'b01111;    // Comparación mayor o igual (unsigned)
        #10;
        $display("Mayor o igual (unsigned) | nextPCSource: %b (esperado: 1)", nextPCSource);

        // Fin de la simulación
        $finish;
    end

    // Guardado de señales en un archivo VCD para visualización
    initial begin
        $dumpfile("BranchUnit_tb.vcd");  // Archivo de salida para la simulación
        $dumpvars(0, BranchUnit_tb);      // Registra todas las variables en el testbench
    end

endmodule
