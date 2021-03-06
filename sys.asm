scope Sys {

///////////////////////////////////////
Init:
scope Init {
	jr ra
	nop
}

///////////////////////////////////////
Update:
scope Update {
	addi sp,sp,-4
	sw ra,0(sp)

	// update input
	jal Dev.PollInput
	nop

	lw ra,0(sp)
	addi sp,sp,4
	jr ra
	nop
}

///////////////////////////////////////
scope Cursor {
// set the cursor position to (t0,t1)
Set:
	la a0,Vars.Cursor
	sw t0,Vars.Cursor.X(a0)
	sw t1,Vars.Cursor.Y(a0)
	jr ra
	nop

Get:
	la a0,Vars.Cursor
	lw t0,Vars.Cursor.X(a0)
	lw t1,Vars.Cursor.X(a0)
	jr ra
	nop

///////////////////////////////////////
// move the cursor by (t0,t1) pixels
Move:
	la a0,Vars.Cursor

	lw t2,Vars.Cursor.X(a0)
	add t2,t2,t0
	sw t2,Vars.Cursor.X(a0)

	lw t2,Vars.Cursor.Y(a0)
	add t2,t2,t1
	sw t2,Vars.Cursor.Y(a0)
	jr ra
	nop

///////////////////////////////////////
Update:
scope Update {
	addi sp,sp,-4
	sw ra,0(sp)

	la a0,Vars.Dev
	lw t0,Vars.Dev.BUTTONS(a0)

	lw t2,Vars.Cursor.XAccel(a0)
	lw t3,Vars.Cursor.YAccel(a0)
	move t5,t2
	move t6,t3

	andi t4,t0,JOY_UP // Test JOY UP
	beqz t4,down
	nop // Delay Slot
	subi t3,t3,1

down:
	andi t4,t0,JOY_DOWN // Test JOY DOWN
	beqz t4,left
	nop // Delay Slot
	addi t3,t3,1

left:
	andi t4,t0,JOY_LEFT // Test JOY LEFT
	beqz t4,right
	nop // Delay Slot
	subi t2,t2,1

right:
	andi t4,t0,JOY_RIGHT // Test JOY RIGHT
	beqz t4,done
	nop // Delay Slot
	addi t2,t2,1

done:
	bne t5,t2,accelX
	nop
	move t2,r0
accelX:
	sw t2,Vars.Cursor.XAccel(a0)
	bne t6,t3,accelY
	nop
	move t3,r0
accelY:
	sw t3,Vars.Cursor.YAccel(a0)

	move t0,t2
	move t1,t3
	jal Move
	nop

	lw ra,0(sp)
	addi sp,sp,4
	jr ra
	nop
}
}
}
