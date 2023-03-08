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
    beq t0, zero, printAndExit

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
    #   if a0 < t1: updateMaxAndAnalyzeNext
    #   otherwise: analyzeNext
    loadNextAndEventuallyUpdateMaxAndRepeat:
        beq t0, zero, printAndExit
        lw t1, 0(s0)
        blt a0, t1, updateMaxAndAnalyzeNext
        beq zero, zero, analyzeNext

    # a0 <- t1
    updateMaxAndAnalyzeNext:
        add a0, zero, t1
        beq zero, zero, analyzeNext

    #   increment s0 to point at next array element
    #   decrement t0
    analyzeNext:
        addi s0, s0, 0x04
        addi t0, t0, -1
        beq zero, zero, loadNextAndEventuallyUpdateMaxAndRepeat

    printAndExit:
        # print integer at a0
        addi a7, zero, 1
        ecall

        # exit gracefully
        ori a7, zero, 10
        ecall
