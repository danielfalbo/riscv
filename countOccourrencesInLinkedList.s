#
# Given a linked list and an integer x in the data segment,
# this program prints how many times x appears in the list.
#

.data
    head:   .word n1

    n1:     .word 1, n2
    n2:     .word 2, n3
    n3:     .word 1, n4
    n4:     .word 3, n5
    n5:     .word 1, n6
    n6:     .word 1, 0

    x:      .word 1

.text:
    lw a0, head # a0 = reference to first node

    lw a1, x # a1 = value of x
    jal ra, count # a0 = result of count(head, x)

    # print a0
    addi a7, zero, 1
    ecall

    # exit
    addi a7, zero, 10
    ecall

    #
    # count(head, x) {
    #   if head == null:
    #       return 0
    #   else if head.value == x:
    #       return 1 + count(head.next, x)
    #   else:
    #       return count(head.next, x)
    # }
    #
    # head: a0
    # x: a1
    #
    # overrides a0 with the result!
    #
    count:
        # if head == null: return #(0)
        beq a0, zero, return

        lw t0, 0(a0) # t0 = head.value
        # else if head.value != x: return count(head.next, x)
        bne t0, a1, return_count_next

        # else: #(if head.value == x)

        # push ra to sack
        addi sp, sp, -4
        sw ra, 0(sp)

        lw a0, 4(a0) # a0 = head.next
        jal ra, count # a0 = count(head.next, x)
        addi a0, a0, 1 # a0++, "return a0 + 1"

        # pop ra from stack and jump back there
        lw ra, 0(sp)
        addi sp, sp, 4
        beq zero, zero, return

    return: jalr zero, 0(ra)

    return_count_next:
        lw a0, 4(a0) # a0 = head.next

        # push ra to sack
        addi sp, sp, -4
        sw ra, 0(sp)

        jal ra, count # a0 = count(head.next, x)

        # pop ra from stack and jump back there
        lw ra, 0(sp)
        addi sp, sp, 4
        beq zero, zero, return
