#
#
# factorial(n) {
#   return 1                        if n == 0
#   return n * fact(n - 1)          otherwise
# }
#
#

.text
    # load n onto a0, as function argument
    li a0, 5

    # put into ra the current instruction address,
    # then jump to factorial
    jal ra, factorial

    # print the result, which the function should leave at a0 for us
    # and the OS will read as argument for its job as always
    li a7, 1
    ecall

    # call the newline function
    jal ra, newline

    # exit gracefully
    li a7, 10
    ecall

    factorial:
        # if a0 != 0, we jump to the recursive call
        bne a0, zero, factorial_recursive_call

        # otherwise, a0 == 0, so we put 1 onto a0
        li a0, 1

        # and return to instruction at address ra
        jalr zero, ra, 0

    factorial_recursive_call:
        # decrement the stack pointer by 2 words
        # to make room for 2 pieces of data
        addi sp, sp, -8

        # push the return address and the argument onto the stack
        sw ra, 0(sp)
        sw a0, 4(sp)

        # decrement the argument and call factorial
        addi a0, a0, -1
        jal factorial # same as `jal ra, factorial`

        # load onto t0 the return value of the last recursive
        # call from the stack and multiply a0 by t0
        lw t0, 4(sp)
        mul a0, a0, t0

        # load from the stack the return address of the last function call
        # and move the stack address 2 words forward
        lw ra, 0(sp)
        addi sp, sp, 8

        # jump to the instruction at 0 offset from the
        # address in register ra and discard our instruction address
        # (it's like we store it onto the register that's always zero)
        jalr zero, 0(ra) # same as `jalr zero, ra, 0`

    newline:
        # 10 is ascii code for "\n"
        li a0, 10
        # 11 is OS instruction code for "print character"
        li a7, 11

        # os call
        ecall

        # return
        jalr zero, ra, 0 # same as `jalr zero, 0(ra)`
