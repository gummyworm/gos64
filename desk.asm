///////////////////////////////////////
// Desk.asm
// Desk is the graphical shell that the user uses to interact with the OS.
///////////////////////////////////////
scope Desk {
constant SELECTION_COLOR(0xff00ffff)

//struct Icon
scope Icon {
	constant X(0)
	constant Y(4)
	constant Gfx(8)

	constant W(32)
	constant H(32)
}

// checks if any programs should be opened/closed
Select:
scope Select {
	addi sp,sp,-4
	sw ra,0(sp)

buttons:
	// draw icons with "magic" colors
	la a0,Vars.Shell.Windows
l0:
	lw a1,Vars.Shell.Icons(a0)
	li t2,Icon.W
	li t3,Icon.H
	li t4,SELECTION_COLOR
	jal Draw.Rect

	// read the pixel at the cursor position
	la t0,Vars.Cursor
	lw a0,Vars.Cursor.X(t0)
	lw a1,Vars.Cursor.Y(t0)
	jal Draw.ReadPixel
	nop
	bne a0,r0,done
	nop
select:

done:
	lw ra,0(sp)
	addi sp,sp,4
	jr ra
	nop
}

// checks if any programs should be opened/closed
Update:
scope Update {
	addi sp,sp,-4
	sw ra,0(sp)

cursor:
	jal Sys.Cursor.Update
	nop

click:
	la a0,Vars.Dev
	lw t0,Vars.Dev.BUTTONS(a0)
	andi t1,t0,JOY_A
	beqz t1,done
	nop

done:
	lw ra,0(sp)
	addi sp,sp,4
	jr ra
	nop
}

// draw the menu bar and desktop icons
Draw:
scope Draw {
	addi sp,sp,-4
	sw ra,0(sp)

	li a0,0xff1234f1f
	jal Draw.Clear
	nop

	// draw the wallpaper

	move t0,r0
	move t1,r0
	li t2,320
	li t3,240
	la a1,wallpaper
	jal Bob.Blit
	nop

	// TODO: draw windows

	jal Draw.Cursor
	nop
done:
	lw ra,0(sp)
	addi sp,sp,4
	jr ra
	nop
}

wallpaper:
insert "wallpaper.bin"
}
