#
#
# This program computes and prints the sum of an array
#
#

.data
    .word 6 # length (0x10010000)
    .word 3, 5, 11, 12, 21, 27

.text
    # load address of the start of the array onto s0
    lui s0, 0x10010

    # load the first value of the array (the length) at t0
    lw t0, 0(s0)

    # initialize a0 variable with 0
    # we'll store the sum here
    addi a0, zero, 0

    # load onto stack pointer the address of the first array element
    addi sp, s0, 4

    countLoop:
        # if we looped through the entire array, jump to the osCall
        #
        # that is, if the value in variable storing the number of
        # elements left to count equals zero
        beq t0, zero, osCall

        # otherwise, load next value of the array
        lw t2, 0(sp)

        # increase sum by value of the array element
        add a0, a0, t2

        # advance the pointer of the current element being analysed
        addi sp, sp, 4

        # decrement variable storing number of remaining elements
        addi t0, t0, -1

        # and repeat
        beq zero, zero, countLoop


    osCall:
        # os call with instruction code 1 into a7: to "print integer"
        # will print the integer at a0, which is the sum we computed
        addi a7, zero, 1
        ecall

        # and exit gracefully
        addi, a7, zero, 10
        ecall
