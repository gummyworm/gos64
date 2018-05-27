//Widget
//X, Y:  word
//W, H:  word
//color: word

//Textbox struct
//Widget: Widget
//text:   byte[]

scope Win {
// return address to a new window in a0
// position in (t0,t1), size in (t2,t3), address to text in t4
New:
	sw t0,0(a0)
	sw t1,4(a0)
	sw t2,8(a0)
	sw t3,12(a0)
	li t0,DEFAULT_BG_COLOR
	sw t0,16(a0)
	jr ra
	nop

// draw the window in (a0)
Draw:
	addi sp,sp,-4
	sw ra,0(sp)

	lw t0,0(a0)
	lw t1,4(a0)
	lw t2,8(a0)
	lw t3,12(a0)
	lw t4,16(a0)
	jal Draw.Rect
	nop
done:
	lw ra,0(sp)
	addi sp,sp,4
	jr ra
	nop
}

scope TextBox {
New:
	jr ra
}

align(4)
testwin:
dw 10,30,100,60,$aaaaaaaa
