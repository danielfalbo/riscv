#
#
# sum(head) {
#   return 0                                if head == 0
#   return head.value + sum(head.next)      otherwise
# }
#
#


.data
    n01: .word 7, n02
    n02: .word 11, n03
    n03: .word -2, n04
    n04: .word 8, n05
    n05: .word 9, 0

    head: .word n01

.text
    # a0 = head address
    lw a0, head

    # jump to sum and link at ra
    # the current program counter address
    jal ra, sum


    # print the result, and exit gracefully
    li a7, 1
    ecall
    li a7, 10
    ecall

    sum:
        # if a0 != 0, jump to recursive call
        bne a0, zero, sum_recursive_call

        # return
        jalr zero, 0(ra)

    sum_recursive_call:
        # decrement the stack pointer by 2 words
        # to make room for 2 pieces of data
        addi sp, sp, -0x08

        # push onto the stack the return address
        # and the value of the given node
        sw ra, 0(sp)
        lw t0, 0(a0)
        sw t0, 4(sp)

        # make a0 point to the next node and call sum again
        lw a0, 4(a0)
        jal sum # same as `jal ra, sum`

        # read from the stack the result of the recursive call
        # to sum, and add it to a0
        lw t0, 4(sp)
        add a0, a0, t0

        # load from the stack the return address of the
        # function that called us and move the stack
        # pointer 2 words forward
        lw ra, 0(sp)
        addi sp, sp, 8

        # jump to the return address of the function that called us
        jalr zero, 0(ra)

