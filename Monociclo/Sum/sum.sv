module AddressIncrementer(currentAddress, incrementedAddress);

    parameter ADDR_WIDTH = 32;

    input wire [ADDR_WIDTH-1:0] currentAddress;

    output reg [ADDR_WIDTH-1:0] incrementedAddress;

    always @* begin
        incrementedAddress <= currentAddress + 4;
    end

endmodule
