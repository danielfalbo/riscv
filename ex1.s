# load from memory two integers, sum them up,
# and store the result into the memory
#
# then print the result


.data # starts at address 0x10010000
    .word 17 # 0x10010000
    .word 25 # 0x10010004

.text # starts at address 0x00400000
    # load the address of the first data word onto t0
    lui t0, 0x10010

    # load the value of the word at address stored at t0 onto a0
    lw a0, 0(t0)

    # load the value of the word at address stored at t0 with offset 4,
    # which is the 2nd word starting at the address stored at t0,
    # onto t1
    lw t1, 4(t0)

    # sum the integers stored at a0 and t1, and put the result onto a0
    add a0, a0, t1

    # store at an offset of 8 from the address stored at t0
    # (which means, at the third word in our RAM memory)
    # the value in our CPU register a0
    sw a0, 8(t0)

    ori a7, x0, 1
    ecall

    ori a7, x0, 10
    ecall
