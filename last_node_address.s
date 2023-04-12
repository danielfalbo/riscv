#
# Given a linked list in the data segment,
# this program finds and print the address of its last element.
#

.data:
    head: .word n1

    # n1:     .word 100, 0

    n1:     .word 14, n2
    n2:     .word 9,  n3
    n3:     .word 42, 0

.text:
    lw t0, head
    beq zero, zero, loop

    loop:
        beq t0, zero, print_and_exit

        add a0, t0, zero
        lw t0, 4(t0)

        beq zero, zero, loop

    print_and_exit:
        addi a7, zero, 1
        ecall

        add t0, zero, a0

        addi a0, zero, 10
        addi a7, zero, 11
        ecall

        add a0, zero, t0
        lw a0, 0(a0)
        addi a7, zero, 1
        ecall

        beq zero, zero, exit

    exit:
        addi a7, zero, 10
        ecall
