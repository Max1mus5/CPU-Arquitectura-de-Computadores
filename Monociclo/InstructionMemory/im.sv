module InstructionMemory(Address, OutputInstruction);
    parameter INST_MAX_LENGTH = 32;
    parameter REG_MAX_LENGTH = 32;
    parameter REG_MAX_NUMBER = 1024;

    input logic [REG_MAX_LENGTH-1:0] Address;

    output logic [INST_MAX_LENGTH-1:0] OutputInstruction;

    logic [7:0] Memory [0:REG_MAX_NUMBER]; /*Se define un arreglo llamado Memory que contiene REG_MAX_NUMBER + 1 elementos, cada uno de 8 bits (0 a 255). */

    initial begin
        $readmemh("./instructions.txt", Memory); /* Se lee el archivo "instructions.txt" y lo carga en el arreglo Memory */
        OutputInstruction = 32'b0; /*  Inicializa la salida de la memoria de instrucciones */
    end

    always @(Address) begin /* Se comprueba si la dirección de la memoria de instrucciones coincide con la dirección del registro */
        OutputInstruction = {Memory[Address], Memory[Address+1], Memory[Address+2], Memory[Address+3]}; /* Se muestra el valor de la dirección de la memoria de instrucciones en la salida de la memoria de instrucciones */
    end
endmodule;
