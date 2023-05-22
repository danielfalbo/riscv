#
# hw2.s
# Created by Daniel Falbo on 2023-05-22
#
# Given a (general, not binary) tree in the data segment,
# this program finds the subtree with maximal sum
# (the subtree such that the sum of all the items in it
# is maximal in the tree) using a recursive function,
# and then prints the value of the maximal sum.
#
#   max_subtree_sum(root) {
#     t1 = max_subtree_sum(root.r)
#     t2 = max_subtree_sum(root.l)
#     t3 = sum(root)
#     return max(t1, max(t2, t3))
#   }
#

.data
    # root: .word -5, n01, n02
    # n01: .word 24, 0, 0
    # n02: .word 49, 0, 0

    # root: .word -199, n01, n02
    # n01: .word 24, 0, 0
    # n02: .word 49, 0, 0

    # root: .word 6, n02, 0
    # n02: .word -2, 0, n03
    # n03: .word 1, n04, n05
    # n04: .word 1, 0, 0
    # n05: .word 5, 0, n06
    # n06: .word 8, n07, 0
    # n07: .word 11, n08, 0
    # n08: .word -1, 0, 0

    root: .word 0, n02, 0
    n02: .word -2, 0, n03
    n03: .word 1, n04, n05
    n04: .word 1, 0, 0
    n05: .word 5, 0, n06
    n06: .word 8, n07, 0
    n07: .word 11, n08, 0
    n08: .word -1, 0, 0


.text
    la a0, root
    jal ra, max_subtree_sum
    jal ra, print_integer
    beq zero, zero, exit

    max_subtree_sum:
        # if a0 == 0, just return (0)
        beq, a0, zero, return

        # else

        # push return address to stack
        addi sp, sp, -4
        sw ra, 0(sp)
        # push a0 (root) to stack
        addi sp, sp, -4
        sw a0, 0(sp)

        # a0 = root.r
        lw a0, 8(a0)
        # t1 = a0 = max_subtree_sum(root.r)
        jal ra, max_subtree_sum
        add t1, zero, a0

        # read root from stack (without popping it)
        # and put it in a0
        lw a0, 0(sp)

        # a0 = root.l
        lw a0, 4(a0)
        # push t1 to stack
        addi sp, sp, -4
        sw t1, 0(sp)
        # t2 = a0 = max_subtree_sum(root.l)
        jal ra, max_subtree_sum
        add t2, zero, a0
        # pop max_subtree_sum(root.r) from stack and put it in t1
        lw t1, 0(sp)
        addi sp, sp, 4

        # pop root from stack and put it in a0
        lw a0, 0(sp)
        addi sp, sp, 4

        # t3 = a0 = sum(root)
        jal ra, sum
        add t3, zero, a0

        # return max(t1, max(t2, t3))

        # t2 = max(t2, t3)
        jal ra, set_t2_to_max_between_t2_and_t3

        # t3 = t1
        add t3, zero, t1
        # a0 = t2 = max(t2, t3)
        jal ra, set_t2_to_max_between_t2_and_t3
        add a0, zero, t2

        # pop ra from stack and return
        lw ra, 0(sp)
        addi sp, sp, 4
        beq zero, zero, return

    set_t2_to_max_between_t2_and_t3:
        bgt t3, t2, set_t2_to_t3
        beq zero, zero, return

    set_t2_to_t3:
        add t2, zero, t3
        beq zero, zero, return

    sum:
        # if a0 == 0, just return (0)
        beq, a0, zero, return

        # else

        # push return address to stack
        addi sp, sp, -4
        sw ra, 0(sp)
        # push a0 (root) to stack
        addi sp, sp, -4
        sw a0, 0(sp)

        # a0 = root.r
        lw a0, 8(a0)
        # t0 = a0 = sum(root.r)
        jal ra, sum
        add t0, zero, a0

        # read root from stack (without popping it)
        # and put it in a0
        lw a0, 0(sp)

        # a0 = root.l
        lw a0, 4(a0)
        # push t0 to stack
        addi sp, sp, -4
        sw t0, 0(sp)
        # a0 = sum(root.l)
        jal ra, sum
        # pop right child sum from stack and put it back in t0
        lw t0, 0(sp)
        addi sp, sp, 4

        # a0 = a0 + t0
        add a0, a0, t0
        # pop root address from stack and put it in t0
        lw t0, 0(sp)
        addi sp, sp, 4

        # t0 = root.value
        lw t0, 0(t0)
        # a0 = a0 + t0
        add a0, a0, t0

        # pop ra from stack and return
        lw ra, 0(sp)
        addi sp, sp, 4
        beq zero, zero, return

    print_integer:
        li a7, 1
        ecall
        beq zero, zero, return

    return: jalr zero, 0(ra)

    exit:
        li a7, 10
        ecall
