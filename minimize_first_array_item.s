.data
    len: .word 8
    arr: .word 2,5,4,1,6,7,-2,-3

    # len: .word 1
    # arr: .word 5

.text
    lw a0, len
    la a1, arr
    jal ra, minimize
    beq zero, zero, print

    minimize:
        addi t0, a1, 4 # t0 = address of the 2nd item of the array
        addi a0, a0, -1 # a0 = len - 1
        beq zero, zero, minimize_loop

    minimize_loop:
        beq a0, zero, return

        lw t1, 0(t0)
        lw t2, arr
        blt t1, t2, swap

        beq zero, zero, continue

    swap:
        sw t2, 0(t0)
        la t3, arr
        sw t1, 0(t3)

        beq zero, zero, continue

    continue:
        addi t0, t0, 4
        addi a0, a0, -1
        beq zero, zero, minimize_loop

    print:
        lw t0, len
        la t1, arr
        beq zero, zero, print_loop

    print_loop:
        beq t0, zero, exit
        lw a0, 0(t1)
        li a7, 1
        ecall
        li a0, 10
        li a7, 11
        ecall
        addi t1, t1, 4
        addi t0, t0, -1
        beq zero, zero, print_loop

    return: jalr zero, ra, 0

    exit:
        li a7, 10
        ecall
