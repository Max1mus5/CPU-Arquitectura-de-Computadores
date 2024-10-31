module PC(address, clk, newAddress);

    parameter NEWADDRESSLENGTH = 32;
    parameter MAXBITSPERREGISTER = 32;

    input logic [NEWADDRESSLENGTH-1:0] address;
    input logic clk;

    output logic [NEWADDRESSLENGTH-1:0] newAddress;

    initial begin
        newAddress = 32'b0;
    end

    always @(posedge clk) begin
        newAddress = address;
    end  
endmodule;