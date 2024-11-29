module branch_unit(
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [4:0] branch_op,
    output logic branch_out
);
    always @(*) begin
        // Check for the first two bits
        if (branch_op[4:3] == 2'b00) begin
            branch_out = 0;
        end
        // Check for the 1xxxx pattern
        else if (branch_op[4] == 1) begin
            branch_out = 1;
        end
        else begin
            case (branch_op)
                5'b01000: branch_out = a == b;
                5'b01001: branch_out = a != b;
                5'b01100: branch_out = $signed(a) < $signed(b); // by default input logic is unsigned
                5'b01101: branch_out = $signed(a) >= $signed(b);
                5'b01110: branch_out = a < b;
                5'b01111: branch_out = a >= b;
                default: branch_out = 0; // default case for any undefined branch_op
            endcase
        end
    end
endmodule
