.data
    .word 9 # 0x1001000

.text
    lui s0, 0x10010

    addi a0, zero, 1

    lw t0, 0(s0)

    loop:
        mul a0, a0, t0
        addi t0, t0, -1
        beq t0, zero, print
        beq zero, zero, loop

    print:
        addi a7, zero, 1
        ecall

        addi a7, zero, 10
        ecall
