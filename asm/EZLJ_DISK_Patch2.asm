//Zelda Expansion Disk
//By LuigiBlood

//Uses ARM9 bass

//Memory Patch for NTSC 1.2
//Load everything into memory first, then patch memory

//Format:
//rrrrrrrr Tsssssss dddddddd ...
//r = RAM address, T = Type, s = Size in bytes (aligned to 4), d = Data (size)
//repeat until r = 0
//T = 0, then copy (rrrrrrrr 0sssssss dddddddd ...)
//T = 1, then fill (rrrrrrrr 1sssssss 000000dd) 

EZLJ_PATCH2:
//---code (File)
//Entrance Table
n64dd_PatchCopy((DDHOOK_CODE2 + 0xE8C00), EZLJ_ENTRANCE_TABLE2.size)
insert EZLJ_ENTRANCE_TABLE2,"../other/code_entrance_table.bin"

//Entrance Cutscene Table
n64dd_PatchCopy((DDHOOK_CODE2 + 0xDEC64), EZLJ_ENTRANCE_CUTSCENE_TABLE2.size)
insert EZLJ_ENTRANCE_CUTSCENE_TABLE2,"../other/code_entrance_cutscene_table.bin"

//Tunic Colors
n64dd_PatchCopy((DDHOOK_CODE2 + 0xE6A48), 8)
dw 0x4C971446, 0x2640003C

//---Setup Link (Child) Optimized (by CrookedPoe)
include "../patch/misc-opti_link_child.2.patch"

include "../patch/misc-getitem.2.patch"

//Force use Hylian Shield like Adult Link
n64dd_PatchCopy((DDHOOK_CODE2 + 0x68450), 4)
nop

n64dd_PatchEnd()
EZLJ_PATCH2_END: