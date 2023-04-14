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
        beq a0, zero, return

        addi sp, sp, -4
        sw ra, 0(sp)

        lw a0, 4(a0)
        jal ra, f

        addi a0, a0, 1

        lw ra, 0(sp)
        addi sp, sp, 4
        beq, zero, zero, return

    return:
        jalr zero, 0(ra)

    exit:
        li a7, 1
        ecall
        li a7, 10
        ecall
