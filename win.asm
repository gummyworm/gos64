///////////////////////////////////////
//Widget
//X, Y:     word
//W, H:     word
//color:    word
//children: *Widget[16]

///////////////////////////////////////
//Window struct
//Widget: Widget
//name:   byte[16]

///////////////////////////////////////
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
	li t0,Props.DEFAULT_BG_COLOR
	sw t0,16(a0)
	jr ra
	nop

// draw the window in (a0)
Draw:
	addi sp,sp,-4
	sw ra,0(sp)
	addi sp,sp,-4
	sw a0,0(sp)

	// draw background
	lw t0,0(a0)
	lw t1,4(a0)
	lw t2,8(a0)
	lw t3,12(a0)
	lw t4,16(a0)
	jal Draw.Rect
	nop

	// draw titlebar
	lw a0,0(sp)
	lw t0,0(a0)
	lw t1,4(a0)
	lw t2,8(a0)
	li t3,Props.TITLEBAR_H
	li t4,Props.TITLEBAR_COLOR
	jal Draw.Rect
	nop

	// draw title
	lw a0,0(sp)
	addi sp,sp,4
	lw t0,0(a0)
	lw t1,4(a0)
	addi a0,a0,20
	jal Draw.Text
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

align(8)
testwin:
dw 10,30,100,60,$12341245
db "window",0
align(8)
