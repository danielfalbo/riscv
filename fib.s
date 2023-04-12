#
# This program prints the nth fibonacci number
# (n is a word in the data segment)
#

.data
    # .word 0 # 0x10010000
    # .word 1 # 0x10010000
    # .word 2 # 0x10010000
    # .word 3 # 0x10010000
    # .word 4 # 0x10010000
    .word 7 # 0x10010000

.text
    lui s0, 0x10010

    # t0: counter of iterations
    # (at the beginning,
    #  index of fib num we want to compute)
    lw t0, 0(s0)

    # if counter == 0 (we want to print the 0th fib num):
    #   just print 0 (default a0 value)
    beq t0, zero, print_and_exit

    # t1: prev fib num (at the beginning, 1st fib num)
    addi t1, zero, 1

    # a0: last fib num (at the beginning, 2nd fib num)
    addi a0, zero, 1

    # decrement counter by two as we have 2nd (and 1st)
    # fib nums ready to be printed (in a0)
    addi t0, t0, -2

    # while 0 < counter:
    #   t2: (tmp t0 cache) <- a0
    #   a0: (last fib num) <- a0 + t1
    #   t1: (prev fib num) <- t2
    #   decrement counter t0
    #
    # (when 0 >= counter: print_and_exit)
    loop:
        bge zero, t0, print_and_exit
        add t2, zero, a0
        add a0, a0, t1
        add t1, zero, t2
        addi t0, t0, -1
        beq zero, zero, loop

    print_and_exit:
        # print integer
        addi a7, zero, 1
        ecall

        # exit gracefully
        addi a7, zero, 10
        ecall
