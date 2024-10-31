`timescale 1ns/1ps

module RegisterUnit_tb;

    // Señales de entrada y salida
    reg [4:0] readRegister1;                // Registro fuente 1 para lectura
    reg [4:0] readRegister2;                // Registro fuente 2 para lectura
    reg [4:0] writeRegister;                // Registro de destino para escritura
    reg writeEnable;                        // Señal que habilita la escritura
    reg [31:0] dataIn;                      // Datos a escribir en el registro
    reg clk;                                 // Señal de reloj
    wire [31:0] dataOut1;                  // Datos leídos del registro fuente 1
    wire [31:0] dataOut2;                  // Datos leídos del registro fuente 2

    // Instancia del módulo RegisterUnit
    RegisterUnit uut (
        .readRegister1(readRegister1),
        .readRegister2(readRegister2),
        .dataOut1(dataOut1),
        .dataOut2(dataOut2),
        .writeRegister(writeRegister),
        .writeEnable(writeEnable),
        .dataIn(dataIn),
        .clk(clk)
    );

    // Generador de reloj
    initial begin
        clk = 0;                             // Inicializa el reloj en 0
        forever #5 clk = ~clk;               // Genera un reloj alternando cada 5 ns (periodo de 10 ns)
    end

    // Proceso de simulación
    initial begin
        // Inicializa las señales
        writeEnable = 0;                    // Deshabilita la escritura al inicio
        writeRegister = 5'd0;                // Registro de escritura inicializado en 0
        dataIn = 32'd0;                      // Datos de entrada inicializados en 0
        readRegister1 = 5'd0;                // Registro fuente 1 inicializado en 0
        readRegister2 = 5'd0;                // Registro fuente 2 inicializado en 0

        // Espera a que los registros se inicialicen
        #10;

        // Verificar la inicialización de los registros
        readRegister1 = 5'd2;                // Configura para leer el registro 2
        #5;                                   // Espera un ciclo de reloj
        $display("Lectura inicial | Registro 2: %d (esperado: 1024)", dataOut1); // Muestra el valor del registro 2

        // Escritura en el registro 3
        writeEnable = 1;                     // Habilita la escritura
        writeRegister = 5'd3;                // Configura el registro 3 como destino
        dataIn = 32'd123;                    // Datos a escribir
        #10;                                  // Espera para permitir la escritura
        writeEnable = 0;                     // Deshabilita la escritura

        // Lectura del registro 3 para verificar la escritura
        readRegister1 = 5'd3;                // Configura para leer el registro 3
        #5;                                   // Espera un ciclo de reloj
        $display("Lectura | Registro 3: %d (esperado: 123)", dataOut1); // Muestra el valor del registro 3

        // Escritura en el registro 4
        writeEnable = 1;                     // Habilita la escritura
        writeRegister = 5'd4;                // Configura el registro 4 como destino
        dataIn = 32'd456;                    // Datos a escribir
        #10;                                  // Espera para permitir la escritura
        writeEnable = 0;                     // Deshabilita la escritura

        // Lectura de los registros 3 y 4
        readRegister1 = 5'd3;                // Configura para leer el registro 3
        readRegister2 = 5'd4;                // Configura para leer el registro 4
        #5;                                   // Espera un ciclo de reloj
        $display("Lectura | Registro 3: %d (esperado: 123)", dataOut1); // Muestra el valor del registro 3
        $display("Lectura | Registro 4: %d (esperado: 456)", dataOut2); // Muestra el valor del registro 4

        // Intento de escritura en el registro 0 (debe ser ignorado)
        writeEnable = 1;                     // Habilita la escritura
        writeRegister = 5'd0;                // Configura el registro 0 como destino
        dataIn = 32'd999;                    // Datos a escribir
        #10;                                  // Espera para permitir la escritura
        writeEnable = 0;                     // Deshabilita la escritura

        // Verificar que el registro 0 sigue en 0
        readRegister1 = 5'd0;                // Configura para leer el registro 0
        #5;                                   // Espera un ciclo de reloj
        $display("Lectura | Registro 0: %d (esperado: 0)", dataOut1); // Muestra el valor del registro 0

        // Fin de la simulación
        $finish;
    end

    // Guardado de señales en un archivo VCD para visualización
    initial begin
        $dumpfile("RegisterUnit_tb.vcd");     // Define el archivo de salida para las señales
        $dumpvars(0, RegisterUnit_tb);        // Guarda todas las variables del testbench
    end

endmodule
