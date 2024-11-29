`timescale 1ns/1ns

module test_riscv;
    logic clk;
    int period = 5;
    int time_run = 1000;

    riscv_segmentation utt(
        .clk(clk)
    );

    initial begin
        $dumpfile("riscv_segmentation.vcd");
        $dumpvars(0, test_riscv);

        #time_run $finish;
    end

    initial begin
        clk = 0;

        forever begin
            #period clk = ~clk;
        end
    end
endmodule