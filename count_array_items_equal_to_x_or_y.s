.data
    len: .word 7
    arr: .word 4, -2, 3, 4, 4, 3, 1
    # len: .word 1
    # arr: .word 10

    # x: .word 4
    # y: .word 3
    # x: .word 4
    # y: .word 0
    x: .word 0
    y: .word 0

.text
    li a0, 0

    lw s0, len
    la s1, arr

    lw s2, x
    lw, s3, y

    loop:
        beq s0, zero, exit
        lw t0, 0(s1)
        beq t0, s2, increment
        beq t0, s3, increment
        beq zero, zero, continue

    increment:
        addi a0, a0, 1
        beq zero, zero, continue

    continue:
        addi s1, s1, 4
        addi s0, s0, -1
        beq zero, zero, loop

    exit:
        li a7, 1
        ecall
        li a7, 10
        ecall
