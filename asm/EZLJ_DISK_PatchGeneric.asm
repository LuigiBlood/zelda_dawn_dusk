//Zelda Expansion Disk
//By LuigiBlood

//Uses ARM9 bass

//Generic Memory Patch

//Format:
//rrrrrrrr Tsssssss dddddddd ...
//r = RAM address, T = Type, s = Size in bytes (aligned to 4), d = Data (size)
//repeat until r = 0
//T = 0, then copy (rrrrrrrr 0sssssss dddddddd ...)
//T = 1, then fill (rrrrrrrr 1sssssss 000000dd) 

EZLJ_PATCH_ALL:
include "../patch/gameplay_keep.patch"

include "../patch/icon_item_static.patch"
include "../patch/icon_item_24_static.patch"

//dw 0
EZLJ_PATCH_ALL_END: