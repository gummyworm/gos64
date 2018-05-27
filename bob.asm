scope BobTab {
x:
fill 64*4
y:
fill 64*4
}

scope Bob {
// Blit renders the BOB in a1 at (t0,t1) the dimensions are given in (t2,t3)
Blit:
scope Blit {
constant src(a1)
constant dst(a0)
constant rowstart(t4)
constant rowstop(t5)
constant x(t0)
constant y(t1)
constant w(t2)
constant h(t3)
	addi sp,sp,-4
	sw ra,0(sp)

	sll t5,x,2
	sll w,2
	li t4,Screen.w*Screen.bpp
	multu t1,t4
	mflo t4
	add t5,t5,t4

	la rowstart,Screen.addr
	add rowstart,rowstart,t5
	add rowstop,rowstart,w
l0:
	move dst,rowstart
l1:	
	lw t2,0(src)
	addi src,src,Screen.bpp
	sw t2,0(dst)
	addi dst,dst,Screen.bpp
	bne dst,rowstop,l1
	nop
	addi rowstop,Screen.w*Screen.bpp
	addi rowstart,Screen.w*Screen.bpp
	subi h,h,1
	bne h,r0,l0
	nop

	lw ra,0(sp)
	addi sp,sp,4
	jr ra
	nop
}
}

///////////////////////////////////////
align(8)
testsprite:
dw $ffffffff,$ffffffff,$fffffff,$ffffffff
dw $ffffffff,$ffffffff,$fffffff,$ffffffff
dw $ffffffff,$ffffffff,$fffffff,$ffffffff
dw $ffffffff,$ffffffff,$fffffff,$ffffffff
dw $ffffffff,$ffffffff,$fffffff,$ffffffff
dw $ffffffff,$ffffffff,$fffffff,$ffffffff
dw $ffffffff,$ffffffff,$fffffff,$ffffffff
dw $ffffffff,$ffffffff,$fffffff,$ffffffff
dw $ffffffff,$ffffffff,$fffffff,$ffffffff
align(4)
testtext: 
db "hello world",0

///////////////////////////////////////
align(4)
insert Font8x8, "FontBlack8x8.bin"
