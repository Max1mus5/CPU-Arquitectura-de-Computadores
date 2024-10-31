module RegisterUnit(
    input logic [4:0] readRegister1,              // Registro fuente 1
    input logic [4:0] readRegister2,              // Registro fuente 2
    output logic [31:0] dataOut1,                 // Datos leídos del registro fuente 1
    output logic [31:0] dataOut2,                 // Datos leídos del registro fuente 2
    input logic [4:0] writeRegister,              // Registro de destino para escritura
    input logic writeEnable,                      // Habilitador de escritura, señal desde ControlUnit
    input logic [31:0] dataIn,                    // Datos a escribir
    input logic clk                               // Señal de reloj
);

    parameter MAX_REGISTERS = 32;                  // Número máximo de registros
    parameter BITS_PER_REGISTER = 32;               // Bits por registro

    logic [BITS_PER_REGISTER-1:0] registers [0:MAX_REGISTERS-1]; // Array de registros

    // Inicialización de registros
    initial begin
        for (int i = 0; i < MAX_REGISTERS; i = i + 1) begin
            registers[i] = 32'h0;                   // Inicializa todos los registros a 0
        end
        registers[2] = 32'd1024;                     // Inicializa el registro 2 con el valor 1024
    end

    // Proceso de escritura en el registro
    always @(posedge clk) begin
        // Verifica si se debe escribir y que el registro de destino no sea el registro 0
        if (writeEnable && writeRegister !== 5'b00000) begin
            registers[writeRegister] = dataIn;      // Escribe en el registro de destino
        end
    end

    // Asignaciones para lectura de registros
    assign dataOut1 = registers[readRegister1];    // Asigna el dato del registro fuente 1
    assign dataOut2 = registers[readRegister2];    // Asigna el dato del registro fuente 2

endmodule
