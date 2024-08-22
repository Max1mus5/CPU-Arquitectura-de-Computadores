#! /c/Source/iverilog-install/bin/vvp
:ivl_version "12.0 (devel)" "(s20150603-1539-g2693dd32b)";
:ivl_delay_selection "TYPICAL";
:vpi_time_precision + 0;
:vpi_module "C:\iverilog\lib\ivl\system.vpi";
:vpi_module "C:\iverilog\lib\ivl\vhdl_sys.vpi";
:vpi_module "C:\iverilog\lib\ivl\vhdl_textio.vpi";
:vpi_module "C:\iverilog\lib\ivl\v2005_math.vpi";
:vpi_module "C:\iverilog\lib\ivl\va_math.vpi";
S_000002b4568fa020 .scope module, "testbench" "testbench" 2 1;
 .timescale 0 0;
v000002b456900a20_0 .var "clk", 0 0;
v000002b456901100_0 .net "readData1", 31 0, L_000002b45690a570;  1 drivers
v000002b456901600_0 .net "readData2", 31 0, L_000002b45690a880;  1 drivers
v000002b456901560_0 .var "readReg1", 4 0;
v000002b4569014c0_0 .var "readReg2", 4 0;
v000002b456900980_0 .var "regWrite", 0 0;
v000002b456900700_0 .var "reset", 0 0;
v000002b456900e80_0 .var "writeData", 31 0;
v000002b456900ac0_0 .var "writeReg", 4 0;
S_000002b456907520 .scope module, "uut" "RegisterFile" 2 13, 3 1 0, S_000002b4568fa020;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "clk";
    .port_info 1 /INPUT 1 "reset";
    .port_info 2 /INPUT 1 "regWrite";
    .port_info 3 /INPUT 5 "readReg1";
    .port_info 4 /INPUT 5 "readReg2";
    .port_info 5 /INPUT 5 "writeReg";
    .port_info 6 /INPUT 32 "writeData";
    .port_info 7 /OUTPUT 32 "readData1";
    .port_info 8 /OUTPUT 32 "readData2";
L_000002b45690a570 .functor BUFZ 32, L_000002b456900f20, C4<00000000000000000000000000000000>, C4<00000000000000000000000000000000>, C4<00000000000000000000000000000000>;
L_000002b45690a880 .functor BUFZ 32, L_000002b4569008e0, C4<00000000000000000000000000000000>, C4<00000000000000000000000000000000>, C4<00000000000000000000000000000000>;
v000002b4568f7ef0_0 .net *"_ivl_0", 31 0, L_000002b456900f20;  1 drivers
v000002b456846cc0_0 .net *"_ivl_10", 6 0, L_000002b4569011a0;  1 drivers
L_000002b456960080 .functor BUFT 1, C4<00>, C4<0>, C4<0>, C4<0>;
v000002b4569076b0_0 .net *"_ivl_13", 1 0, L_000002b456960080;  1 drivers
v000002b456907750_0 .net *"_ivl_2", 6 0, L_000002b456901060;  1 drivers
L_000002b456960038 .functor BUFT 1, C4<00>, C4<0>, C4<0>, C4<0>;
v000002b4569077f0_0 .net *"_ivl_5", 1 0, L_000002b456960038;  1 drivers
v000002b456907890_0 .net *"_ivl_8", 31 0, L_000002b4569008e0;  1 drivers
v000002b456900570_0 .net "clk", 0 0, v000002b456900a20_0;  1 drivers
v000002b456900610_0 .var/i "i", 31 0;
v000002b456900ca0_0 .net "readData1", 31 0, L_000002b45690a570;  alias, 1 drivers
v000002b4569007a0_0 .net "readData2", 31 0, L_000002b45690a880;  alias, 1 drivers
v000002b456900fc0_0 .net "readReg1", 4 0, v000002b456901560_0;  1 drivers
v000002b456900840_0 .net "readReg2", 4 0, v000002b4569014c0_0;  1 drivers
v000002b456900c00_0 .net "regWrite", 0 0, v000002b456900980_0;  1 drivers
v000002b456900d40 .array "registers", 0 31, 31 0;
v000002b456900de0_0 .net "reset", 0 0, v000002b456900700_0;  1 drivers
v000002b456901380_0 .net "writeData", 31 0, v000002b456900e80_0;  1 drivers
v000002b4569012e0_0 .net "writeReg", 4 0, v000002b456900ac0_0;  1 drivers
E_000002b4568f86d0 .event posedge, v000002b456900de0_0, v000002b456900570_0;
L_000002b456900f20 .array/port v000002b456900d40, L_000002b456901060;
L_000002b456901060 .concat [ 5 2 0 0], v000002b456901560_0, L_000002b456960038;
L_000002b4569008e0 .array/port v000002b456900d40, L_000002b4569011a0;
L_000002b4569011a0 .concat [ 5 2 0 0], v000002b4569014c0_0, L_000002b456960080;
    .scope S_000002b456907520;
T_0 ;
    %wait E_000002b4568f86d0;
    %load/vec4 v000002b456900de0_0;
    %flag_set/vec4 8;
    %jmp/0xz  T_0.0, 8;
    %pushi/vec4 0, 0, 32;
    %store/vec4 v000002b456900610_0, 0, 32;
T_0.2 ;
    %load/vec4 v000002b456900610_0;
    %cmpi/s 32, 0, 32;
    %jmp/0xz T_0.3, 5;
    %pushi/vec4 0, 0, 32;
    %ix/getv/s 3, v000002b456900610_0;
    %ix/load 4, 0, 0; Constant delay
    %assign/vec4/a/d v000002b456900d40, 0, 4;
    %load/vec4 v000002b456900610_0;
    %addi 1, 0, 32;
    %store/vec4 v000002b456900610_0, 0, 32;
    %jmp T_0.2;
T_0.3 ;
    %jmp T_0.1;
T_0.0 ;
    %load/vec4 v000002b456900c00_0;
    %flag_set/vec4 8;
    %jmp/0xz  T_0.4, 8;
    %load/vec4 v000002b456901380_0;
    %load/vec4 v000002b4569012e0_0;
    %pad/u 7;
    %ix/vec4 3;
    %ix/load 4, 0, 0; Constant delay
    %assign/vec4/a/d v000002b456900d40, 0, 4;
T_0.4 ;
T_0.1 ;
    %jmp T_0;
    .thread T_0;
    .scope S_000002b4568fa020;
T_1 ;
    %delay 5, 0;
    %load/vec4 v000002b456900a20_0;
    %inv;
    %store/vec4 v000002b456900a20_0, 0, 1;
    %jmp T_1;
    .thread T_1;
    .scope S_000002b4568fa020;
T_2 ;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v000002b456900a20_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v000002b456900700_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v000002b456900980_0, 0, 1;
    %pushi/vec4 0, 0, 5;
    %store/vec4 v000002b456901560_0, 0, 5;
    %pushi/vec4 0, 0, 5;
    %store/vec4 v000002b4569014c0_0, 0, 5;
    %pushi/vec4 0, 0, 5;
    %store/vec4 v000002b456900ac0_0, 0, 5;
    %pushi/vec4 0, 0, 32;
    %store/vec4 v000002b456900e80_0, 0, 32;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v000002b456900700_0, 0, 1;
    %delay 10, 0;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v000002b456900700_0, 0, 1;
    %pushi/vec4 1, 0, 5;
    %store/vec4 v000002b456900ac0_0, 0, 5;
    %pushi/vec4 3735928559, 0, 32;
    %store/vec4 v000002b456900e80_0, 0, 32;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v000002b456900980_0, 0, 1;
    %delay 10, 0;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v000002b456900980_0, 0, 1;
    %pushi/vec4 1, 0, 5;
    %store/vec4 v000002b456901560_0, 0, 5;
    %pushi/vec4 2, 0, 5;
    %store/vec4 v000002b4569014c0_0, 0, 5;
    %delay 10, 0;
    %pushi/vec4 2, 0, 5;
    %store/vec4 v000002b456900ac0_0, 0, 5;
    %pushi/vec4 3405691582, 0, 32;
    %store/vec4 v000002b456900e80_0, 0, 32;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v000002b456900980_0, 0, 1;
    %delay 10, 0;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v000002b456900980_0, 0, 1;
    %pushi/vec4 1, 0, 5;
    %store/vec4 v000002b456901560_0, 0, 5;
    %pushi/vec4 2, 0, 5;
    %store/vec4 v000002b4569014c0_0, 0, 5;
    %delay 10, 0;
    %vpi_call 2 64 "$stop" {0 0 0};
    %end;
    .thread T_2;
    .scope S_000002b4568fa020;
T_3 ;
    %vpi_call 2 69 "$dumpfile", "registerfile_tb.vcd" {0 0 0};
    %vpi_call 2 70 "$dumpvars", 32'sb00000000000000000000000000000000, S_000002b4568fa020 {0 0 0};
    %end;
    .thread T_3;
# The file index is used to find the file name in the following table.
:file_names 4;
    "N/A";
    "<interactive>";
    ".\RegisterFile_tb.v";
    "..\components\RegisterFile.v";
