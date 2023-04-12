#
#
# len(head) {
#   return 0                        if head == 0
#   return 1 + len(head.next)       otherwise
# }
#
#

.data
    n01: .word 7, n02
    n04: .word 8, n05
    n02: .word 11, n03
    n03: .word -2, n04
    n05: .word 9, 0

    head: .word n01

.text
    # a0 = address of the head
    lw a0, head

    # put into ra the current instruction address,
    # then jump to len
    jal ra, len

    # print the result, which the function should leave at a0 for us
    # and the OS will read as argument for its job as always
    li a7, 1
    ecall

    # exit gracefully
    li a7, 10
    ecall

    len:
        # if a0 != 0, jump to recursive call
        bne a0, zero, lenRecursiveCall

        # then return
        jalr zero, ra, 0

    lenRecursiveCall:
        # decrement the stack pointer by 1 word
        # to make room for 1 piece of data
        addi sp, sp, -4

        # push the return address onto the stack
        sw ra, 0(sp)

        # make a0 point to a0.next and call len
        lw a0, 4(a0)
        jal len # same as `jal ra, len`

        # increment a0
        addi a0, a0, 1

        # load from the stack the return address of the last function call
        # and move the stack address 1 word forward
        lw ra, 0(sp)
        addi sp, sp, 0x04

        # jump to the instruction at 0 offset from the
        # address in ra and discard our instruction address
        # (it's like we store it onto the register that's always zero)
        jalr zero, 0(ra) # same as `jalr zero, ra, 0`
