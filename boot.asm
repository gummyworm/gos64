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
  ScreenNTSC(320, 240, BPP32, $A0100000) // Screen NTSC: 320x240, 32BPP, DRAM Origin $A0100000

  lui a0,$A010 // A0 = VRAM Start Offset
  la a1,$A0100000+(320*240*4)-4 // A1 = VRAM End Offset
  li t0,$000000FF
ClearScreen:
  sw t0,0(a0)
  bne a0,a1,ClearScreen
  addi a0,4 // VRAM += 4

  la a3,$A0100000+(120*320*4)+(160*4) // A3 = Pixel Position
  
  InitController(PIF1) // Initialize Controller

Loop:
  WaitScanline($1E0) // Wait For Scanline To Reach Vertical Blank

  ReadController(PIF2) // T0 = Controller Buttons, T1 = Analog X, T2 = Analog Y

  la a0,BobTab.x
  lw t2,0(a0)
  la a1,BobTab.y
  lw t3,0(a1)

  andi t4,t0,JOY_UP // Test JOY UP
  beqz t4,Down
  nop // Delay Slot
  subi t3,t3,1

Down:
  andi t4,t0,JOY_DOWN // Test JOY DOWN
  beqz t4,Left
  nop // Delay Slot
  addi t3,t3,1

Left:
  andi t4,t0,JOY_LEFT // Test JOY LEFT
  beqz t4,Right
  nop // Delay Slot
  subi t2,t2,1

Right:
  andi t4,t0,JOY_RIGHT // Test JOY RIGHT
  beqz t4,Render
  nop // Delay Slot
  addi t2,t2,1

Render:
  sw t2,0(a0)
  sw t3,0(a1)
  move t0,t2
  move t1,t3
  li t2,8
  li t3,8
  la a1,testsprite
  jal Bob.Blit
  nop

  la a0,testwin
  jal Win.Draw
  nop

  j Loop
  nop // Delay Slot

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

include "bob.asm"
include "win.asm"
