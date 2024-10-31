`timescale 1ns/1ps

module ControlUnit_tb;

    // Señales de entrada
    reg [6:0] opcode;
    reg [2:0] funct3;
    reg [6:0] funct7;

    // Señales de salida
    wire regWrite;
    wire [3:0] aluOperation;
    wire [2:0] immediateSource;
    wire aluASrc;
    wire aluBSrc;
    wire dataMemoryWrite;
    wire [2:0] dataMemoryControl;
    wire [4:0] branchOperation;
    wire [1:0] regDataWriteSource;

    // Instancia de la unidad de control
    ControlUnit uut (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .regWrite(regWrite),
        .aluOperation(aluOperation),
        .immediateSource(immediateSource),
        .aluASrc(aluASrc),
        .aluBSrc(aluBSrc),
        .dataMemoryWrite(dataMemoryWrite),
        .dataMemoryControl(dataMemoryControl),
        .branchOperation(branchOperation),
        .regDataWriteSource(regDataWriteSource)
    );

    // Proceso de prueba
    initial begin
        // Inicializa los valores de entrada
        opcode = 7'b0000000;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        
        // Caso 1: Instrucción tipo R (ejemplo: ADD)
        opcode = 7'b0110011;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        #10;
        $display("Caso R-Type | Opcode: %b, Funct3: %b, Funct7: %b", opcode, funct3, funct7);
        $display("  regWrite: %b, aluOperation: %b, aluASrc: %b, aluBSrc: %b", regWrite, aluOperation, aluASrc, aluBSrc);
        
        // Caso 2: Instrucción tipo I (ejemplo: ADDI)
        opcode = 7'b0010011;
        funct3 = 3'b000;
        #10;
        $display("Caso I-Type | Opcode: %b, Funct3: %b", opcode, funct3);
        $display("  regWrite: %b, aluOperation: %b, aluASrc: %b, aluBSrc: %b, immediateSource: %b", regWrite, aluOperation, aluASrc, aluBSrc, immediateSource);
        
        // Caso 3: Instrucción de carga (ejemplo: LW)
        opcode = 7'b0000011;
        funct3 = 3'b010;
        #10;
        $display("Caso Load | Opcode: %b, Funct3: %b", opcode, funct3);
        $display("  regWrite: %b, dataMemoryControl: %b, regDataWriteSource: %b", regWrite, dataMemoryControl, regDataWriteSource);
        
        // Caso 4: Instrucción de almacenamiento (ejemplo: SW)
        opcode = 7'b0100011;
        funct3 = 3'b010;
        #10;
        $display("Caso Store | Opcode: %b, Funct3: %b", opcode, funct3);
        $display("  dataMemoryWrite: %b, dataMemoryControl: %b", dataMemoryWrite, dataMemoryControl);
        
        // Caso 5: Instrucción de salto condicional (ejemplo: BEQ)
        opcode = 7'b1100011;
        funct3 = 3'b000;
        #10;
        $display("Caso Branch | Opcode: %b, Funct3: %b", opcode, funct3);
        $display("  branchOperation: %b, aluOperation: %b", branchOperation, aluOperation);
        
        // Caso 6: Instrucción tipo JAL
        opcode = 7'b1101111;
        #10;
        $display("Caso JAL | Opcode: %b", opcode);
        $display("  regWrite: %b, immediateSource: %b, regDataWriteSource: %b", regWrite, immediateSource, regDataWriteSource);
        
        // Caso 7: Instrucción tipo LUI
        opcode = 7'b0110111;
        #10;
        $display("Caso LUI | Opcode: %b", opcode);
        $display("  regWrite: %b, immediateSource: %b", regWrite, immediateSource);

        // Fin de la simulación
        $finish;
    end

    // Guardado de señales en un archivo VCD para visualización
    initial begin
        $dumpfile("ControlUnit_tb.vcd");
        $dumpvars(0, ControlUnit_tb);
    end

endmodule
