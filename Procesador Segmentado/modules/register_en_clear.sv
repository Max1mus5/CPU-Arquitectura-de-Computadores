module register_en_clear # (
    parameter WIDTH = 32
) (
    input logic clk,
    input logic enable,
    input logic clear,
    input logic [WIDTH-1:0] data_save,
    output logic [WIDTH-1:0] data_out = 0
);
    // logic [WIDTH-1:0] data = 0;

    always @(posedge clk) begin
        if (clear) begin
            // data <= 0;
            data_out <= 0;
        end
        else if (enable) begin
            // data <= data_save;
            data_out <= data_save;
        end
    end
endmodule
