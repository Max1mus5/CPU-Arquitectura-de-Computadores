module mux_3(
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [31:0] c,
    input logic [1:0] sel,
    output logic [31:0] mux_out
);
    always_comb begin
        case (sel)
            2'b00: mux_out = a;
            2'b01: mux_out = b;
            2'b10: mux_out = c;
        endcase
    end
endmodule