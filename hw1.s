#
# hw1.s
# Created by Daniel Falbo on 2023-03-22
#
# Given three integers in the data segment,
# this program prints the median.
# (Not the largest, not the smallest, the other one)
#
# median(t0, t1, t2) {
#   a0 = t0 + t1 + t2           # step 1
#   t3 = max(t0, max(t1, t2))   # step 2
#   t4 = min(t0, min(t1, t2))   # step 3
#   return a0 - t3 - t4         # step 4
# }
#

.data
    .word 7
    .word 4
    .word 99

.text
    lui s0, 0x10010

    lw t0, 0(s0)
    lw t1, 4(s0)
    lw t2, 8(s0)

    # step 1
    add a0, t0, t1
    add a0, a0, t2

    # step 2 can be broken down like this:
    # a. t3 = t2
    # b. if t1 > t3: t3 = t1
    # c. if t0 > t3: t3 = t0
    # d. proceed to step 3

    # step 2a
    add t3, t2, zero

    # step 2b:
    # if t1 > t3
    bgt t1, t3, set_t3_to_t1_and_proceed_to_step2c
    # else
    beq zero, zero, step2c

    step2c: # if t0 > t3
            bgt t0, t3, set_t3_to_t0_and_proceed_to_step3
            # else
            beq zero, zero, step3

    # similarly, step 3 can be broken down as:
    # a. t4 = t2
    # b. if t1 < t4: t4 = t1
    # c. if t0 < t4: t4 = t0
    # d. proceed to step 4

    step3:  # step 3a
            add t4, t2, zero

            # step 3b:
            # if t1 < t4
            blt t1, t4, set_t4_to_t1_and_proceed_to_step3c
            # else
            beq zero, zero, step3c

    step3c: # if t0 < t4
            blt t0, t4, set_t4_to_t0_and_proceed_to_step4
            # else
            beq zero, zero, step4

    step4:  sub a0, a0, t3
            sub a0, a0, t4

            addi a7, zero, 1
            ecall

            addi a7, zero, 10
            ecall

    # === boring trivial subroutines ===
    set_t3_to_t1_and_proceed_to_step2c:
        add t3, t1, zero
        beq zero, zero, step2c

    set_t3_to_t0_and_proceed_to_step3:
        add t3, t0, zero
        beq zero, zero, step3

    set_t4_to_t1_and_proceed_to_step3c:
        add t4, t1, zero
        beq zero, zero, step3c

    set_t4_to_t0_and_proceed_to_step4:
        add t4, t0, zero
        beq zero, zero, step4
