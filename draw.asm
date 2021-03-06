scope Draw {
// draw a rect colored t4 @ (t0,t1). the width/height are given in (t2,t3)
Rect:
scope Rect {
constant dst(a0)
constant rowstart(t6)
constant rowstop(t5)
constant x(t0)
constant y(t1)
constant w(t2)
constant h(t3)
	addi sp,sp,-4
	sw ra,0(sp)

	sll t5,x,2
	sll w,2
	li t6,Screen.w*Screen.bpp
	multu t1,t6
	mflo t6
	add t5,t5,t6

	li rowstart,Screen.addr
	add rowstart,rowstart,t5
	add rowstop,rowstart,w
l0:
	move dst,rowstart
l1:
	sw t4,0(dst)
	addi dst,dst,Screen.bpp
	bne dst,rowstop,l1
	nop
	addi rowstop,Screen.w*Screen.bpp
	addi rowstart,Screen.w*Screen.bpp
	subi h,h,1
	bnez h,l0
	nop

	lw ra,0(sp)
	addi sp,sp,4
	jr ra
	nop
}

// Text renders the text in (a0) to (t0,t1)
Text:
scope Text {
constant ch(t7)
constant x(t8)
constant y(t9)
constant src(a2)
	addi sp,sp,-4
	sw ra,0(sp)

	move src,a0
	move x,t0
	move y,t1
l0:
	lb ch,0(src)
	beq ch,r0,done
	addi src,src,1
	sll ch,8	//*256
	la a1,Font8x8
	add a1,a1,ch
	li t2,8
	li t3,8
	jal Bob.Blit
	move t1,y
	j l0
	addi t0,t0,8
done:
	lw ra,0(sp)
	addi sp,sp,4
	jr ra
	nop
}

// Cursor renders the mouse cursor
Cursor:
scope Cursor {
	addi sp,sp,-4
	sw ra,0(sp)

	la a0,Vars.Cursor
	lw t0,Vars.Cursor.X(a0)
	lw t1,Vars.Cursor.Y(a0)
	lw a1,Vars.Cursor.Gfx(a0)
	li t2,32
	li t3,32
	jal Bob.Blit
	nop

	lw ra,0(sp)
	addi sp,sp,4
	jr ra
	nop
}

// Return the address of the pixel at (a0,a1) in a0.
ReadPixel:
scope ReadPixel {
	sll a0,a0,2
	li t0,Screen.w*Screen.bpp
	multu t0,a1
	mflo t0
	add t0,t0,a0

	jr ra
	nop
}

// Clear the screen to the color in a0
Clear:
scope Clear {
	li a1,Screen.addr
	li a2,Screen.addr+(Screen.bpp*Screen.w*Screen.h)
l0:
	sw a0,0(a1)
	bne a1,a2,l0
	addi a1,Screen.bpp

	jr ra
	nop
}
}
