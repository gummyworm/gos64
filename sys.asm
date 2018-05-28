scope Sys {

///////////////////////////////////////
scope Cursor {
	constant X(0)
	constant Y(4)
	constant Gfx(8)

// set the cursor position to (t0,t1)
Set:
	la a0,Dat
	sw t0,X(a0)
	sw t1,Y(a0)
	jr ra
	nop

// move the cursor by (t0,t1) pixels
Move:
	la a0,Dat
	lw t2,X(a0)
	add t2,t2,t0
	sw t2,X(a0)

	lw t2,Y(a0)
	add t2,t2,t1
	sw t2,Y(a0)
	jr ra
	nop

Dat:
	dw 0,0
insert "cur.bin"
}
}
