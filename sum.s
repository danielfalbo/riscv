# function f(a, b) computes a + b

.text
    li a2, 2
    li a3, 2
    jal ra, sum

    # print result (stored in a0 by tradition)
    li a7, 1
    ecall

    # print newline
    jal ra, newLine

    # exit gracefully
    li a7, 10
    ecall

    sum:
        add a0, a2, a3
        jalr zero, ra, 0


    newLine:
        # li: load immediate
        #       uses addi, ori, or something like that
        #       under the hood
        # 10: ascii code for "\n"
        li a0, 10
        # 11: system call for "print character"
        li a7, 11
        ecall

        # jump back to where we left
        jalr zero, ra, 0
