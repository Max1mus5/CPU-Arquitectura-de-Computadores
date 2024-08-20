module testbench;
    reg [31:0] a, b;
    reg [2:0] op;
    wire [31:0] result;
    wire zero;

    // Instancia de la ALU
    ALU uut (
        .a(a),
        .b(b),
        .op(op),
        .result(result),
        .zero(zero)
    );

    initial begin
        // Estímulos
        a = 32'hA5A5A5A5; b = 32'h5A5A5A5A; op = 3'b000; // Suma
        #10 op = 3'b001; // Resta
        #10 op = 3'b010; // AND
        #10 op = 3'b011; // OR
        #10 op = 3'b100; // XOR
        #10 op = 3'b101; // NOR
        #10 $stop;
    end

    // Generar archivo VCD para visualización de señales
    initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, testbench);
    end
endmodule
