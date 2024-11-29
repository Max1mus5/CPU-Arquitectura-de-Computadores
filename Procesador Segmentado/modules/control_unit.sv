module control_unit(
    input logic [6:0] opcode,
    input logic [2:0] funct3,
    input logic [6:0] funct7,
    output logic register_write_en,
    output logic [2:0] imm_src,
    output logic alu_a,
    output logic alu_b,
    output logic [3:0] alu_op,
    output logic [4:0] branch_op,
    output logic data_write_en,
    output logic [2:0] dm_control,
    output logic [1:0] rd_data_sel
);
    always @(*) begin
        // instruction type R
        if (opcode == 7'b0110011) begin
            register_write_en <= 1;
            imm_src <= 3'bxxx;

            alu_a <= 0;
            alu_b <= 0;
            branch_op <= 5'b00xxx;

            data_write_en <= 0;
            dm_control <= 3'bxxx;
            rd_data_sel <= 0;

            if (funct7 == 7'h00) begin
                case (funct3)
                    3'h0: alu_op <= 4'b0000; // add
                    3'h4: alu_op <= 4'b0100; // xor
                    3'h6: alu_op <= 4'b0110; // or
                    3'h7: alu_op <= 4'b0111; // and
                    3'h1: alu_op <= 4'b0001; // sll
                    3'h5: alu_op <= 4'b0101; // srl
                    3'h2: alu_op <= 4'b0010; // slt
                    3'h3: alu_op <= 4'b0011; // sltu
                endcase
            end

            if (funct7 == 7'h20) begin
                case (funct3)
                    3'h0: alu_op <= 4'b1000; // sub
                    3'h4: alu_op <= 4'b1101; // sra
                endcase
            end
        end

        // instruction type I
        if (opcode == 7'b0010011) begin
            register_write_en <= 1;
            imm_src <= 3'b000;

            alu_a <= 0;
            alu_b <= 1;
            branch_op = 5'b00xxx;

            data_write_en = 0;
            dm_control = 3'bxxx;
            rd_data_sel = 0;

            case (funct3)
                3'h0: alu_op <= 4'b0000; // addi
                3'h4: alu_op <= 4'b0100; // xori
                3'h6: alu_op <= 4'b0110; // ori
                3'h7: alu_op <= 4'b0111; // andi
                3'h1: alu_op <= 4'b0001; // slli
                3'h5: alu_op <= 4'b0101; // srli
                3'h5: alu_op <= 4'b1101; // srai // not supported
                3'h2: alu_op <= 4'b0010; // slti
                3'h3: alu_op <= 4'b0011; // sltiu
            endcase
        end

        // instruction type Load
        if (opcode == 7'b0000011) begin
            register_write_en <= 1;
            imm_src <= 3'b000;

            alu_a <= 0;
            alu_b <= 1;
            alu_op <= 4'b0000;
            branch_op <= 5'b00xxx;

            data_write_en <= 0;
            rd_data_sel <= 2'b01;

            case (funct3)
                3'h0: dm_control <= 3'b000; // load byte
                3'h1: dm_control <= 3'b001; // load halfword
                3'h2: dm_control <= 3'b010; // load word
                3'h4: dm_control <= 3'b100; // load byte unsigned
                3'h5: dm_control <= 3'b101; // load halfword unsigned
            endcase
        end

        // instruction type S
        if (opcode == 7'b0100011) begin
            register_write_en <= 0;
            imm_src <= 3'b001;

            alu_a <= 0;
            alu_b <= 1;
            alu_op <= 4'b0000;
            branch_op <= 5'b00xxx;

            data_write_en <= 1;
            rd_data_sel <= 2'bxx;

            case (funct3)
                3'h0: dm_control <= 3'b000; // store byte
                3'h1: dm_control <= 3'b001; // store halfword
                3'h2: dm_control <= 3'b010; // store word
            endcase
        end

        // instruction type B
        if (opcode == 7'b1100011) begin
            register_write_en <= 0;
            imm_src <= 3'b101;

            alu_a <= 1;
            alu_b <= 1;
            alu_op <= 4'b0000;

            data_write_en <= 0;
            dm_control <= 3'bxxx;
            rd_data_sel <= 2'bxx;

            case (funct3)
                3'h0: branch_op <= 5'b01000; // beq
                3'h1: branch_op <= 5'b01001; // bnq
                3'h4: branch_op <= 5'b01100; // blt
                3'h5: branch_op <= 5'b01101; // bge
                3'h6: branch_op <= 5'b01110; // bltu
                3'h7: branch_op <= 5'b01111; // bgeu
            endcase
        end

        // instruction type U are not supported
        if (opcode == 7'b0110111) begin
            $display("U-type instructions not supported");
            $finish;
        end

        // instruction type J jal
        if (opcode == 7'b1101111) begin
            register_write_en <= 1;
            imm_src <= 3'b110;

            alu_a <= 1;
            alu_b <= 1;
            alu_op <= 4'b0000;
            branch_op <= 5'b1xxxx;

            data_write_en <= 0;
            dm_control <= 3'bxxx;
            rd_data_sel <= 2'b10;
        end

        // instruction type J jalr
        if (opcode == 7'b1100111) begin
            register_write_en = 1;
            imm_src = 3'b000;

            alu_a = 0;
            alu_b = 1;
            alu_op = 4'b0000;
            branch_op <= 5'b1xxxx;

            data_write_en = 0;
            dm_control = 3'bxxx;
            rd_data_sel = 2'b00;

            case (funct3)
                3'h0: branch_op <= 5'b1xxxx;
            endcase
        end
    end
endmodule