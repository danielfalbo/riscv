# function prints a new line to the console

.text
    # print 1
    li a7, 1
    li a0, 1
    ecall

    # print new line
    jal ra, newline

    # print 0
    li a7, 1
    li a0, 0
    ecall

    # print new line
    jal ra, newline

    # exit gracefully
    addi a7, zero, 10
    ecall

    newline:
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
