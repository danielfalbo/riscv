#
# This program reads a list from the data frame
# and stores its reverse after the end of the original list.
# After the procedure, prints what's in memory.
#

.data
    .word 6 # array length, 0x10010000
    .word 5
    .word 6
    .word 7
    .word 8
    .word 12
    .word 24

.text
    # fp = address of beginning of original array (address of its length)
    lui fp, 0x10010

    # t1 = array length
    lw t1, 0(fp)

    # t2 = 0x04, word size
    # t3 = word size * array length, array size in memory
    li t2, 0x04
    mul t3, t2, t1

    # fp = fp + array size, address of last item of original array
    add fp, fp, t3

    # t4 = last original item address + 0x04, address of start of new array
    addi t4, fp, 0x04

    # store at t4, beginning of new array, the length of the array
    sw t1, 0(t4)

    # t4 = address of beginning of new array + default word size,
    # address of first item of new array
    addi t4, t4, 0x04

    # start store next item loop,
    # then start print list loop,
    # and exit gracefully
    beq zero, zero, storeNextItemOrPrintNewListAndExitLoop

    storeNextItemOrPrintNewListAndExitLoop:
        # if t1 == 0, prepare pointers then start "print next item or exit" loop
        beq t1, zero, preparePointersThenStartPrintNextItemOrExitLoop
        # else, store next item and update pointers and counters

        # t2 = value of item at frame pointer, current item of original array
        lw t2, 0(fp)

        # store t2, value of current original item,
        # at t4, current new item address
        sw t2, 0(t4)

        # t4 = address of current new item + 0x04, address of next new item
        addi t4, t4, 0x04

        # fp = address of current original item of original array - 0x04,
        # address of previous original item
        addi fp, fp, -0x04

        # t1 = t1 - 1, count of items left
        addi t1, t1, -1

        # loop
        beq zero, zero, storeNextItemOrPrintNewListAndExitLoop

    preparePointersThenStartPrintNextItemOrExitLoop:
        # t1 = value at fp (address of beginning of original array), array length
        lw t1, 0(fp)

        # t2 = 2
        # t1 = array length * 2
        # t1 = t1 + 2, total number of words to print:
        # double length of array + 2 for the length word of each of the 2 arrays
        li t2, 2
        mul t1, t1, t2
        addi t1, t1, 2

        # start loop
        beq zero, zero, printNextItemOrExitLoop

    printNextItemOrExitLoop:
        # if t1 == 0, exitGracefully
        beq t1, zero, exitGracefully
        # else, print next item and update pointers and counters

        # load integer at frame pointer onto a0
        lw a0, 0(fp)

        # tell os to "print integer" at a0
        li a7, 1
        ecall

        # load code for char "\n" onto a0
        li a0, 10
        # call os with instruction code 11, "print character"
        li a7, 11
        ecall

        # advance frame pointer
        addi fp, fp, 0x04

        # decrease t1
        addi t1, t1, -1

        # loop again
        beq, zero, zero, printNextItemOrExitLoop

    exitGracefully:
        li a7, 10
        ecall
