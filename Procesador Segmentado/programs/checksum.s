beq x0, x0, _main

_mod: # x11 a, x12 b, x10 return
    add x10, x0, x11
_mod_while:
    blt x10, x12, _mod_endwhile
    sub x10, x10, x12
    beq x0, x0, _mod_while
_mod_endwhile:
    jalr ra, ra, 0

_check_sum: # x8 M[], x12 n, x10 return
    add x11, x0, x0
    add x5, x0, x0
_check_sum_for:
    bge x5, x12, _check_sum_endfor
    add x6, x8, x5
    lbu x6, 0(x6)
    add x11, x11, x6
    addi x5, x5, 1
    beq x0, x0, _check_sum_for
_check_sum_endfor:
    addi sp, sp, -4
    sw ra, 0(sp)
    addi x12, x0, 256
    jal ra, _mod
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr ra, ra, 0

_main: # x8 M[]
    add x8, x0, x0
    addi x5, x0, 254
    sb x5, 0(x8)
    addi x5, x0, 1
    sb x5, 1(x8)
    addi x5, x0, 2
    sb x5, 2(x8)

    addi x12, x0, 3
    addi sp, sp, 0x400
    jal ra, _check_sum
    add x8, x0, x10
    ecall