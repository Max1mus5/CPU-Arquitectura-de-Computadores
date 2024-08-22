module testbench;
  //testbench for the registerFile
  reg [4:0] readReg1, readReg2, writeReg;
  reg [31:0] writeData;

  wire [31:0] readData1, readData2;

  wire clk, reset, regWrite;

  RegisterFile uut (
    .clk(clk),
    .reset(reset),
    .regWrite(regWrite),
    .RD1(readReg1),
    .RD2(readReg2),
    .writeReg(writeReg),
    .writeData(writeData),
    .readData1(readData1),
    .readData2(readData2)
  );

  initial begin
    //estimulos y diseños
    clk = 0;
    reset = 1; 
    regWrite = 0;
    readReg1 = 0;
    readReg2 = 0;
    writeReg = 0;
    writeData = 0;


    //reinicar unidades
    reset =1;
    #10 reset = 0;

    // Escribir 32'hDEADBEEF en el registro 1
    writeReg = 5'b00001;
    writeData = 32'hDEADBEEF;
    regWrite = 1;
    #10 regWrite = 0;

    $stop;

  end

  // Generar archivo VCD para visualización de señales
  initial begin
      $dumpfile("registerfile_tb.vcd");
      $dumpvars(0, testbench);
  end
endmodule
    