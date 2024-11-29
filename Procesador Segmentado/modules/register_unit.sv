module register_unit #(
    parameter USE_NEGEDGE = 0  // 0 for posedge, 1 for negedge
) (
    input logic clk,
    input logic [4:0] rs1,
    input logic [4:0] rs2,
    input logic [4:0] rd,
    input logic [31:0] write_data,
    input logic write_en,
    output logic [31:0] rs1_data,
    output logic [31:0] rs2_data
);
    logic [31:0] registers [31:0];

    initial begin
        for (integer i = 0; i < 32; i = i + 1) begin
            registers[i] = 0;
        end
    end

    generate
        if (USE_NEGEDGE) begin
            always_ff @(negedge clk) begin
                if (write_en == 1 && (rd != 0)) begin
                    registers[rd] <= write_data;
                end
            end
        end else begin
            always_ff @(posedge clk) begin
                if (write_en == 1 && (rd != 0)) begin
                    registers[rd] <= write_data;
                end
            end
        end
    endgenerate

    always_comb begin
        rs1_data = registers[rs1];
        rs2_data = registers[rs2];
    end
endmodule
