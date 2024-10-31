`timescale 1ns/1ps

module PC_tb;

    parameter NEWADDRESSLENGTH = 32;
    parameter MAXBITSPERREGISTER = 32;

    // Señales de entrada y salida
    reg [NEWADDRESSLENGTH-1:0] address;
    reg clk;
    wire [NEWADDRESSLENGTH-1:0] newAddress;

    // Instancia del módulo PC
    PC uut (
        .address(address),
        .clk(clk),
        .newAddress(newAddress)
    );

    // Generación de señal de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Reloj con periodo de 10 ns
    end

    // Proceso de simulación
    initial begin
        // Inicialización de las entradas
        address = 32'h00000000;

        // Aplicación de estímulos
        #10 address = 32'h00000004;
        #10 address = 32'h00000008;
        #10 address = 32'h0000000C;
        #10 address = 32'h00000010;
        
        // Fin de la simulación
        #10 $finish;
    end

    // Guardar el archivo de señal VCD para visualizar en WaveTrace
    initial begin
        $dumpfile("PC_tb.vcd");
        $dumpvars(0, PC_tb);
    end

endmodule
