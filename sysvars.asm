constant VARSTART(RDRAM<<16)

scope Vars {
Init:
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

inittab:
pushvar base
base VARSTART
variables:
Cursor:
scope Cursor {
constant X(0)
constant Y(4)
constant Gfx(8)
	dw 0,0
	dw cursorsprite
}
pullvar base
initend:

cursorsprite:
	insert "cur.bin"
}
