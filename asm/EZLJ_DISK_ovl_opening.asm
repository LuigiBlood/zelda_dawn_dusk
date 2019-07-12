//Zelda Expansion Disk
//By LuigiBlood

//Uses ARM9 bass

//ovl_opening Replacement
ovl_opening_init: {
	//Cannot easily disable everything including language, therefore we add a lock screen.
	lui a0,VI_BASE
	lw a0,VI_ORIGIN(a0)
	li a1,{KSEG1}
	addu a0,a0,a1
	li a1,EZLJ_RESET
	li a2,EZLJ_RESET.size
	n64dd_LoadAddress(v0, {CZLJ_DiskLoad})
	jalr v0
	nop
_ovl_opening_loop:
	b _ovl_opening_loop
	nop

    fill 36

	dw 0x00000130, 0, 0, 0, 0
    dw 0, 0, 0, 0, 0, 0
	dw 0x00000030
}