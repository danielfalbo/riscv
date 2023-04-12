#
#
# This program finds and prints the largest integer of an array
#
#

.data
    # .word 0

    .word 6 # length (0x10010000)
    .word 3, -3, 11, 33, 21, 27
    # .word -3, -3, -11, -33, -21, -27

.text
    lui s0, 0x10010

    # load the length of the array onto t0
    lw t0, 0(s0)

    # if length of the array is 0 (there are no elements), exit
    beq t0, zero, print_and_exit

    # increment s0 to point at the first array integer
    addi s0, s0, 0x04

    # load first element of the array onto a0,
    # make s0 point at next element,
    # and decrement t0
    lw a0, 0(s0)
    addi s0, s0, 0x04
    addi t0, t0, -1

    # while t0 != 0 (there are more elements in the array we need to analyse):
    #   load current element onto t1
    #   if a0 < t1: update_max_and_analyze_next
    #   else: analyze_next
    load_next_and_eventually_update_max_and_repeat:
        beq t0, zero, print_and_exit
        lw t1, 0(s0)
        blt a0, t1, update_max_and_analyze_next
        beq zero, zero, analyze_next

    # a0 <- t1
    update_max_and_analyze_next:
        add a0, zero, t1
        beq zero, zero, analyze_next

    #   increment s0 to point at next array element
    #   decrement t0
    analyze_next:
        addi s0, s0, 0x04
        addi t0, t0, -1
        beq zero, zero, load_next_and_eventually_update_max_and_repeat

    print_and_exit:
        # print integer at a0
        addi a7, zero, 1
        ecall

        # exit gracefully
        ori a7, zero, 10
        ecall
