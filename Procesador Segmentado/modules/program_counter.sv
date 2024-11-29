module program_counter(
    input logic clk,
    input logic [31:0] next_pc,
    output logic [31:0] current_pc = 0
);
    always_ff @(posedge clk) begin
        current_pc <= next_pc;
    end
endmodule