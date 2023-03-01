#
#
# This program prints the elements of an array at a certain index
#
#

.data
    .word 4 # index, (0x10010000)

    .word 6 # length of arr, (0x10010004)
    .word 3, 5, 11, 12, 21, 27

.text
    # load address of the start of the memory onto s0
    lui s0, 0x10010

    # load onto t0 the value at the address of the index of the item
    # of the array we want to print
    lw t0, 0(s0)

    # load onto s1 the address of the first value of the array
    # by adding 8 to the address of the beginning of the memory
    # (memory begin address + 2 words size)
    addi s1, s0, 8

    # shift t0 to the left 2 times
    # which means to multiply it by 2^2, which is 4
    # useful when we'll want to print the value at the address
    # of the beginning of the array incremented by the number of
    # bytes previous elements take
    # e.g.
    # index = 4, 4 elements take 4 * 4 = 16 bytes,
    # we'll want to print the item at the address of
    # the beginning of the array + 16 bytes
    slli t0, t0, 2

    # increment the address of the beginning of the memory
    # by the number of bytes of the elements we want to ignore
    add s1, s1, t0

    # load the value of the array at the index of interest onto a0
    lw a0, 0(s1)

    # os call with instruction code 1 into a7: to "print integer"
    # will print the integer at a0,
    # which is the value of the item at index of interest
    addi a7, zero, 1
    ecall

    # and exit gracefully
    addi, a7, zero, 10
    ecall

