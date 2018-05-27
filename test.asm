Test:
	addi sp,sp,-4
	sw ra,0(sp)
	la a0,BobTab.x
	lw t2,0(a0)
	la a1,BobTab.y
	lw t3,0(a1)

	andi t4,t0,JOY_UP // Test JOY UP
	beqz t4,Down
	nop // Delay Slot
	subi t3,t3,1

Down:
	andi t4,t0,JOY_DOWN // Test JOY DOWN
	beqz t4,Left
	nop // Delay Slot
	addi t3,t3,1

Left:
	andi t4,t0,JOY_LEFT // Test JOY LEFT
	beqz t4,Right
	nop // Delay Slot
	subi t2,t2,1

Right:
	andi t4,t0,JOY_RIGHT // Test JOY RIGHT
	beqz t4,Render
	nop // Delay Slot
	addi t2,t2,1

Render:
	sw t2,0(a0)
	sw t3,0(a1)
	move t0,t2
	move t1,t3
	li t2,8
	li t3,8
	la a1,testsprite
	jal Bob.Blit
	nop

	la a0,testwin
	jal Win.Draw
	nop

	lw ra,0(sp)
	addi sp,sp,4
	jr ra
	nop
