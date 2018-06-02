scope Dev {
// Poll input devices and set state related to them
PollInput:
	ReadController(PIF2) // T0 = Controller Buttons, T1 = Analog X, T2 = Analog Y
	la a0,Vars.Dev
	sw t0,Vars.Dev.BUTTONS(a0)
	jr ra
	nop
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

PIF2:
  fill 64 // Generate 64 Bytes Containing $00

PIF_RANDNET:
  dw $FF010401,0
  dw 0,0
  dw 0,0
  dw 0,0
  dw $FE000000,0
  dw 0,0
  dw 0,0
  dw 0,1


