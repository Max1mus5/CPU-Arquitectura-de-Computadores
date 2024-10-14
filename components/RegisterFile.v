module RegisterFile(
    input wire clk,              // Reloj
    input wire reset,            // Señal de reinicio
    input wire regWrite,         // Señal para habilitar la escritura
    input wire [4:0] readReg1,   // Dirección del primer registro a leer
    input wire [4:0] readReg2,   // Dirección del segundo registro a leer
    input wire [4:0] writeReg,   // Dirección del registro a escribir
    input wire [31:0] writeData, // Datos a escribir en el registro
    output wire [31:0] readData1, // Datos leídos del primer registro
    output wire [31:0] readData2  // Datos leídos del segundo registro
);

    // Definición de 32 registros de 32 bits
    reg [31:0] registers [31:0];

    // Leer datos de los registros (Lectura asincrónica)
    assign readData1 = (readReg1 == 5'b0) ? 32'b0 : registers[readReg1];
    assign readData2 = (readReg2 == 5'b0) ? 32'b0 : registers[readReg2];

    integer i;

    // Escribir datos en un registro (Escritura sincrónica)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reiniciar todos los registros a 0
            for (i = 1; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end else if (regWrite && writeReg != 5'b0) begin
            // Escribir en el registro seleccionado, excepto en x0
            registers[writeReg] <= writeData;
        end
    end

endmodule