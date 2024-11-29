beq x0, x0, _start

_mult: # x11 a, x12 b
    add x5, x0, x0 # result
_while:
    beq x12, x0, _endwhile
    blt x12, x0, _else
    # if
    add x5, x5, x11
    addi x12, x12, -1
    beq x0, x0, _while
_else:
    sub x5, x5, x11
    addi x12, x12, 1
    beq x0, x0, _while
_endwhile:
    add x10, x0, x5
    jalr ra, ra, 0

_start:
    addi x11, x0, 4
    addi x12, x0, 3
    jal ra, _mult
    add x8, x0, x10
    ecall