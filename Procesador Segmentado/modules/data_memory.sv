module data_memory(
    input logic write_en,
    input logic [2:0] dm_control,
    input logic [31:0] address,
    input logic [31:0] write_data,
    output logic [31:0] read_data
);
    logic [7:0] memory[4095:0]; // 4 KB memory

    initial begin
        for (int i = 0; i < 1024; i++) begin
            memory[i] = 8'h00;
        end
    end

    always @(*) begin
        if (write_en) begin
            case (dm_control)
                3'b000: begin
                    memory[address] = write_data[7:0]; // store byte
                end
                3'b001: begin // store halfword
                    memory[address] = write_data[7:0]; // lower byte
                    memory[address + 1] = write_data[15:8]; // upper byte
                end
                3'b010: begin // store word
                    memory[address] = write_data[7:0];
                    memory[address + 1] = write_data[15:8];
                    memory[address + 2] = write_data[23:16];
                    memory[address + 3] = write_data[31:24];
                end
            endcase
        end
        else if (write_en == 0) begin
            case (dm_control)
                3'b000: begin // load byte
                    read_data = {{24{memory[address][7]}}, memory[address][7:0]};
                end
                3'b001: begin // load halfword
                    read_data = {{16{memory[address + 1][7]}}, memory[address + 1], memory[address]};
                end
                3'b010: begin // load word
                    read_data = {memory[address + 3], memory[address + 2], memory[address + 1], memory[address]};
                end
                3'b100: begin // load byte unsigned
                    read_data = {{24{1'b0}}, memory[address]};
                end
                3'b101: begin // load halfword unsigned
                    read_data = {{16{1'b0}}, memory[address + 1], memory[address]};
                end
            endcase
        end
    end
endmodule