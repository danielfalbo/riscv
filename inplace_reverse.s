#
# This program overrides an array in memory with its reverse
# and prints it
#

.data:
    .word 7 # 0x10010000
    .word 8, 5, 1, -1, 4, 0, 99

.text:
    beq zero, zero, push_then_pop_then_print

    push_then_pop_then_print:
        lui t0, 0x10010
        addi t1, t0, 4
        lw t0, 0(t0)
        beq zero, zero, push_loop_then_pop_then_print

    # if t0 == 0:
    #   pop_then_print_list
    # else:
    #   decrement stack pointer by 4
    #   a0 = element at address t1
    #   store a0 at stack pointer address
    #   decrement t0
    #   increment t1 by 4
    push_loop_then_pop_then_print:
        beq t0, zero, pop_then_print_list

        addi sp, sp, -4
        lw a0, 0(t1)
        sw a0, 0(sp)
        addi t0, t0, -1
        addi t1, t1, 4
        beq zero, zero, push_loop_then_pop_then_print

    pop_then_print_list:
        lui t0, 0x10010
        addi t1, t0, 4
        lw t0, 0(t0)
        beq zero, zero, pop_loop_then_print


    # if t0 == 0:
    #   printList
    # else:
    #   pop from stack
    #   increment stack pointer
    #   store stack element at t1 address
    #   increment t1
    #   decrement t0
    pop_loop_then_print:
        beq t0, zero, printList

        lw a0, 0(sp)
        addi sp, sp, 4
        sw a0, 0(t1)
        addi t1, t1, 4
        addi t0, t0, -1
        beq zero, zero, pop_loop_then_print


    printList:
        lui t0, 0x10010
        addi t1, t0, 4
        lw t0, 0(t0)
        beq zero, zero, print_list_loop

    # if t0 == 0:
    #   jump back to main printList procedure
    # else:
    #   print element at address t1
    #   increment t1 to point at next element
    #   decrement t0
    print_list_loop:
        beq t0, zero, exit

        # print 0(t1)
        lw a0, 0(t1)
        addi a7, zero, 1
        ecall
        # print new line
        addi a0, zero, 10
        addi a7, zero, 11
        ecall

        addi t0, t0, -1
        addi t1, t1, 4

        beq zero, zero, print_list_loop

    exit:
        addi a7, zero, 10
        ecall
