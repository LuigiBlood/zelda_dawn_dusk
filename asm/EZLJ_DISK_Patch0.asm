//Zelda Expansion Disk
//By LuigiBlood

//Uses ARM9 bass

//Memory Patch for NTSC 1.0
//Load everything into memory first, then patch memory

//Format:
//rrrrrrrr ssssssss dddddddd ...
//r = RAM address, s = Size in bytes (aligned to 4), d = Data (size)
//repeat until r = 0

EZLJ_PATCH0:
//---code (File)
//Entrance Table
dw 0x800F9C90, EZLJ_ENTRANCE_TABLE.size
insert EZLJ_ENTRANCE_TABLE,"../other/code_entrance_table.bin"

//Entrance Cutscene Table
dw 0x800EFD04, EZLJ_ENTRANCE_CUTSCENE_TABLE.size
insert EZLJ_ENTRANCE_CUTSCENE_TABLE,"../other/code_entrance_cutscene_table.bin"

//Minimap Table
dw 0x800F6914, EZLJ_MAP_MINIMAP_TABLE.size
insert EZLJ_MAP_MINIMAP_TABLE,"../other/code_overworld_minimap_table.bin"

//Tunic Colors
dw 0x800F7AD8, 8
dw 0x4C971446, 0x2640003C

dw 0
EZLJ_PATCH0_END: