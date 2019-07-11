//Zelda Expansion Disk
//By LuigiBlood

//Uses ARM9 bass

//Macros

macro seek(n) {
	origin {n}
}

macro seekDisk(n) {
	//Seek from LBA 1
	origin ({n} + 0x785C8)
}

define KSEG1(0xA0000000)

define CZLJ_DiskLoad(0x00)
define CZLJ_osSendMesg(0x50)
define CZLJ_osJamMesg(0x54)
define CZLJ_osWritebackDCache(0x70)
define CZLJ_SaveContext(0x88)
define CZLJ_DMARomToRamMesg(0x8C)
define CZLJ_DMARomToRam(0x90)
define CZLJ_SegmentList(0x9C)

macro n64dd_LoadAddress(register, offset) {
	//800FEE70 - NTSC 1.0
	li {register}, (DDHOOK_ADDRTABLE)
	lw {register},0({register})
	lw {register},{offset}({register})
}

macro n64dd_DiskLoad(dest, source, size) {
	//801C7C1C - NTSC 1.0
	li a0,{dest}
	li a1,{source}
	li a2,{size}
	n64dd_LoadAddress(v0, {CZLJ_DiskLoad})
	jalr v0
	nop
}

macro n64dd_RomLoad(dest, source, size) {
	//801C7C1C - NTSC 1.0
	li a0,{dest}
	li a1,{source}
	li a2,{size}
	n64dd_LoadAddress(v0, {CZLJ_DMARomToRam})
	jalr v0
	nop
}

macro n64dd_CallRomLoad() {
	//801C7C1C - NTSC 1.0
	n64dd_LoadAddress(v0, {CZLJ_DMARomToRam})
	jalr v0
	nop
}

macro n64dd_ForceRomEnable() {
	addiu v0,0,1
	li a0,DDHOOK_FORCEROM
	sw v0,0(a0)
}

macro n64dd_ForceRomDisable() {
	li a0,DDHOOK_FORCEROM
	sw 0,0(a0)
}

macro n64dd_CallRamCopy() {
	li v0,ddhook_ramcopy
	jalr v0
	nop
}

macro n64dd_CallRamCopyFast() {
	li v0,ddhook_ramcopyfast
	jalr v0
	nop
}

macro n64dd_RamFill(dest, fillbyte, size) {
	li a0,{dest}
	ori a1,{fillbyte}
	li a2,{size}

	li v0,ddhook_ramfill
	jalr v0
	nop
}

macro n64dd_CallRamFill() {
	li v0,ddhook_ramfill
	jalr v0
	nop
}

macro n64dd_CallApplyPatch() {
	li v0,ddhook_applypatch
	jalr v0
	nop
}

global define EZLJ_SCENELIST_COUNT(0)
macro n64dd_SceneEntry(name, scenestart, titlestart, unk0, renderinit, dd) {
	dw ({scenestart}), ({scenestart} + {scenestart}.size)
	if {titlestart} != 0 {
		dw (DDHOOK_SCENETITLECARD), (DDHOOK_SCENETITLECARD + {titlestart}.size)
	} else {
		dw 0,0
	}
	db ({unk0}), ({renderinit}), ({dd}), 0x00

	//Extra Info (Offset 0x18)
	if {titlestart} != 0 {
		dw ({titlestart}), ({titlestart}.size)
	} else {
		dw 0,0
	}

	global evaluate EZLJ_SCENELIST_COUNT({EZLJ_SCENELIST_COUNT} + 1)
}

macro n64dd_RoomEntry(roomstart) {
	dw ({roomstart}), ({roomstart} + {roomstart}.size)
}

macro n64dd_FileEntry(vfile, vrom, size, load) {
	dw ({vfile}), ({vfile}+{size})
	dw ({vrom})
	dw ({load})
}

global define n64dd_RamAddress(0x80400000)
macro n64dd_RamSetAddress(addr) {
	global evaluate n64dd_RamAddress({addr})
}

macro n64dd_RamDefine(label, size) {
	global variable {label}({n64dd_RamAddress})
	scope {label} {
		global variable size({size})
		global variable end({n64dd_RamAddress}+{size})
		global variable shi( ({n64dd_RamAddress} + (({n64dd_RamAddress} & 0x8000) * 2) >> 16) )
		global variable slo( {n64dd_RamAddress} & 0xFFFF )
		global variable ehi( (({n64dd_RamAddress}+{size}) + ((({n64dd_RamAddress}+{size}) & 0x8000) * 2) >> 16) )
		global variable elo( ({n64dd_RamAddress}+{size}) & 0xFFFF )
	}
	global evaluate n64dd_RamAddress({n64dd_RamAddress}+{size})
	if ({n64dd_RamAddress} > 0x80800000) {
		error "RamDefine goes over the RAM limit."
	}
}

macro n64dd_RamAddressDefine(label, addr) {
	global variable {label}({addr})
}

macro n64dd_RamAddressErrorCheck(addr) {
	if ({n64dd_RamAddress} > {addr}) {
		error "RamDefine goes over the RAM limit."
	}
}