module forwarding_unit (
    input logic [4:0] rs1_ex,
    input logic [4:0] rs2_ex,
    input logic write_en_me,
    input logic write_en_wb,
    input logic [4:0] rd_me,
    input logic [4:0] rd_wb,
    output logic [1:0] alu_a_sel,
    output logic [1:0] alu_b_sel
);
    always_comb begin
        if (write_en_me && rd_me == rs1_ex) begin
            alu_a_sel = 2'b01;
        end else if (write_en_wb && rd_wb == rs1_ex) begin
            alu_a_sel = 2'b10;
        end else begin
            alu_a_sel = 2'b00;
        end
    end

    always_comb begin
        if (write_en_me && rd_me == rs2_ex) begin
            alu_b_sel = 2'b01;
        end else if (write_en_wb && rd_wb == rs2_ex) begin
            alu_b_sel = 2'b10;
        end else begin
            alu_b_sel = 2'b00;
        end
    end
endmodule