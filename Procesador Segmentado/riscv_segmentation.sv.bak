`include "modules/sum_4.sv"
`include "modules/program_counter.sv"
`include "modules/instruction_memory.sv"

`include "modules/control_unit_hazard.sv"
`include "modules/register_unit.sv"
`include "modules/imm_generate.sv"

`include "modules/mux_2.sv"
`include "modules/alu.sv"
`include "modules/branch_unit.sv"

`include "modules/data_memory.sv"
`include "modules/mux_3.sv"

`include "modules/register_en_clear.sv"

`include "modules/hazard_detection.sv"
`include "modules/forwarding_unit.sv"

module riscv_segmentation (
    input logic clk
);
    // fetch
    logic [31:0] next_pc, pc_4_fe, pc_fe, instruction_fe;

    // decode
    logic register_write_en_de;
    logic [2:0] imm_src_de;
    logic alu_a_de;
    logic alu_b_de;
    logic [3:0] alu_op_de;
    logic [4:0] branch_op_de;
    logic data_write_en_de;
    logic [2:0] dm_control_de;
    logic [1:0] rd_data_sel_de;
    logic hazard_de;
    logic stall_de;

    logic [31:0] rs1_data_de, rs2_data_de;
    logic [31:0] imm_de;

    logic [4:0] rs1_de, rs2_de, rd_de;

    // execute
    logic [31:0] a_ex, b_ex, alu_out_ex;
    logic branch_out_ex;

    logic [1:0] sel_forward_a_ex, sel_forward_b_ex;

    // memory
    logic [31:0] read_data_me;

    // write back
    logic [31:0] rd_data_wb;

    // logic stop = 0;
    // logic [1:0] end_stop = 0;

    // always @(posedge clk) begin
    //     // if (instruction_fe == 0) #10 $finish;
    //     if (stop) end_stop = end_stop + 1;
    //     if (end_stop == 3) #10 $finish;

    //     if (instruction_fe == 0 && ~stop) stop = 1;
    // end

    register_en_clear _pc_fe (
        .clk(clk),
        .enable(~stall_de),
        .clear(1'b0),
        .data_save(next_pc),
        .data_out(pc_fe)
    );

    sum_4 _sum4 (
        .current_pc(pc_fe),
        .next_pc(pc_4_fe)
    );

    instruction_memory _i_mem (
        .address(pc_fe),
        .instruction(instruction_fe)
    );

    // fetch registers
    logic [31:0] pc_4_de, instruction_de, pc_de;

    register_en_clear _pc_4_de (
        .clk(clk),
        .enable(~stall_de),
        .clear(branch_out_ex),
        .data_save(pc_4_fe),
        .data_out(pc_4_de)
    );

    register_en_clear reg_pc_de (
        .clk(clk),
        .enable(~stall_de),
        .clear(branch_out_ex),
        .data_save(pc_fe),
        .data_out(pc_de)
    );

    register_en_clear _instruction_de (
        .clk(clk),
        .enable(~stall_de),
        .clear(branch_out_ex),
        .data_save(instruction_fe),
        .data_out(instruction_de)
    );

    // decode
    control_unit_hazard _control_unit (
        .opcode(instruction_de[6:0]),
        .funct3(instruction_de[14:12]),
        .funct7(instruction_de[31:25]),
        .register_write_en(register_write_en_de),
        .imm_src(imm_src_de),
        .alu_a(alu_a_de),
        .alu_b(alu_b_de),
        .alu_op(alu_op_de),
        .branch_op(branch_op_de),
        .data_write_en(data_write_en_de),
        .dm_control(dm_control_de),
        .rd_data_sel(rd_data_sel_de),
        .hazard(hazard_de)
    );

    assign rs1_de = instruction_de[19:15];
    assign rs2_de = instruction_de[24:20];
    assign rd_de = instruction_de[11:7];

    register_unit #(
        .USE_NEGEDGE(1) // use negedge for write
    ) _reg_unit (
        .clk(clk),
        .rs1(rs1_de),
        .rs2(rs2_de),
        .rd(rd_wb),
        .write_data(rd_data_wb),
        .write_en(register_write_en_wb),
        .rs1_data(rs1_data_de),
        .rs2_data(rs2_data_de)
    );

    imm_generate _imm_gen (
        .imm(instruction_de[31:7]),
        .imm_type(imm_src_de),
        .imm_out(imm_de)
    );

    hazard_detection _hazard (
        .check(hazard_ex),
        .rs1(rs1_de),
        .rs2(rs2_de),
        .rd(rd_ex),
        .stall(stall_de)
    );

    // decode registers
    // control unit
    logic register_write_en_ex;
    logic alu_a_ex;
    logic alu_b_ex;
    logic [3:0] alu_op_ex;
    logic [4:0] branch_op_ex;
    logic data_write_en_ex;
    logic [2:0] dm_control_ex;
    logic [1:0] rd_data_sel_ex;
    logic hazard_ex;

    logic [31:0] pc_4_ex, pc_ex;
    logic [4:0] rd_ex, rs1_ex, rs2_ex;
    logic [31:0] rs1_data_ex, rs2_data_ex, imm_ex;

    // always @(posedge clk) begin
        // $display("clear ex stall_de || branch_out_ex %b", stall_de || branch_out_ex);
    // end

    register_en_clear #(
        .WIDTH(1)
    ) _register_write_en_ex (
        .clk(clk),
        .enable(1'b1),
        .clear(stall_de || branch_out_ex),
        .data_save(register_write_en_de),
        .data_out(register_write_en_ex)
    );

    register_en_clear #(
        .WIDTH(1)
    ) _alu_a_ex (
        .clk(clk),
        .enable(1'b1),
        .clear(stall_de || branch_out_ex),
        .data_save(alu_a_de),
        .data_out(alu_a_ex)
    );

    register_en_clear #(
        .WIDTH(1)
    ) _alu_b_ex (
        .clk(clk),
        .enable(1'b1),
        .clear(stall_de || branch_out_ex),
        .data_save(alu_b_de),
        .data_out(alu_b_ex)
    );

    register_en_clear #(
        .WIDTH(4)
    ) _alu_op_ex (
        .clk(clk),
        .enable(1'b1),
        .clear(stall_de || branch_out_ex),
        .data_save(alu_op_de),
        .data_out(alu_op_ex)
    );

    register_en_clear #(
        .WIDTH(5)
    ) _branch_op_ex (
        .clk(clk),
        .enable(1'b1),
        .clear(stall_de || branch_out_ex),
        .data_save(branch_op_de),
        .data_out(branch_op_ex)
    );

    register_en_clear #(
        .WIDTH(1)
    ) _data_write_en_ex (
        .clk(clk),
        .enable(1'b1),
        .clear(stall_de || branch_out_ex),
        .data_save(data_write_en_de),
        .data_out(data_write_en_ex)
    );

    register_en_clear #(
        .WIDTH(3)
    ) _dm_control_ex (
        .clk(clk),
        .enable(1'b1),
        .clear(stall_de || branch_out_ex),
        .data_save(dm_control_de),
        .data_out(dm_control_ex)
    );

    register_en_clear #(
        .WIDTH(2)
    ) _rd_data_sel_ex (
        .clk(clk),
        .enable(1'b1),
        .clear(stall_de || branch_out_ex),
        .data_save(rd_data_sel_de),
        .data_out(rd_data_sel_ex)
    );

    register_en_clear _pc_4_ex (
        .clk(clk),
        .enable(1'b1),
        .clear(stall_de || branch_out_ex),
        .data_save(pc_4_de),
        .data_out(pc_4_ex)
    );

    register_en_clear _pc_ex (
        .clk(clk),
        .enable(1'b1),
        .clear(stall_de || branch_out_ex),
        .data_save(pc_de),
        .data_out(pc_ex)
    );

    register_en_clear _rs1_data_ex (
        .clk(clk),
        .enable(1'b1),
        .clear(stall_de || branch_out_ex),
        .data_save(rs1_data_de),
        .data_out(rs1_data_ex)
    );

    register_en_clear _rs2_data_ex (
        .clk(clk),
        .enable(1'b1),
        .clear(stall_de || branch_out_ex),
        .data_save(rs2_data_de),
        .data_out(rs2_data_ex)
    );

    register_en_clear _imm_ex (
        .clk(clk),
        .enable(1'b1),
        .clear(stall_de || branch_out_ex),
        .data_save(imm_de),
        .data_out(imm_ex)
    );

    register_en_clear #(
        .WIDTH(5)
    ) _rd_ex (
        .clk(clk),
        .enable(1'b1),
        .clear(stall_de || branch_out_ex),
        .data_save(rd_de),
        .data_out(rd_ex)
    );

    register_en_clear #(
        .WIDTH(5)
    ) _rs1_ex (
        .clk(clk),
        .enable(1'b1),
        .clear(stall_de || branch_out_ex),
        .data_save(rs1_de),
        .data_out(rs1_ex)
    );

    register_en_clear #(
        .WIDTH(5)
    ) _rs2_ex (
        .clk(clk),
        .enable(1'b1),
        .clear(stall_de || branch_out_ex),
        .data_save(rs2_de),
        .data_out(rs2_ex)
    );

    // execute
    forwarding_unit _forwarding_unit (
        .rs1_ex(rs1_ex),
        .rs2_ex(rs2_ex),
        .write_en_me(register_write_en_me),
        .write_en_wb(register_write_en_wb),
        .rd_me(rd_me),
        .rd_wb(rd_wb),
        .alu_a_sel(sel_forward_a_ex),
        .alu_b_sel(sel_forward_b_ex)
    );

    logic [31:0] forward_a_ex, forward_b_ex;

    mux_3 _forward_a (
        .a(rs1_data_ex),
        .b(alu_me),
        .c(rd_data_wb),
        .sel(sel_forward_a_ex),
        .mux_out(forward_a_ex)
    );

    mux_3 _forward_b (
        .a(rs2_data_ex),
        .b(alu_me),
        .c(rd_data_wb),
        .sel(sel_forward_b_ex),
        .mux_out(forward_b_ex)
    );

    mux_2 _alu_a (
        .a(forward_a_ex),
        .b(pc_ex),
        .sel(alu_a_ex),
        .mux_out(a_ex)
    );

    mux_2 _alu_b (
        .a(forward_b_ex),
        .b(imm_ex),
        .sel(alu_b_ex),
        .mux_out(b_ex)
    );

    alu _alu (
        .a(a_ex),
        .b(b_ex),
        .alu_op(alu_op_ex),
        .alu_out(alu_out_ex)
    );

    branch_unit _branch_unit(
        .a(forward_a_ex),
        .b(forward_b_ex),
        .branch_op(branch_op_ex),
        .branch_out(branch_out_ex)
    );

    // execute registers
    // control unit
    logic register_write_en_me, data_write_en_me;
    logic [2:0] dm_control_me;
    logic [1:0] rd_data_sel_me;

    logic [31:0] pc_4_me, alu_me, rs2_data_me;
    logic [4:0] rd_me;

    register_en_clear #(
        .WIDTH(1)
    ) _register_write_en_me (
        .clk(clk),
        .enable(1'b1),
        .clear(1'b0),
        .data_save(register_write_en_ex),
        .data_out(register_write_en_me)
    );

    register_en_clear #(
        .WIDTH(1)
    ) _data_write_en_me (
        .clk(clk),
        .enable(1'b1),
        .clear(1'b0),
        .data_save(data_write_en_ex),
        .data_out(data_write_en_me)
    );

    register_en_clear #(
        .WIDTH(3)
    ) _dm_control_me (
        .clk(clk),
        .enable(1'b1),
        .clear(1'b0),
        .data_save(dm_control_ex),
        .data_out(dm_control_me)
    );

    register_en_clear #(
        .WIDTH(2)
    ) _rd_data_sel_me (
        .clk(clk),
        .enable(1'b1),
        .clear(1'b0),
        .data_save(rd_data_sel_ex),
        .data_out(rd_data_sel_me)
    );

    register_en_clear _pc_4_me (
        .clk(clk),
        .enable(1'b1),
        .clear(1'b0),
        .data_save(pc_4_ex),
        .data_out(pc_4_me)
    );

    register_en_clear _alu_me (
        .clk(clk),
        .enable(1'b1),
        .clear(1'b0),
        .data_save(alu_out_ex),
        .data_out(alu_me)
    );

    register_en_clear _rs2_data_me (
        .clk(clk),
        .enable(1'b1),
        .clear(1'b0),
        .data_save(rs2_data_ex),
        .data_out(rs2_data_me)
    );

    register_en_clear #(
        .WIDTH(5)
    ) _rd_me (
        .clk(clk),
        .enable(1'b1),
        .clear(1'b0),
        .data_save(rd_ex),
        .data_out(rd_me)
    );

    // memory
    data_memory _data_mem (
        .write_en(data_write_en_me),
        .dm_control(dm_control_me),
        .address(alu_me),
        .write_data(rs2_data_me),
        .read_data(read_data_me)
    );

    // memory registers
    // control unit
    logic register_write_en_wb;
    logic [1:0] rd_data_sel_wb;

    logic [31:0] pc_4_wb, read_data_wb, alu_wb;
    logic [4:0] rd_wb;

    register_en_clear #(
        .WIDTH(1)
    ) _register_write_en_wb (
        .clk(clk),
        .enable(1'b1),
        .clear(1'b0),
        .data_save(register_write_en_me),
        .data_out(register_write_en_wb)
    );

    register_en_clear #(
        .WIDTH(2)
    ) reg_rd_data_sel_wb (
        .clk(clk),
        .enable(1'b1),
        .clear(1'b0),
        .data_save(rd_data_sel_me),
        .data_out(rd_data_sel_wb)
    );

    register_en_clear _reg_pc_4_wb (
        .clk(clk),
        .enable(1'b1),
        .clear(1'b0),
        .data_save(pc_4_me),
        .data_out(pc_4_wb)
    );

    register_en_clear _reg_read_data_wb (
        .clk(clk),
        .enable(1'b1),
        .clear(1'b0),
        .data_save(read_data_me),
        .data_out(read_data_wb)
    );

    register_en_clear _reg_alu_wb (
        .clk(clk),
        .enable(1'b1),
        .clear(1'b0),
        .data_save(alu_me),
        .data_out(alu_wb)
    );

    register_en_clear #(
        .WIDTH(5)
    ) _reg_rd_wb (
        .clk(clk),
        .enable(1'b1),
        .clear(1'b0),
        .data_save(rd_me),
        .data_out(rd_wb)
    );

    // write back
    mux_2 _next_pc_wb (
        .a(pc_4_fe),
        .b(alu_out_ex),
        .sel(branch_out_ex),
        .mux_out(next_pc)
    );

    mux_3 _rd_data_wb (
        .a(alu_wb),
        .b(read_data_wb),
        .c(pc_4_wb),
        .sel(rd_data_sel_wb),
        .mux_out(rd_data_wb)
    );
endmodule