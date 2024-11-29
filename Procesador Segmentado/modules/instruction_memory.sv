module instruction_memory (
    input logic [31:0] address,
    output logic [31:0] instruction
);
    //string filename;
    logic [31:0] memory [0:1023]; // 4 KB memory

    initial begin
        //if (!$value$plusargs("file=%s", filename)) begin
        //    filename = "../programs/mul.hex"; // Default filename
        //end

        // clear memory
        for (int i = 0; i < 1024; i = i + 1) begin
            memory[i] = 0;
        end

        //$readmemh(filename, memory);
		  $readmemh("../programs/mul.hex", memory);
    end

    always_comb begin
        instruction = memory[address >> 2];
    end
endmodule