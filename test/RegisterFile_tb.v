module testbench;
    reg clk;
    reg reset;
    reg regWrite;
    reg [4:0] readReg1;
    reg [4:0] readReg2;
    reg [4:0] writeReg;
    reg [31:0] writeData;
    wire [31:0] readData1;
    wire [31:0] readData2;

    // Instancia de la Unidad de Registros
    RegisterFile uut (
        .clk(clk),
        .reset(reset),
        .regWrite(regWrite),
        .readReg1(readReg1),
        .readReg2(readReg2),
        .writeReg(writeReg),
        .writeData(writeData),
        .readData1(readData1),
        .readData2(readData2)
    );

    // Generar señal de reloj
    always #5 clk = ~clk;

    initial begin
        // Inicialización de señales
        clk = 0;
        reset = 0;
        regWrite = 0;
        readReg1 = 0;
        readReg2 = 0;
        writeReg = 0;
        writeData = 0;

        // Reinicio de la Unidad de Registros
        reset = 1;
        #10 reset = 0;

        // Escribir 32'hDEADBEEF en el registro 1
        writeReg = 5'b00001;
        writeData = 32'hDEADBEEF;
        regWrite = 1;
        #10 regWrite = 0;

        // Leer desde los registros 1 y 2
        readReg1 = 5'b00001;
        readReg2 = 5'b00010;
        #10;

        // Escribir 32'hCAFEBABE en el registro 2
        writeReg = 5'b00010;
        writeData = 32'hCAFEBABE;
        regWrite = 1;
        #10 regWrite = 0;

        // Leer nuevamente desde los registros 1 y 2
        readReg1 = 5'b00001;
        readReg2 = 5'b00010;
        #10;

        $stop;
    end

    // Generar archivo VCD para visualización de señales
    initial begin
        $dumpfile("registerfile_tb.vcd");
        $dumpvars(0, testbench);
    end
endmodule
