`timescale 1ns/1ps

module AddressIncrementer_tb;

    // Parámetro para el ancho de la dirección
    parameter ADDR_WIDTH = 32;

    // Señales de entrada y salida
    reg [ADDR_WIDTH-1:0] currentAddress;
    wire [ADDR_WIDTH-1:0] incrementedAddress;

    // Instancia del módulo AddressIncrementer
    AddressIncrementer uut (
        .currentAddress(currentAddress),
        .incrementedAddress(incrementedAddress)
    );

    // Proceso de simulación
    initial begin
        // Caso de prueba: Dirección inicial en 0
        currentAddress = 32'h00000000;
        #10;
        $display("currentAddress: %h, incrementedAddress: %h", currentAddress, incrementedAddress);

        // Caso de prueba: Dirección en 4
        currentAddress = 32'h00000004;
        #10;
        $display("currentAddress: %h, incrementedAddress: %h", currentAddress, incrementedAddress);

        // Caso de prueba: Dirección en 8
        currentAddress = 32'h00000008;
        #10;
        $display("currentAddress: %h, incrementedAddress: %h", currentAddress, incrementedAddress);

        // Caso de prueba: Dirección en un valor más alto
        currentAddress = 32'h00000010;
        #10;
        $display("currentAddress: %h, incrementedAddress: %h", currentAddress, incrementedAddress);

        // Caso de prueba: Dirección en un valor aleatorio
        currentAddress = 32'h0000FFFC;
        #10;
        $display("currentAddress: %h, incrementedAddress: %h", currentAddress, incrementedAddress);

        // Fin de la simulación
        $finish;
    end

    // Guardado de señales en un archivo VCD para visualización
    initial begin
        $dumpfile("AddressIncrementer_tb.vcd");
        $dumpvars(0, AddressIncrementer_tb);
    end

endmodule
