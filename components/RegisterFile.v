module RegisterFile(
  input wire clk,              // Reloj
  input wire reset,            // Señal de reinicio
  input wire regWrite,         // Señal para habilitar la escritura
  input wire [4:0] RD1,        // Primer registro a leer (Register Destination 1)
  input wire [4:0] RD2,        // Segundo registro a leer (Register Destination 2)
  input wire [4:0] writeReg,   // Registro en el que se escribirá
  input wire [31:0] writeData, // Datos a escribir en el registro
  output wire [31:0] readData1, // Datos leídos del primer registro
  output wire [31:0] readData2  // Datos leídos del segundo registro
);

  // 32 registros de 32 bits
  reg [31:0] registers [31:0];

  // Leer datos de los registros (Lectura sincrónica)
  assign readData1 = registers[RD1];
  assign readData2 = registers[RD2];

  // Escribir datos en un registro (Escritura sincrónica)