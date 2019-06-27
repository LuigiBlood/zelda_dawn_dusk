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
define CZLJ_osWritebackDCache(0x70)
define CZLJ_SaveContext(0x88)

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

macro n64dd_SceneEntry(name, scenestart, sceneend, titlestart, titleend, unk0, renderinit, dd) {
	dw ({scenestart}), ({sceneend}), ({titlestart}), ({titleend})
	db ({unk0}), ({renderinit}), ({dd}), 0x00
}
