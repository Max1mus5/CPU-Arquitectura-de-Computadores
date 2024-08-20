module MUX(
    input wire [31:0] a,    // Entrada 1
    input wire [31:0] b,    // Entrada 2
    input wire sel,         // Señal de selección
    output wire [31:0] y    // Salida
);

    assign y = (sel) ? b : a;

endmodule
