#
#
# This program prints "zero" if the integer stored
# in memory at 0x10010000 is 0, "non_zero" otherwise
#
#

.data # starts at address 0x10010

    # takes 4 bytes: all words take 4 bytes in 32-bit risc-v
    .word 9 # starts at 0x10010

    # takes 5 bytes: 1 per char + 1 for terminator
    .asciz "zero" # starts at 0x10010004

    # takes 9 bytes: 1 per char + 1 for terminator
    .asciz "non_zero" # starts at 0x10010009

    # takes 5 bytes just like "zero"
    .asciz "ciao" # starts at 0x10010012

.text # starts at address 0x00400000
    # load the address of the integer we want to check onto s0
    lui s0, 0x10010

    # load the address of the string "zero" (0x10010004 in our case)
    # onto register a0 (alias for x10)
    #
    # by adding 4 to the address of s0 (first word in memory)
    # and storing the result in a0
    ori a0, s0, 0x04

    # load onto a7 the instruction code 4,
    # because we want to print a string
    # and 4 is the OS instruction code for "print string"
    #
    # by adding 4 to zero and storing the result in a7
    # because, when called, the OS reads a7 for the instruction code
    addi a7, zero, 4

    # load our integer (whose address is stored at s0) onto t0
    lw t0, 0(s0)


    # if t0 (which is storing our integer) is equal to 0,
    # jump to the ecall (otherwise, don't jump, keep going)
    beq t0, zero, jump_location

    # so, if it didn't jump, we load the string "non_zero" onto a0
    ori a0, s0, 9



    # OS call
    #
    # by default, the OS runs the instruction whose code is stored at a7
    #
    # if the OS instruction requires 1 argument, the OS looks for it at a0
    #
    # in this case, since a7 contains 4, the instruction code for "print string",
    jump_location: ecall
