module hazard_detection (
    input logic check,
    input logic [4:0] rs1,
    input logic [4:0] rs2,
    input logic [4:0] rd,
    output logic stall = 0
);
    always_comb begin
        // stall = check && ((rs1 == rd) || (rs2 == rd));
        if (check) begin
            if (rs1 == rd) begin
                stall = 1;
            end else if (rs2 == rd) begin
                stall = 1;
            end
            else begin
                stall = 0;
            end
        end
    end
endmodule