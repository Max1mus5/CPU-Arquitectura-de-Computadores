module testbench;
    reg a, b;
    wire y;

    // Asegúrate de que el nombre del módulo aquí sea "and_gate"
    // o el nombre del módulo que tienes en MUX.v
    and_gate uut (
        .a(a),
        .b(b),
        .y(y)
    );

    initial begin
        // Estímulos
        a = 0; b = 0;
        #10 a = 1; b = 0;
        #10 a = 0; b = 1;
        #10 a = 1; b = 1;
        #10 $stop;
    end

    // Estas líneas deben estar dentro de "initial begin"
    // Se mueven dentro del bloque inicial ya existente
    initial begin
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, testbench);
    end
endmodule
