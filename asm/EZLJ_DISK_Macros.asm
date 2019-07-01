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
define CZLJ_StaticContext(0x08)
define CZLJ_osSendMesg(0x50)
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
	li a1,({source} + 0x40000000)	//Force ROM load
	li a2,{size}
	n64dd_LoadAddress(v0, {CZLJ_DMARomToRam})
	jalr v0
	nop
}

macro n64dd_CallRamCopy() {
	li v0,ddhook_ramcopy
	jalr v0
	nop
}

variable ddhook_sceneentry_count(0)
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

	evaluate ddhook_sceneentry_count(ddhook_sceneentry_count + 1)
}

macro n64dd_RoomEntry(roomstart) {
	dw ({roomstart}), ({roomstart} + {roomstart}.size)
}

macro n64dd_FileEntry(vfilename, vfile, file) {
	global variable {vfilename}({vfile})
	scope {vfilename} {
		variable size({vfile} + {file}.size)
	}
	dw ({vfilename}), ({vfilename}.size)
	dw ({file}), ({file}.size)
}
