.data:
    # x: .word 0
    # x: .word 5
    # x: .word 1
    x: .word -1

    len: .word 4
    # arr: .word 5, 3, 0, -1
    arr: .word 5, 0, 0, -1
    # arr: .word 0, 0, 0, 0
    # arr: .word 1, 1, 1, -1

.text:
    lw t0, x
    lw t1, len
    la t2, arr
    li a0, 0

    loop:
        beq t1, zero, exit

        addi t1, t1, -1
        lw t3, 0(t2)
        addi t2, t2, 4

        beq t3, t0, increment

        beq zero, zero, loop

    increment:
        addi a0, a0, 1
        beq zero, zero, loop

    exit:
        li a7, 1
        ecall
        li a7, 10
        ecall
