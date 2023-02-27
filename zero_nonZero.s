# prints "zero" if an integer in memory is zero, "non_zero" otherwise

.data # starts at address 0x10010000

    # takes 4 bytes: all words take 4 bytes
    .word 2 # starts at 0x10010000

    # takes 5 bytes: 1 per char + 1 for terminator
    .asciz "zero" # starts at 0x10010004

    # takes 9 bytes: 1 per char + 1 for terminator
    .asciz "non_zero" # starts at 0x10010009

    # takes 5 bytes just like "zero"
    .asciz "ciao" # starts at 0x10010012

.text # starts at address 0x00400000

    lui s0, 0x10010 # load the address of our integer argument onto s0

    ori a0, s0, 0x04 # load the string "zero" (that we stored at 0x10010004)
                     # onto register a0 (alias for x10)
                     # by adding 4 to the address of s0 (first word)

    addi a7, zero, 4 # load onto a7 the instruction code 4, because we want to print a string

    lw t0, 0(s0) # load our integer (whose address is stored at s0) onto t0

    beq t0, zero, jumpCall # if t0 (which is storing our integer) is equal to 0,
                           # we just jump to the ecall, otherwise, doesn't jump, keeps going

    ori a0, s0, 9 # so, if it didn't jump, we load the string "non_zero" onto a0

    jumpCall: ecall # call the OS
                # by default, the OS runs the instruction whose code is stored at a7

                # if the OS instruction requires 1 argument, the OS looks for it at a0
                # if it requires more than 1 arguments, it looks for other arguments at a1, a2, etc.

                # in this case, since we stored 4, the instruction code for print string, at a7,
                # the OS will print whatever is at a0
