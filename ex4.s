#
#
# Given two integers stored in the RAM memory
# (in the data segment), this program prints the smaller
#
#

.data
    .word -1 # 0x10010000
    .word 99 # 0x10010004

.text
    lui s0, 0x10010

    # t0 <- first integer
    # t1 <- second integer
    lw t0, 0(s0)
    lw t1, 4(s0)

    # if t0 >= t1,
    # a0 <- t1, the smaller integer
    bge t0, t1, load_t1_then_print

    # otherwise, a0 <- t0, then we print
    add a0, zero, t0
    beq zero, zero, print

    load_t1_then_print:
        add a0, zero, t1
        beq zero, zero, print

    print:
        # a7 <- instruction code 1 "print integer"
        addi a7, zero, 1
        ecall

        # a7 <- instruction code "exit with code 0"
        addi a7, zero, 10
        ecall
