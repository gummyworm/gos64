scope Desk {

// checks if any programs should be opened/closed
Update:
scope Update {

}

// draw the menu bar and desktop icons
Draw:
scope Draw {
	addi sp,sp,-4
	sw ra,0(sp)

	// draw the wallpaper
	move t0,r0
	move t1,r0
	li t2,320
	li t3,240
	la a1,wallpaper
	jal Bob.Blit
	nop

	lw ra,0(sp)
	addi sp,sp,4
	jr ra
	nop
}

wallpaper:
insert "wallpaper.bin"
}
