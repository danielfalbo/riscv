# function f(a, b) computes a + b

.text
    # load arguments
    li a2, 2
    li a3, 2

    # call function
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
        li a0, 10
        li a7, 11
        ecall

        jalr zero, ra, 0
