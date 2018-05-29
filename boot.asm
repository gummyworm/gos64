arch n64.cpu
endian msb
output "gos.N64", create
fill 1052672 // Set ROM Size

///////////////////////////////////////
origin $00000000
base $80000000 // Entry Point Of Code

///////////////////////////////////////
include "screen.inc"
include "lib/macros.inc"
include "lib/N64_GFX.INC"
include "lib/N64_INPUT.INC"
include "lib/N64.INC" // Include N64 Definitions
include "lib/N64_HEADER.ASM" // Include 64 Byte Header & Vector Table
include "properties.inc"

///////////////////////////////////////
insert "lib/N64_BOOTCODE.BIN" // Include 4032 Byte Boot Code

///////////////////////////////////////
Start:
	N64_INIT() // Run N64 Initialisation Routine
	ScreenNTSC(Screen.w, Screen.h, BPP32, Screen.addr) // Screen NTSC: 320x240, 32BPP, DRAM Origin $A0100000
	InitController(PIF1) // Initialize Controller

	jal Sys.Init
	nop
	jal Vars.Init
	nop

Loop:
	WaitScanline($1E0) // Wait For Scanline To Reach Vertical Blank
	lui a0,$A010
	la a1,$A0100000+(320*240*4)-4
	li t0,$aaaaaaFF
	li t1,$ffffffff
ClearScreen:
	xor t0,t0,t1
	sw t0,0(a0)
	bne a0,a1,ClearScreen
	addi a0,Screen.bpp

	jal Dev.PollInput
	nop
	jal Test
	nop
	j Loop
	nop

include "sysvars.asm"
include "bob.asm"
include "draw.asm"
include "device.asm"
include "win.asm"
include "mem.asm"
include "test.asm"
include "sys.asm"
