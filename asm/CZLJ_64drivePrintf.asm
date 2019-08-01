ddhook00_printf_out:
constant ci_dbg_area(0x03F00000)
constant ci_dbgram_area(0x03700000)
constant osCartRomInit(0x80009EA0)
constant osEPiStartDma(0x800040C0)
constant osEPiReadIo(0x80005630)
constant osEPiWriteIo(0x80005800)
	//A0=Dest (unused)
	//A1=Src
	//A2=Size
	addiu sp,sp,-0x50
	sw ra,0x20(sp)
	sw a1,0x1C(sp)

	//align size to 32 bit
    addiu a0,0,4
    andi a3,a2,3
    subu a0,a0,a3
    addu a2,a2,a0
    addiu a2,a2,4
	sw a2,0x18(sp)

	//Get Cart Rom Init and keep it
	li v0,osCartRomInit
	sw v0,0x14(sp)

	//Spin Status
	-; lw a0,0x14(sp)
	li a1,0x08000200
	addiu a2,sp,0x10
	jal osEPiReadIo
	nop
	lw a2,0x10(sp)
	andi a2,a2,0x1000
	bnez a2,-
	nop

	//Enable Cart Write
	lw a0,0x14(sp)
	li a1,0x08000208
	addiu a2,0,0xF0
	jal osEPiWriteIo
	nop

	//Spin Status
	-; lw a0,0x14(sp)
	li a1,0x08000200
	addiu a2,sp,0x10
	jal osEPiReadIo
	nop
	lw a2,0x10(sp)
	andi a2,a2,0x1000
	bnez a2,-
	nop

	//osCreateMesgQueue
	addiu a0,sp,(0x24+0x18+4)
	addiu a1,sp,(0x24+0x18)
	n64dd_LoadAddress(v0, {CZLJ_osCreateMesgQueue})
	jalr v0
	ori a2,0,1

	//DMA to ROM
	lw a0,0x14(sp)		//osCartRomInit
	addiu a1,sp,0x24	//osIoMesg
	ori a2,0,1			//OS_WRITE
	sb a2,0x2(a1)		//hdr.pri (HIGH)
	lw a3,0x1C(sp)
	sw a3,0x8(a1)		//dramAddr
	li a3,ci_dbg_area
	sw a3,0xC(a1)		//devAddr
	lw a3,0x18(sp)
	sw a3,0x10(a1)		//size
	addiu a3,sp,(0x24+0x18+4)
	sw a3,0x4(a1)		//hdr.retQueue
	jal osEPiStartDma
	nop

	//osRecvMesg
	addiu a0,sp,(0x24+0x18+4)
	addiu a1,sp,(0x24+0x18)
	ori a2,0,1
	n64dd_LoadAddress(v0, {CZLJ_osRecvMesg})
	jalr v0
	nop

	//Spin USB Status
	-; lw a0,0x14(sp)
	li a1,0x08000400
	addiu a2,sp,0x10
	jal osEPiReadIo
	nop
	lw a2,0x10(sp)
	bnez a2,-
	nop

	//Put Address in USB Param0
	lw a0,0x14(sp)
	li a1,0x08000404
	li a2,(ci_dbg_area >> 1)
	jal osEPiWriteIo
	nop

	//Put Size + Type in USB Param1
	lw a0,0x14(sp)
	li a1,0x08000408
	lw a2,0x18(sp)
	lui a3,0x0100
	jal osEPiWriteIo
	or a2,a2,a3

	//Put Command
	lw a0,0x14(sp)
	li a1,0x08000400
	jal osEPiWriteIo
	addiu a2,0,0x08
	
	lw ra,0x20(sp)
	jr ra
	addiu sp,sp,0x50

ddhook_printf_copy_out:
	//Copy Data from RAM to where it wants
	//A0 = Dest, A1 = Offset, A2 = Size, A3 = Used for copy
	li a0,ddhook_printf_copy_out_set
	lw a0,0(a0)

	 -; lb a3,0(a1)
	sb a3,0(a0)
	addiu a0,a0,1
	addiu a1,a1,1
	subi a2,a2,1
	bnez a2,-
	nop
	
	li a3,ddhook_printf_copy_out_set
	sw a0,0(a3)
	jr ra
	nop

ddhook_printf_copy_out_set:
	dw 0

ddhook_printf:
    lui t9,0xFFFA
    or t0,sp,0
    addiu sp,sp,0xFFD8
    -; ori t9,t9,0x5A5A
    addiu t0,t0,0xFFF8
    sw t9,0(t0)
    bne t0,sp,-
    sw t9,4(t0)

    sw ra,0x14(sp)
    sw a0,0x28(sp)
    sw a1,0x2C(sp)
    sw a2,0x30(sp)
    sw a3,0x34(sp)
    lw t6,0x28(sp)
    lw t8,0x2C(sp)
    li a0,ddhook00_printf_out
    addiu t7,t6,0xFFF8
    sw t7,0x1C(sp)
    addiu a1,sp,0x1C
    lw a2,0x30(sp)
    addiu a3,sp,0x34
    n64dd_LoadAddress(v0, {CZLJ_Printf})
    jalr v0
    sw t8,0x20(sp)
    lw ra,0x14(sp)
    addiu sp,sp,0x28
    jr ra
    nop

ddhook_copyfullram:
	addiu sp,sp,-0x20
	sw ra,0x20(sp)

	addiu sp,sp,-0x50
	sw ra,0x20(sp)
	sw a1,0x1C(sp)

	//align size to 32 bit
    addiu a0,0,4
    andi a3,a2,3
    subu a0,a0,a3
    addu a2,a2,a0
    addiu a2,a2,4
	sw a2,0x18(sp)

	//Get Cart Rom Init and keep it
	li v0,osCartRomInit
	sw v0,0x14(sp)

	//Spin Status
	-; lw a0,0x14(sp)
	li a1,0x08000200
	addiu a2,sp,0x10
	jal osEPiReadIo
	nop
	lw a2,0x10(sp)
	andi a2,a2,0x1000
	bnez a2,-
	nop

	//Enable Cart Write
	lw a0,0x14(sp)
	li a1,0x08000208
	addiu a2,0,0xF0
	jal osEPiWriteIo
	nop

	//Spin Status
	-; lw a0,0x14(sp)
	li a1,0x08000200
	addiu a2,sp,0x10
	jal osEPiReadIo
	nop
	lw a2,0x10(sp)
	andi a2,a2,0x1000
	bnez a2,-
	nop

	//osCreateMesgQueue
	addiu a0,sp,(0x24+0x18+4)
	addiu a1,sp,(0x24+0x18)
	n64dd_LoadAddress(v0, {CZLJ_osCreateMesgQueue})
	jalr v0
	ori a2,0,1

	//DMA to ROM
	lw a0,0x14(sp)		//osCartRomInit
	addiu a1,sp,0x24	//osIoMesg
	ori a2,0,1			//OS_WRITE
	sb a2,0x2(a1)		//hdr.pri (HIGH)
	sw 0,0x8(a1)		//dramAddr
	li a3,ci_dbgram_area
	sw a3,0xC(a1)		//devAddr
	lui a3,0x0080
	sw a3,0x10(a1)		//size
	addiu a3,sp,(0x24+0x18+4)
	sw a3,0x4(a1)		//hdr.retQueue
	jal osEPiStartDma
	nop

	//osRecvMesg
	addiu a0,sp,(0x24+0x18+4)
	addiu a1,sp,(0x24+0x18)
	ori a2,0,1
	n64dd_LoadAddress(v0, {CZLJ_osRecvMesg})
	jalr v0
	nop

	//Crash Debugger Stuff
	//lui t6,0xA404
	//lw t7,0x0010(t6)

	lw ra,0x20(sp)
	addiu sp,sp,0x20
	jr ra
	nop