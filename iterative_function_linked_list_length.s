.data:
    head: .word n01
    # head: .word 0

    # n01:    .word 0, 0
    n01:   .word 3, n02
    n02:   .word 7, n03
    n03:   .word 6, n04
    n04:   .word 2, n05
    n05:   .word 6, 0

.text:
    lw a0, head
    jal ra, f
    beq zero, zero, exit

    f:
        li t0, 0
        beq zero, zero, loop_f

    loop_f:
        beq a0, zero, return
        addi t0, t0, 1
        lw a0, 4(a0)
        beq zero, zero, loop_f

    return:
        add a0, zero, t0
        jalr zero, 0(ra)

    exit:
        li a7, 1
        ecall
        li a7, 10
        ecall
