//Zelda 64 Dawn & Dusk - Expansion Disk
//By LuigiBlood

//Uses ARM9 bass

//Ocarina of Time Expansion Hook
print "- Assemble Expansion Disk Code...\n"

seekDisk(0)
base DDHOOK_RAM

ddhook_start:
	db "ZELDA_DD"
ddhook_list_start:
	dw (ddhook_setup | {KSEG1})	//00: 64DD Hook
	dw 0x00000000			//04: 64DD Unhook
	dw 0x00000000			//08: Room Loading Hook
	dw 0x00000000			//0C: Scene Loading (???)
	dw 0x00000000			//10: "game_play" game state entrypoint
	dw 0x00000000			//14: Collision related
	dw 0x00000000			//18: ???
	dw 0x00000000			//1C: 
	dw 0x00000000			//20: 
	dw 0x00000000			//24: 
	dw 0x00000000			//28: map_i_static Replacement
	dw 0x00000000			//2C: 
	dw 0x00000000			//30: 
	dw 0x00000000			//34:
	dw 0x00000000			//38:
	dw 0x00000000			//3C:
	dw 0x00000000			//40: 
	dw 0x00000000			//44: map_48x85_static Replacement
	dw 0 //(ddhook_scenedetect_real)	//48: Scene Entry Replacement
	dw 0x00000000			//4C:
	dw 0x00000000			//50:
	dw 0 //(ddhook_removecutscene)	//54: Entrance Cutscene Replacement?
	dw 0 //(ddhook_text_table)		//58: Message Table Replacement Setup
	dw 0x00000000			//5C:
	dw 0x00000000			//60: staff_message_data_static Load
	dw 0x00000000			//64: jpn_message_data_static Load
	dw 0 //(ddhook_textUSload)		//68: nes_message_data_static Load
	dw 0x00000000			//6C: ???
	dw 0x00000000			//70: DMA ROM to RAM Hook
	dw 0x00000000			//74: ??? (Every Frame?)
	dw 0x00000000			//78: Set Cutscene Pointer (Intro Cutscenes)
ddhook_list_end:

//64DD Hook Initialization Code
ddhook_setup: {
	//Arguments:
	//A0=p->Address Table
	//800FEE70 (NTSC 1.0) - Address Table
	//	+0x0 = n64dd_Func_801C7C1C (USEFUL! Disk read function)
	//	+0x50 = osSendMesg
	//	+0x88 = Save Context
	//8011A5D0 (NTSC 1.0) - Save Context
	//	+0x1409 = Language (8011B9D9)
	
	addiu sp,sp,-0x10
	sw ra,4(sp)
	
	//Save Zelda Disk Address Table Address for later usage
	li a3,(DDHOOK_ADDRTABLE)
	sw a0,0(a3)

	//Version Detection
	//1.0 test
	li a1,0x800FEE70
	beq a0,a1,+
	nop

	//1.1 test
	li a1,0x800FF030
	beq a0,a1,++
	nop

	//else it must be 1.2
	addiu a1,0,2
	sw a1,4(a3)	//1.2
	n64dd_DiskLoad(DDHOOK_VERSIONTABLE, ezlj_vertable2, ezlj_vertable2_end - ezlj_vertable2)
	b _ddhook_setup_dochanges
	nop

 +;	sw 0,4(a3)	//1.0
	n64dd_DiskLoad(DDHOOK_VERSIONTABLE, ezlj_vertable0, ezlj_vertable0_end - ezlj_vertable0)
	b _ddhook_setup_dochanges
	nop

 +;	addiu a1,0,1	//1.1
	sw a1,4(a3)
	n64dd_DiskLoad(DDHOOK_VERSIONTABLE, ezlj_vertable1, ezlj_vertable1_end - ezlj_vertable1)
	b _ddhook_setup_dochanges
	nop

_ddhook_incompatibleversion:
	lui a0,VI_BASE
	lw a0,VI_ORIGIN(a0)
	li a1,{KSEG1}
	addu a0,a0,a1
	li a1,EZLJ_ERROR_VER
	li a2,EZLJ_ERROR_VER.size
	n64dd_LoadAddress(v0, {CZLJ_DiskLoad})
	jalr v0
	nop

_ddhook_incompatible_loop:
	j _ddhook_incompatible_loop
	nop

_ddhook_setup_dochanges:
	//Change Entrance Table Entry
	//NTSC 1.0 - 800F9C90 (-51E0)
	//NTSC 1.1 - 800F9E50 (-51E0)
	//NTSC 1.2 - 800FA2E0 (-51D0)

	b _ddhook_setup_savecontext
	nop

	subiu a0,a0,0x51E0
	sltiu at,a1,2 //1 = under 2, 0 = equal to 2
	bne at,0,_ddhook_setup_savecontext
	nop
	addiu a0,a0,0x10

	sb 0,0x1781(a0) //Spawn to entrance 0 of new map
	sb 0,0x1785(a0) //Spawn to entrance 0 of new map
	sb 0,0x1789(a0) //Spawn to entrance 0 of new map
	sb 0,0x178D(a0) //Spawn to entrance 0 of new map

_ddhook_setup_savecontext:
	//Save Context Change
	n64dd_LoadAddress(a1, {CZLJ_SaveContext})
	ori a2,0,1
	sb a2,0x1409(a1)	//Set the game into English (1)
	sw 0,0x135C(a1)		//Set Game Mode to Normal Gameplay
	//(Map Select does not reset it when disk is present, seems to be a bug)
	
	//Check if save is new
	//TODO

	//Ice Cavern - 86 - 0x88 (Red Ice Cavern)
	//Kakariko Village - 2 - 0xDB (Dawngrove Village)
	//Kokiri Forest - 5 - 0xEE (Great Dusk Chasm)
	//Lost Woods - 11 - 0x120 (Dawngrove)
	//Fire Temple - 77 - 0x165 (Cave Theme?)

	li a2,0xDB
	sw a2,0(a1)

	//No Cutscene
	sw 0,8(a1)

	addiu a0,a1,0x2E
	li a1,EZLJ_SAVE_DATA
	addiu a2,0,EZLJ_SAVE_DATA.size

	//n64dd_LoadAddress(v0, {CZLJ_DiskLoad})
	//jalr v0
	nop

_ddhook_setup_music:
	n64dd_DiskLoad(DDHOOK_AUDIOBANK_TABLE, EZLJ_AUDIOBANK_TABLE, EZLJ_AUDIOBANK_TABLE.size)
	n64dd_DiskLoad(DDHOOK_AUDIOINST_TABLE, EZLJ_AUDIOINST_TABLE, EZLJ_AUDIOINST_TABLE.size)
	n64dd_DiskLoad(DDHOOK_AUDIOSEQ_TABLE, EZLJ_AUDIOSEQ_TABLE, EZLJ_AUDIOSEQ_TABLE.size)

	//Check version and load the appropriate audiobank
	li a0,DDHOOK_VERSION
	lw a0,0(a0)
	sync

	ori at,0,1
	beq a0,at,_ddhook_setup_music_bank1
	nop
	ori at,0,2
	beq a0,at,_ddhook_setup_music_bank2
	nop

_ddhook_setup_music_bank0:
	n64dd_DiskLoad(DDHOOK_AUDIOBANK, EZLJ_AUDIOBANK0, EZLJ_AUDIOBANK0.size)
	b _ddhook_setup_music_seq
	nop

_ddhook_setup_music_bank1:
	n64dd_DiskLoad(DDHOOK_AUDIOBANK, EZLJ_AUDIOBANK0, EZLJ_AUDIOBANK0.size)
	b _ddhook_setup_music_seq
	nop

_ddhook_setup_music_bank2:
	n64dd_DiskLoad(DDHOOK_AUDIOBANK, EZLJ_AUDIOBANK2, EZLJ_AUDIOBANK2.size)

_ddhook_setup_music_seq:
	n64dd_DiskLoad(DDHOOK_AUDIOSEQ, EZLJ_AUDIOSEQ, EZLJ_AUDIOSEQ.size)

	//Update Pointers Audiobank Table
	li a0,DDHOOK_AUDIOBANK
	li a1,DDHOOK_AUDIOBANK_TABLE
	sw a0,4(a1)	//Update Pointer
	lhu a2,0(a1)	// Get amount of AudioBank stuff

 -;	addiu a1,a1,0x10

	lw a3,0(a1)
	addu a3,a3,a0
	sw a3,0(a1)

	addiu a2,a2,-1
	bne a2,0,-
	nop

	//Update Pointers Audioseq Table
	li a0,DDHOOK_AUDIOSEQ
	li a1,DDHOOK_AUDIOSEQ_TABLE
	sw a0,4(a1)	//Update Pointer
	lhu a2,0(a1)	// Get amount of AudioSeq stuff

 -;	addiu a1,a1,0x10

	lw a3,0(a1)
	addu a3,a3,a0
	sw a3,0(a1)

	addiu a2,a2,-1
	bne a2,0,-
	nop

	// Change Pointers Audio
	// VER - ADDRESS  - AUDIOSEQ, AUDIOBANK, AUDIOTABLE, AUDIOINST
	// 1.0 - 80127E60 - 80113B70 80113740 80114260 801139B0
	// 1.1 - 80128020 - 80113D30 80113900 80114420 80113B70
	// 1.2 - 80128730 - 80114220 80113DF0 80114910 80114060

	li a0,DDHOOK_VERSIONTABLE
	lw a0,0(a0)
	sync

	li a1,DDHOOK_AUDIOBANK_TABLE
	li a2,DDHOOK_AUDIOSEQ_TABLE
	li a3,DDHOOK_AUDIOINST_TABLE
	sw a2,0(a0)
	sw a1,4(a0)
	// 8(a0) is AUDIOTABLE_TABLE
	sw a3,0xC(a0)
	

	// Patch osEPiStartDma
	// VER - ADDRESS
	// 1.0 - 800B8250
	// 1.1 - 800B8270
	// 1.2 - 800B88D0

	li a0,DDHOOK_VERSIONTABLE
	lw a0,4(a0)
	sync

	//Copy osEPiStartDma call
	li a1,_ddhook_loadmusic_startdma
	lw a2,0(a0)
	sync
	sw a2,0(a1)
	lw a2,4(a0)
	sync
	sw a2,4(a1)
	lw a2,8(a0)
	sync
	sw a2,8(a1)

	//Inject custom function call
	li a1,_ddhook_setup_musicdma
	lw a2,0(a1)
	sync
	sw a2,0(a0)
	lw a2,4(a1)
	sync
	sw a2,4(a0)
	lw a2,8(a1)
	sync
	sw a2,8(a0)

	b _ddhook_setup_finish
	nop

_ddhook_setup_musicdma:
	li t9,ddhook_loadmusic
	jalr ra,t9


_ddhook_setup_finish:
	//osWritebackDCache all of the expanded memory
	lui a0, 0x8040
	lui a1, 0x0040
	n64dd_LoadAddress(v0, {CZLJ_osWritebackDCache})
	jalr v0
	nop
	
	//Load text data into RAM (avoid music stop)
	//n64dd_DiskLoad(DDHOOK_TEXTDATA, EZLJ_NES_MESSAGE_DATA_STATIC, EZLJ_NES_MESSAGE_DATA_STATIC.size)
	
	lw ra,4(sp)
	addiu sp,sp,0x10
	jr ra
	nop
}

ddhook_loadmusic: {	//804102E0
	addiu sp,sp,-0x20
	sw ra,0x18(sp)
	sw a1,0x14(sp)

	lui a3,0x8000
	lw v0,0xC(a1)
	sltu at,v0,a3	// 0 == >= 80000000 / 1 == < 80000000
	bne at,0,_ddhook_loadmusic_startdma
	nop

	lw a0,0x8(a1)	//RAM Dest
	lw a2,0x10(a1)	//Size
	ori a1,v0,0		//RAM Source

	//Copy Text Data from RAM to where it wants
	//Avoid hang from loading from disk directly and stop the music
	//A0 = Dest, A1 = Source, A2 = Size, A3 = Used for copy
     -; lb a3,0(a1)
	sb a3,0(a0)
	addiu a0,a0,1
	addiu a1,a1,1
	subi a2,a2,1
	bnez a2,-
	nop

	lw v0,0x14(sp)
	ori a0,v0,0
	lw a0,4(a0)
	ori a1,v0,0
	ori a2,0,0
	n64dd_LoadAddress(a3,{CZLJ_osSendMesg})
	jalr a3
	nop

	lw ra,0x18(sp)
	addiu sp,sp,0x20
	jr ra
	nop

_ddhook_loadmusic_startdma:
	//Original EPiStartDma code to load from ROM instead
	lui t9,0x8010
	lw t9,0x17E0(t9)
	jalr t9
	nop

	lw ra,0x18(sp)
	addiu sp,sp,0x20
	jr ra
	nop
}

//nes_message_data_static Load Hook
ddhook_textUSload: {
	//Arguments:
	//A0=p->Message Context
	//	+0 = Offset
	//	+4 = Size
	//	+DC88 = Destination
	
	addiu sp,sp,-0x10
	sw ra,8(sp)
	sw a0,4(sp)
	
	//osWritebackDCache all of the expanded memory
	lui a0, 0x8040
	lui a1, 0x0040
	n64dd_LoadAddress(at, {CZLJ_osWritebackDCache})
	jalr at
	nop
	
	lw a0,4(sp)
	
	lw a2,4(a0) 		//A2 = Size
	lw a1,0(a0)		//A1 = Offset
	li a3,DDHOOK_TEXTDATA	//A3 = DDHOOK_TEXTDATA
	addu a1,a1,a3		//A1 = A3 + Offset
	ori a3,0,0xDC88
	addu a0,a0,a3		//A0 = RAM Dest
	
	//Copy Text Data from RAM to where it wants
	//Avoid hang from loading from disk directly and stop the music
	//A0 = Dest, A1 = Offset, A2 = Size, A3 = Used for copy
     -; lb a3,0(a1)
	sb a3,0(a0)
	addiu a0,a0,1
	addiu a1,a1,1
	subi a2,a2,1
	bnez a2,-
	
	lw ra,8(sp)
	addiu sp,sp,0x10
	jr ra
	nop
}

//Message Table Replacement Setup Hook
ddhook_text_table: {
	//Arguments:
	//A0=p->p->jpn_message_data_static table
	//A1=p->p->nes_message_data_static table
	//A2=p->p->staff_message_data_static table
	//You can change the pointers.
	
	addiu sp,sp,-0x20
	sw ra,0x10(sp)
	sw a0,0xC(sp)
	sw a1,0x8(sp)
	sw a2,0x4(sp)
	
	//osWritebackDCache all of the expanded memory
	lui a0, 0x8040
	lui a1, 0x0040
	n64dd_LoadAddress(at, {CZLJ_osWritebackDCache})
	jalr at
	nop
	
	lw a0,0xC(sp)
	lw a1,0x8(sp)
	lw a2,0x4(sp)
	
	li a0,DDHOOK_TEXTTABLE
	sw a0,0(a1)		//Change nes_message_data_static pointer
	
	//osWritebackDCache all of the expanded memory
	lui a0, 0x8040
	lui a1, 0x0040
	n64dd_LoadAddress(v0, {CZLJ_osWritebackDCache})
	jalr v0
	nop
	
	n64dd_DiskLoad(DDHOOK_TEXTTABLE, EZLJ_NES_MESSAGE_TABLE+4, 0x421C)
	
	lw ra,0x10(sp)
	addiu sp,sp,0x20
	jr ra
	nop	
}

//Scene Entry Hook
ddhook_scenedetect_real: {
	//Arguments:
	//A0=Scene ID
	//A1=p->Scene Table
	//
	//Return:
	//V0=p->Scene Entry
	
	//TODO: Proper Scene Listing and Disk Detection
	
	addiu sp,sp,-0x10

	//Calculate Scene Entry Address
	addiu a3,0,0x14
	multu a0,a3
	mflo a2		//(0x14 * Scene ID)
	addu v0,a2,a1

	addiu a2,0,0x5B
	bne a0,a2,+	//Scene 5B is Lost Woods
	nop

	li a0,ddhook_list_start	
	li a1,ddhook_roomload
	sw a1,8(a0)
	
	li v0, ddhook_sceneentry_data
	nop
	
	b ++
	nop
	
	//If if it's Scene 0, add Room Loading Hook
     +; li a0,ddhook_list_start
	sw 0,8(a0)
	
     +; addiu sp,sp,0x10
	jr ra
	nop
}

//Room Loading Hook
ddhook_roomload: {
	//Arguments:
	//A0=p->Global Context
	//A1=p->Room Context
	//A2=Room ID
	
	addiu sp,sp,-0x20
	sw ra,0x10(sp)
	sw a1,0x14(sp)
	sw a2,0x18(sp)
	
	//osWritebackDCache all of the expanded memory
	lui a0, 0x8040
	lui a1, 0x0040
	n64dd_LoadAddress(at, {CZLJ_osWritebackDCache})
	jalr at
	nop
	
	lw a1,0x14(sp)
	lw a2,0x18(sp)
	
	lw a0,0x0134(a1)	//load Room List Pointer
	sll a3,a2,3		//Room ID * 8
	addu a2,a0,a3		//calculate offset from Room ID
	lw a0,0x34(a1)		//A0=RAM Address
	lw a3,0x4(a2)		//RoomEnd
	lw a1,0x0(a2)		//RoomStart (A1=VROM Address)
	subu a2,a3,a1		//A2=Size
	
	lw a3,0x14(sp)
	sw a1,0x38(a3)		//Store VROM Address
	sw a0,0x3C(a3)		//Store RAM Address
	sw a2,0x40(a3)		//Store Size 
	
	n64dd_LoadAddress(a3, {CZLJ_DiskLoad})
	jalr a3			//read from disk
	nop
	
	lw a0,0x14(sp)
	addiu a0,a0,0x50
	lw a0,0(a0)		//OsMesgQueue pointer (osSendMesg A0)
	li a1,0			//OSMesg (osSendMesg A1)
	li a2,0			//DON'T BLOCK until response
	
	n64dd_LoadAddress(a3, {CZLJ_osSendMesg})
	jalr a3			//osSendMesg, to let the engine know that the data is loaded and continue the game
	nop
	
	lw ra,0x10(sp)
	addiu sp,sp,0x20
	jr ra
	nop
}

//Remove Intro Cutscene (avoid softlock)
ddhook_removecutscene: {
	//Arguments:
	//A0=p->Global Context
	//
	//Return:
	//V0=Is Loaded?
	
	addiu v0,0,1
	jr ra
	nop
}

//Scene Entries
ddhook_sceneentry_data: {
	n64dd_SceneEntry("TEST SCENE", EZLJ_CUSTOM_SCENE00, EZLJ_CUSTOM_SCENE00_END, 0x00000000, 0x00000000, 0x01, 0x13, 0x02)
}

ddhook_end:

if (origin() >= (0x785C8 + 0x1060)) {
  print (origin() - 0x785C8)
  error "\n\nFATAL ERROR: MAIN DISK CODE IS TOO LARGE.\nPlease reduce it and load the rest during 64DD Hook Initialization Code.\n"
}

//Initial loading from OoT File Start
seekDisk(0x1060)
dw (ddhook_start - ddhook_start)	//Source Start
dw (ddhook_end - ddhook_start)		//Source End
dw (ddhook_start | {KSEG1})		//Dest Start
dw (ddhook_end | {KSEG1})		//Dest End
dw (ddhook_list_start | {KSEG1})	//Hook Table Address

seekDisk(0)
base 0
seekDisk(0x1080)
ezlj_vertable0:
	dw 0x80127E60	// Address to Audio Tables Pointers
	dw 0x800B8250	// Address to osEPiStartDma Patch
ezlj_vertable0_end:

ezlj_vertable1:
	dw 0x80128020	// Address to Audio Tables Pointers
	dw 0x800B8270	// Address to osEPiStartDma Patch
ezlj_vertable1_end:

ezlj_vertable2:
	dw 0x80128730	// Address to Audio Tables Pointers
	dw 0x800B88D0	// Address to osEPiStartDma Patch
ezlj_vertable2_end:
