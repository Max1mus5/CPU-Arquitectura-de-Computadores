`timescale 1ns/1ps

module InstructionMemory_tb;

    // Parámetros y señales
    parameter INST_MAX_LENGTH = 32;
    parameter REG_MAX_LENGTH = 32;
    
    reg [REG_MAX_LENGTH-1:0] Address;/* Define un registro llamado Address de 32 bits que se usará para almacenar la dirección de la instrucción que se va a leer. */
    wire [INST_MAX_LENGTH-1:0] OutputInstruction; /* Define una señal de tipo wire que representará la instrucción leída desde la memoria, también de 32 bits.*/

    // Instancia del módulo InstructionMemory
    InstructionMemory uut (
        .Address(Address),
        .OutputInstruction(OutputInstruction)
    );

    // Proceso de simulación
    initial begin
        // Inicialización de las entradas
        Address = 0;

        // Prueba: leer instrucción en la dirección 0
        #10 Address = 0;
        #10 $display("Address: %h, OutputInstruction: %h", Address, OutputInstruction);

        // Prueba: leer instrucción en la dirección 4
        #10 Address = 4;
        #10 $display("Address: %h, OutputInstruction: %h", Address, OutputInstruction);

        // Prueba: leer instrucción en la dirección 8
        #10 Address = 8;
        #10 $display("Address: %h, OutputInstruction: %h", Address, OutputInstruction);

        // Prueba: leer instrucción en la dirección 12
        #10 Address = 12;
        #10 $display("Address: %h, OutputInstruction: %h", Address, OutputInstruction);

        // Prueba: leer instrucción en la dirección 16
        #10 Address = 16;
        #10 $display("Address: %h, OutputInstruction: %h", Address, OutputInstruction);

        // Fin de la simulación
        #10 $finish;
    end

    // Guardado de señales en un archivo VCD para visualización
    initial begin
        $dumpfile("InstructionMemory_tb.vcd");
        $dumpvars(0, InstructionMemory_tb);
    end

endmodule
