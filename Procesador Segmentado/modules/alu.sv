module alu (
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [3:0] alu_op,
    output logic [31:0] alu_out
);
    always @(*) begin
        case (alu_op)
            4'b0000: alu_out <= a + b;
            4'b1000: alu_out <= a - b;
            4'b0001: alu_out <= a << b;
            4'b0010: alu_out <= $signed(a) < $signed(b);
            4'b0011: alu_out <= a < b;
            4'b0100: alu_out <= a ^ b;
            4'b0101: alu_out <= a >> b;
            4'b1101: alu_out <= a >>> b;
            4'b0110: alu_out <= a | b;
            4'b0111: alu_out <= a & b;
        endcase
    end
endmodule