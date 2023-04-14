.data:
    x:  .word 52

    len:  .word 5
    array: .word 13, 2, 66, 2, 8

    found_str: .asciz "Found."
    not_found_str: .asciz "Not found."

.text:
    lui t0, 0x10010
    lw t1, 0(t0) # t1 = x
    lw t2, 4(t0) # t2 = len
    addi t3, t0, 8 # t3 = address of beginning of array
    la a0, found_str

    loop:
        beq t2, zero, not_found

        lw t4, 0(t3)
        beq t1, t4, exit

        addi t2, t2, -1
        addi t3, t3, 4
        beq zero, zero, loop

    not_found:
        la a0, not_found_str
        beq zero, zero, exit

    exit:
        addi a7, zero, 4
        ecall
        addi a7, zero, 10
        ecall
