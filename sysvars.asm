constant VARSTART(RDRAM<<16)

scope Vars {
Init:
scope Init {
	la a0,variables
	la a1,inittab
	la a2,initend

l0:
	lw t0,0(a1)
	addi a1,a1,4
	sw t0,0(a0)
	bne a1,a2,l0
	addi a0,a0,4
	jr ra
	nop
}

///////////////////////////////////////
inittab:
pushvar base
base VARSTART
align(4)
variables:
Cursor:
scope Cursor {
constant X(0)
constant Y(4)
constant Accel(8)
constant Gfx(12)
	dw 10	// X
	dw 20	// Y
	dw 1    // Accel
	dw cursorsprite // Gfx
}
Dev:
scope Dev {
constant BUTTONS(0)
	dw 0
}
pullvar base
initend:

///////////////////////////////////////
cursorsprite:
	insert "cur.bin"

}
