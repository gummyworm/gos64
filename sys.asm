scope Sys {

///////////////////////////////////////
Init:
scope Init {
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
}
}
