.data
    head: .word n01

    n01:   .word 6, n02
    n02:   .word -2, n03
    n03:   .word 0, n04
    n04:   .word 5, 0

.text:
    lw t0, head
    li a0, 0

    loop:
        beq t0, zero, exit
        lw t1, 0(t0)
        add a0, a0, t1
        lw t0, 4(t0)
        beq zero, zero, loop

    exit:
        li a7, 1
        ecall
        li a7, 10
        ecall
