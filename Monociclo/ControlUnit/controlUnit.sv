module ControlUnit(
    input logic [6:0] opcode,               // Código de operación
    input logic [2:0] funct3,                // Función adicional para la operación
    input logic [6:0] funct7,                // Función adicional extendida para la operación

    output logic regWrite,                   // Señal para habilitar la escritura en registros
    output logic [3:0] aluOperation,         // Operación de la ALU
    output logic [2:0] immediateSource,      // Fuente del inmediato
    output logic aluASrc,                    // Selección del operando A de la ALU
    output logic aluBSrc,                    // Selección del operando B de la ALU
    output logic dataMemoryWrite,            // Habilita la escritura en memoria de datos
    output logic [2:0] dataMemoryControl,    // Control de operaciones en memoria de datos
    output logic [4:0] branchOperation,      // Operación de salto
    output logic [1:0] regDataWriteSource     // Fuente de datos para escribir en registro
);

    // Inicializa las señales de control
    initial begin
        regWrite = 1'b0;                      // No se permite escritura inicialmente
        aluOperation = 4'h0;                  // Inicializa la operación de la ALU a 0
        immediateSource = 3'h0;               // Inicializa la fuente del inmediato a 0
        aluASrc = 1'h0;                       // Inicializa la selección de A de la ALU a 0
        aluBSrc = 1'h0;                       // Inicializa la selección de B de la ALU a 0
        dataMemoryWrite = 1'h0;               // No se permite escritura en memoria de datos
        dataMemoryControl = 3'h0;              // Control de memoria de datos inicializado a 0
        branchOperation = 5'h0;                // Inicializa la operación de salto a 0
        regDataWriteSource = 2'h0;            // Inicializa la fuente de datos de escritura en registro a 0
    end

    // Lógica combinacional para el control de la unidad
    always @(*) begin
        // Determina si se debe habilitar la escritura en registros
        regWrite = (~opcode[6] & ~opcode[5] & ~opcode[3] & ~opcode[2] & opcode[1] & opcode[0]) | 
                   (~opcode[6] & opcode[4] & ~opcode[3] & ~opcode[2] & opcode[1] & opcode[0]) | 
                   (opcode[6] & opcode[5] & ~opcode[4] & opcode[2] & opcode[1] & opcode[0]);

        // Configura la operación de la ALU basada en el opcode y los campos de función
        aluOperation = {
            opcode[4] & (funct7[5] & ~opcode[2] & (opcode[5] | (funct3[2] & ~funct3[1] & funct3[0]))),
            opcode[4] & (funct3[2] | opcode[2]),
            opcode[4] & (funct3[1] | opcode[2]),
            opcode[4] & (funct3[0] | opcode[2])
        };

        // Configura la fuente del inmediato
        immediateSource = {
            (opcode[6] & opcode[5] & ~opcode[4] & ~opcode[3] & ~opcode[2] & opcode[1] & opcode[0]) | 
            (opcode[6] & opcode[5] & ~opcode[4] & opcode[3] & opcode[2] & opcode[1] & opcode[0]),
            (~opcode[6] & opcode[4] & ~opcode[3] & opcode[2] & opcode[1] & opcode[0]) | 
            (opcode[6] & opcode[5] & ~opcode[4] & opcode[3] & opcode[2] & opcode[1] & opcode[0]),
            (opcode[5] & ~opcode[4] & ~opcode[3] & ~opcode[2] & opcode[1] & opcode[0])
        };

        // Selección de operando A para la ALU
        aluASrc = (~opcode[6] & opcode[4] & ~opcode[3] & opcode[2] & opcode[1] & opcode[0]) | 
                  (opcode[6] & opcode[5] & ~opcode[4] & ~opcode[3] & ~opcode[2] & opcode[1] & opcode[0]) | 
                  (opcode[6] & opcode[5] & ~opcode[4] & opcode[3] & opcode[2] & opcode[1] & opcode[0]);

        // Selección de operando B para la ALU
        aluBSrc = (~opcode[6] & opcode[4] & ~opcode[3] & opcode[2] & opcode[1] & opcode[0]) | 
                  (opcode[6] & opcode[5] & ~opcode[4] & opcode[2] & opcode[1] & opcode[0]) | 
                  (~opcode[6] & ~opcode[5] & ~opcode[3] & ~opcode[2] & opcode[1] & opcode[0]) | 
                  (opcode[5] & ~opcode[4] & ~opcode[3] & ~opcode[2] & opcode[1] & opcode[0]);

        // Determina si se debe habilitar la escritura en memoria de datos
        dataMemoryWrite = (~opcode[6] & opcode[5] & ~opcode[4] & ~opcode[3] & ~opcode[2] & opcode[1] & opcode[0]);

        // Control de operaciones en memoria de datos
        dataMemoryControl = funct3;

        // Configura la operación de salto
        branchOperation = {
            opcode[6] & opcode[2], 
            opcode[6], 
            funct3
        };

        // Configura la fuente de datos para escribir en registro
        regDataWriteSource = {
            (opcode[5] & ~opcode[4] & ~opcode[3] & ~opcode[2] & opcode[1] & opcode[0]) | 
            (opcode[6] & opcode[5] & ~opcode[4] & opcode[2] & opcode[1] & opcode[0]),
            (~opcode[6] & ~opcode[5] & ~opcode[4] & ~opcode[3] & ~opcode[2] & opcode[1] & opcode[0])
        };
    end

endmodule
