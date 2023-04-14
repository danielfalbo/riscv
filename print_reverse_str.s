.data
    # str: .asciz "acsai"
    # str: .asciz ""
    # str: .asciz " - _ - "
    # str: .asciz "  "
    # str: .asciz "00000"
    str: .asciz "z"
    # str: .asciz "è"
    # str: .asciz "🤪"

.text
    la s0, str

    go_to_end_loop:
        lb a0, 0(s0)
        beq a0, zero, print
        addi s0, s0, 1
        beq zero, zero, go_to_end_loop

    print:
        la t0, str
        sub t0, t0, s0
        addi s0, s0, -1
        li a7, 11
        beq zero, zero, print_loop

    print_loop:
        beq t0, zero, exit
        lb a0, 0(s0)
        ecall
        addi s0, s0, -1
        addi t0, t0, -1
        beq zero, zero, print_loop

    exit:
        li a7, 10
        ecall
