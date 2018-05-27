scope Dev {
// Poll input devices and set state related to them
PollInput:
	addi sp,sp,-4
	sw ra,0(sp)

	ReadController(PIF2) // T0 = Controller Buttons, T1 = Analog X, T2 = Analog Y
	la a0,Buttons
	sw t0,0(a0)
	
	lw ra,0(sp)
	addi sp,sp,4
	jr ra
	nop

///////////////////////////////////////
Buttons:
	dw 0
Keys:
	fill $100
}

///////////////////////////////////////
align(8) // Align 64-Bit
PIF1:
  dw $FF010401,0
  dw 0,0
  dw 0,0
  dw 0,0
  dw $FE000000,0
  dw 0,0
  dw 0,0
  dw 0,1

PIF_RANDNET:
  dw $FF010401,0
  dw 0,0
  dw 0,0
  dw 0,0
  dw $FE000000,0
  dw 0,0
  dw 0,0
  dw 0,1

PIF2:
  fill 64 // Generate 64 Bytes Containing $00

