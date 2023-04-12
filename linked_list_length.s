#
#
# Counts and prints how many nodes a linked list has.
#
#

.data # 0x10010000
    n01: .word 7, n02
    n02: .word 11, n03
    n03: .word -2, n04
    n04: .word 8, 0

    head: .word n01

.text
    # s0 = address of the head
    lw s0, head

    # a0 = 0
    li a0, 0

    # if s0 == zero, list is empty, so just print length a0 and exit
    beq s0, zero, print_and_exit_gracefully
    # else

    loadNextPointerAndIncrementLengthCounterLoop:
        # s0 = head address + 4, second word from the head, head.next
        lw s0, 4(s0)

        # increment a0
        addi a0, a0, 1

        # if s0 != zero, loop again
        bne s0, zero, loadNextPointerAndIncrementLengthCounterLoop

        # else, print and exit
        beq zero, zero, print_and_exit_gracefully

    print_and_exit_gracefully:
        li a7, 1
        ecall
        li a7, 10
        ecall
