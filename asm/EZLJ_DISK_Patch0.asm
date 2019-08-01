//Zelda Expansion Disk
//By LuigiBlood

//Uses ARM9 bass

//Memory Patch for NTSC 1.0
//Load everything into memory first, then patch memory

//Format:
//rrrrrrrr Tsssssss dddddddd ...
//r = RAM address, T = Type, s = Size in bytes (aligned to 4), d = Data (size)
//repeat until r = 0
//T = 0, then copy (rrrrrrrr 0sssssss dddddddd ...)
//T = 1, then fill (rrrrrrrr 1sssssss 000000dd) 

EZLJ_PATCH0:
//---code (File)
//Entrance Table
dw 0x800F9C90, EZLJ_ENTRANCE_TABLE.size
insert EZLJ_ENTRANCE_TABLE,"../other/code_entrance_table.bin"

//Entrance Cutscene Table
dw 0x800EFD04, EZLJ_ENTRANCE_CUTSCENE_TABLE.size
insert EZLJ_ENTRANCE_CUTSCENE_TABLE,"../other/code_entrance_cutscene_table.bin"

//Tunic Colors
dw 0x800F7AD8, 8
dw 0x4C971446, 0x2640003C

//---Setup Link (Child) Optimized (by CrookedPoe)
include "../patch/misc-opti_link_child.0.patch"

include "../patch/misc-getitem.0.patch"

//Force use Hylian Shield like Adult Link
dw (0x800110A0 + 0x68400), 4
nop

//dw (0x80000A54 + 0x78), 4
//ori a2,0,1

//Crash Debugger stuff
//dw (0x8000134C + 0x8), 8
//jal ddhook_copyfullram
//nop

dw 0
EZLJ_PATCH0_END: