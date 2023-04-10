#
# This program overrides an array in memory with its reverse
# and prints it
#

.data:
    .word 7 # 0x10010000
    .word 8, 5, 1, -1, 4, 0, 99

.text:
	beq zero, zero, pushThenPopThenPrint

	pushThenPopThenPrint:
		lui t0, 0x10010
		addi t1, t0, 4
		lw t0, 0(t0)
		beq zero, zero, pushLoopThenPopThenPrint

	# if t0 == 0:
	# 	popThenPrintList
	# else:
	# 	decrement stack pointer by 4
	# 	a0 = element at address t1
	# 	store a0 at stack pointer address
	# 	decrement t0
	# 	increment t1 by 4
	pushLoopThenPopThenPrint:
		beq t0, zero, popThenPrintList
		
		addi sp, sp, -4
		lw a0, 0(t1)
		sw a0, 0(sp)
		addi t0, t0, -1
		addi t1, t1, 4
		beq zero, zero, pushLoopThenPopThenPrint

	popThenPrintList:
		lui t0, 0x10010
		addi t1, t0, 4
		lw t0, 0(t0)
		beq zero, zero, popLoopThenPrint


	# if t0 == 0:
	# 	printList
	# else:
	# 	pop from stack
	# 	increment stack pointer
	# 	store stack element at t1 address
	# 	increment t1
	# 	decrement t0
	popLoopThenPrint:
		beq t0, zero, printList
		
		lw a0, 0(sp)
		addi sp, sp, 4
		sw a0, 0(t1)
		addi t1, t1, 4
		addi t0, t0, -1
		beq zero, zero, popLoopThenPrint


    printList:
    	lui t0, 0x10010
    	addi t1, t0, 4
    	lw t0, 0(t0)
    	beq zero, zero, printListLoop

    # if t0 == 0:
    #   jump back to main printList procedure
    # else:
    #   print element at address t1
    #   increment t1 to point at next element
    #   decrement t0
    printListLoop:
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
        
        beq zero, zero, printListLoop
        
    exit:
    	addi a7, zero, 10
    	ecall