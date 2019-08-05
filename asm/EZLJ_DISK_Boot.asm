//Zelda 64 Dawn & Dusk - Expansion Disk
//By LuigiBlood

//Uses ARM9 bass

//64DD Standalone Boot Code

print "- Assemble Disk Boot Code...\n"

define IPLLOADSIZE(10)
define IPLLOADADDRESS(0x80000400)

// Code taken from krom FrameBufferCPU16BPP320x240 demo
// https://github.com/PeterLemon/N64/blob/master/FrameBuffer/16BPP/FrameBufferCPU320x240/
seekDisk0(0)
base 0x80000400
ipl_boot:
	N64_INIT()
	ScreenNTSC(320, 240, BPP16, $A0100000) // Screen NTSC: 320x240, 16BPP, DRAM Origin $A0100000

	lui a0,$A010 // A0 = DRAM Start Offset
	li a1,$A0000400+0x9A10 // A1 = Image Start Offset
	li a2,$A0000400+0x9A10+EZLJ_ERROR_IPL.size // A2 = Image End Offset
ipl_DrawImage:
	lw t0,0(a1) // T0 = Next Word From Image
	sync // Sync Load
	sw t0,0(a0) // Store Word To RDRAM
	addi a1,4 // Add 4 To Image Offset
	bne a1,a2,ipl_DrawImage
	addi a0,4 // Add 4 To RDRAM Offset (Delay Slot)

ipl_Loop:
	j ipl_Loop
	nop