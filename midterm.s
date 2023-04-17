.data
    head: .word n01

    # n01: .word 10, 0
    n01: .word 4, n02
    n02: .word -2, n03
    n03: .word 3, n04
    n04: .word 4, n05
    n05: .word 4, n06
    n06: .word 3, n07
    n07: .word 1, 0

    x: .word 5
    # x: .word 0
    # x: .word 7
    # x: .word 4

.text
    lw s0, head
    lw s1, x
    li a0, 0

    skip_loop:
        beq s1, zero, sum_loop
        lw s0, 4(s0)
        addi s1, s1, -1
        beq zero, zero, skip_loop

    sum_loop:
        beq s0, zero, exit
        lw t0, 0(s0)
        add a0, a0, t0
        lw s0, 4(s0)
        beq zero, zero, sum_loop

    exit:
        li a7, 1
        ecall
        li a7, 10
        ecall
