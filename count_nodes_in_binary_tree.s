#
# This program counts and prints the number of nodes
# of the binary tree in the data segment
#

.data
    root:   .word n01

    n01:    .word 8, n02, n03
    n02:    .word 5, n04, n05
    n03:    .word 3, n06, 0
    n04:    .word 7, 0, 0
    n05:    .word -2, 0, 0
    n06:    .word 10, 0, n07
    n07:    .word 0, 0, 0

.text
    lw a0, root # a0 = root reference
    jal ra, count # a0 = count(root)

    # print a0
    addi a7, zero, 1
    ecall

    # print new line
    addi a0, zero, 10
    addi a7, zero, 11
    ecall

    beq zero, zero, exit

    # count(root: a0) {
    #   if root == null: return 0
    #   else: return 1 + count(root.right_child) + count(root.left_child)
    # }
    #
    # overrides a0 with the result!
    count:
        # if root == null: return #(0)
        beq a0, zero, return

        # else

        # push ra to stack
        addi sp, sp, -4
        sw ra, 0(sp)

        # push root to stack
        addi sp, sp, -4
        sw a0, 0(sp)

        # a0 = root.right_child
        lw a0, 8(a0)
        # a0 = count(root.right_child)
        jal ra, count

        # t0 = count(root.right_child)
        add t0, zero, a0

        # pop root from stack to a0
        lw a0, 0(sp)
        addi sp, sp, 4

        # a0 = root.left_child
        lw a0, 4(a0)

        # push count(root.right_child) to stack
        addi sp, sp, -4
        sw t0, 0(sp)

        # a0 = count(root.left_child)
        jal ra, count

        # pop count(root.right_child) from stack to t0
        lw t0, 0(sp)
        addi sp, sp, 4

        add a0, a0, t0 # a0 = a0 + t0
        addi a0, a0, 1 # a0 += 1

        # pop ra from stack and return there
        lw ra, 0(sp)
        addi sp, sp, 4
        beq zero, zero, return

    return: jalr zero, 0(ra)

    exit:
        addi a7, zero, 10
        ecall
