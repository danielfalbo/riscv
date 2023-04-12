.data
    .asciz "acsai è fighissimo" # 0x10010000
    # note: "è" couts for 2 characters

.text
    # load the address of the beginning of the str we want to measure the length of
    lui s0, 0x10010

    # initialize a0 with a 0
    # we'll use this register as a variable to count the length of the string
    # being at a0, it'll also be ready to be printed by the OS
    addi a0, zero, 0

    loop_location:
        # load the byte that begins at the address stored at s0
        # (which will be the first character of the string)
        # onto t0
        lb t0, 0(s0)

        # if the loaded byte is 0, the terminator,
        # it means we looped through the whole string
        # so we jump to the location of the program where
        # we print whatever length we counted
        beq t0, zero, syscall_location

        # otherwise, we increase the counter of the length at a0 by 1
        addi a0, a0, 1

        # and also increment the address of the next character byte of the string
        # to analyse the next character of the string
        addi s0, s0, 1

        # and jump to the beginning of this loop again
        beq zero, zero, loop_location

    syscall_location:
        # load onto the register a7, the instruction code for "print integer": 1
        addi a7, zero, 1

        # OS call
        # a7 will be 1, instruction code for "print integer"
        # a0 will be the length of the string, which will be printed
        ecall

        # load onto a7 the instruction code for "exit with code 0": 10
        ori a7, zero, 10

        # OS call
        # a7 will be 10, so it will exit the program with successful exit code (0)
        ecall
