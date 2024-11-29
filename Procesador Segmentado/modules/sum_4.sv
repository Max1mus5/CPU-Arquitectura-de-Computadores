module sum_4 (
    input logic [31:0] current_pc,
    output logic [31:0] next_pc = 0
);
    always_comb begin
        next_pc = current_pc + 4;
    end
endmodule