module testbench;
    reg [31:0] a, b;
    reg sel;
    wire [31:0] y;

    // Instancia del MUX
    MUX uut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    initial begin
        // Estímulos
        a = 32'hA5A5A5A5; b = 32'h5A5A5A5A; sel = 0;
        #10 sel = 1;
        #10 sel = 0;
        #10 a = 32'hFFFFFFFF; sel = 1;
        #10 $stop;
    end

    // Generar archivo VCD para visualización de señales
    initial begin
        $dumpfile("mux_tb.vcd");
        $dumpvars(0, testbench);
    end
endmodule
