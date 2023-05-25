# hw2.s
# Created by Daniel Falbo on 2023-05-22
#
# Given a general tree (not a binary tree, a k-ary tree)
# in the data segment, this program finds the subtree with
# maximal sum (the subtree such that the sum of all the items
# in it is maximal in the tree) using a recursive function,
# and then prints the value of the maximal sum.
#
# Node(value, first_child, first_sibling)
#
# max_subtree_sum(root):
#   if root is null:
#       return 0
#   else if no child:
#       return max(0, root.value)
#   else:
#       a = tree_sum(root)
#       b = max_siblings_trees_sums(root.first_child)
#       return max(a, b)
#
# max_siblings_trees_sums(first_child):
#   if first_child is null:
#       return 0
#   else:
#       a = tree_sum(first_child)
#       b = max_siblings_trees_sums(first_child.first_sibling)
#       return max(a, b)
#
# tree_sum(root):
#   if root is null:
#       return 0
#   else:
#       a = root.value
#       b = siblings_trees_sums(root.first_child)
#       return a + b
#
# siblings_trees_sums(first_child):
#   if first_child is null:
#       return 0
#   else:
#       a = tree_sum(first_child)
#       b = siblings_trees_sums(first_child.first_sibling)
#       return a + b
#

.data
    # node: .word value, child, sibling

    # root:   .word 6, n02, 0
    # n02:    .word -2, 0, n03
    # n03:    .word 1, n05, n04
    # n04:    .word 1, 0, 0
    # n05:    .word 5, 0, n06
    # n06:    .word 8, 0, n07
    # n07:    .word 11, 0, n08
    # n08:    .word -1, 0, 0
    # # should give 29

    # root:    .word -5, n02, 0
    # n02:    .word 7, 0, n03
    # n03:    .word 14, n05, n04
    # n04:    .word -20, 0, 0
    # n05:    .word 16, 0, n06
    # n06:    .word -9, 0, n07
    # n07:    .word 8, n09, n08
    # n08:    .word 3, 0, 0
    # n09:    .word -4, 0, n10
    # n10:    .word 3, 0, 0
    # # should give 31

    # root: .word 5, n02, 0
    # n02: .word -2, n04, n03
    # n03: .word 8, 0, n07
    # n07: .word -10, 0, 0
    # n04: .word 15, n06, n05
    # n05: .word 6, 0, 0
    # n06: .word 8, 0, 0
    # # should give 30

    root:    .word 6, n02, 0
    n02:    .word -20, nA , n03
    n03:    .word 12, n05, n04
    n04:    .word 1, nX, 0
    n05:    .word 5, 0, n06
    n06:    .word 8, nC, n07
    n07:    .word 11, 0, n08
    n08:    .word -1, 0, 0
    nA:     .word -4, 0, nB
    nB:     .word -17, 0, 0
    nC:     .word -16, 0, nD
    nD:     .word 14, 0, nE
    nE:     .word -3, 0, 0
    nX:     .word 100, nY, 0
    nY:     .word -20, 0, 0
    # should give 81

.text
    la a0, root
    jal ra, max_subtree_sum
    jal ra, print_integer
    beq zero, zero, exit

    max_subtree_sum:
        beq, a0, zero, return

        lw t0, 4(a0) # t0 = a0.first_child
        beq t0, zero, max_between_a0s_value_and_zero

        # push ra
        addi sp, sp, -4
        sw ra, 0(sp)

        # push root
        addi sp, sp, -4
        sw a0, 0(sp)

        jal ra, tree_sum # a0 = tree_sum(a0)

        # pop root
        lw t0, 0(sp)
        addi sp, sp, 4

        # push root tree_sum
        addi sp, sp, -4
        sw a0, 0(sp)

        lw a0, 4(t0) # a0 = root.first_child

        jal ra, max_siblings_trees_sums

        # pop root tree_sum
        lw a1, 0(sp)
        addi sp, sp, 4

        jal ra, max

        # pop ra
        lw ra, 0(sp)
        addi sp, sp 4

        beq zero, zero, return

    max_siblings_trees_sums:
        beq, a0, zero, return

        # push ra
        addi sp, sp, -4
        sw ra, 0(sp)

        # push first_child
        addi sp, sp, -4
        sw a0, 0(sp)

        jal ra, tree_sum # a0 = tree_sum(first_child)

        # pop first_child
        lw t0, 0(sp)
        addi sp, sp, 4

        # push first child tree sum
        addi sp, sp, -4
        sw a0, 0(sp)

        lw a0, 8(t0) # a0 = first_child.first_sibling

        jal ra, max_siblings_trees_sums

        # pop first child tree sum
        lw a1, 0(sp)
        addi sp, sp, 4

        jal ra, max

        # pop ra
        lw ra, 0(sp)
        addi sp, sp, 4

        beq zero, zero, return

    tree_sum:
        beq, a0, zero, return

        # push ra
        addi sp, sp, -4
        sw ra, 0(sp)

        # push root
        addi sp, sp, -4
        sw a0, 0(sp)

        lw a0, 4(a0) # a0 = a0.first_child
        jal ra, siblings_trees_sums # a0 = siblings_trees_sums(a0)

        # pop root
        lw t0, 0(sp)
        addi sp, sp, 4

        lw t0, 0(t0) # t0 = root.value

        add a0, a0, t0

        # pop ra
        lw ra, 0(sp)
        addi sp, sp 4

        beq zero, zero, return

    siblings_trees_sums:
        beq, a0, zero, return

        # push ra
        addi sp, sp, -4
        sw ra, 0(sp)

        # push first_child
        addi sp, sp, -4
        sw a0, 0(sp)

        jal ra, tree_sum # a0 = tree_sum(a0)

        # pop first_child
        lw t0, 0(sp)
        addi sp, sp, 4

        # push first child tree sum
        addi sp, sp, -4
        sw a0, 0(sp)

        lw a0, 8(t0) # a0 = first_child.first_sibling

        jal ra, siblings_trees_sums

        # pop first child tree sum
        lw t0, 0(sp)
        addi sp, sp, 4

        add a0, a0, t0 # a0 = first child tree sum + first child's siblings trees sums

        # pop ra
        lw ra, 0(sp)
        addi sp, sp, 4

        beq zero, zero, return

    max:
        bge a0, a1, return
        add a0, zero, a1
        beq zero, zero, return

    max_between_a0s_value_and_zero:
        lw a0, 0(a0)
        li a1, 0
        beq zero, zero, max

    print_integer:
        li a7, 1
        ecall
        beq zero, zero, return

    return: jalr zero, 0(ra)

    exit:
        li a7, 10
        ecall
