#
# This program counts and prints the number of elements
# in an array that are smaller than or equal to a given number x.
#

.data
    len:    .word 9
    arr:    .word 121, 256, 365, 404, 505, 69, 7, 808, 94

    x:      .word 100

    # len:    .word 10
    # arr:    .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

    # x:      .word 5

.text
    lw t1, len # t1 = value of len

    # t0 = reference to first element of the array
    lui t0, 0x10010
    addi t0, t0, 4

    # a1 = value of x
    lw a1, x

    # a0 = 0
    addi a0, zero, 0

    beq zero, zero, loop

    loop:
        # t2 = value of current element of the array
        lw t2, 0(t0)

        # if t2 > a1: skip
        bgt t2, a1, skip

        # else: increment a1
        addi a0, a0, 1

    skip:
        # make t0 point to next array element
        addi t0, t0, 4

        # decrement t1
        addi t1, t1, -1

        # if t1 != 0: loop
        bne t1, zero, loop

        # else:

        # print a0
        addi a7, zero, 1
        ecall

        # exit
        addi a7, zero, 10
        ecall
