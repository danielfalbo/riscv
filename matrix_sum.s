#
# Given a matrix in the data segment, this program
# computes and prints the sum of its elements.
#

.data
    # r:  .word 3
    # c:  .word 3

    # m:  .word 4, 7, -2
    #     .word 0, 1, 0
    #     .word 1, 5, 8

    r:  .word 3
    c:  .word 2

    m:  .word 4, 7
        .word 0, 1
        .word 1, 5

.text
    # t0 = address of beginning of matrix
    lui t0, 0x10010
    addi t0, t0, 8

    lw t1, r # t1 = number or rows
    lw t2, c # t2 = number of columns
    li s0, 0

    double_nested_loop:
        # t3 = value at address t0
        lw t3, 0(t0)

        # s0 = s0 + t3
        add s0, s0, t3

        # make t0 point to next word
        addi t0, t0, 4

        # decrement t2
        addi t2, t2, -1

        # if t2 != 0: continue
        bne t2, zero, double_nested_loop

        # else

        # decrement t1
        addi t1, t1, -1

        # t2 = number of columns
        lw t2, c

        # if t1 != zero: continue
        bne t1, zero, double_nested_loop

        # else

        # a0 = s0
        addi a0, s0, 0

        # print a0
        addi a7, zero, 1
        ecall

        # exit
        li a7, 10
        ecall
