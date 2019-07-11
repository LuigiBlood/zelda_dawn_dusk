//Zelda Expansion Disk
//By LuigiBlood

//Uses ARM9 bass

//Memory Patch for NTSC 1.1
//Load everything into memory first, then patch memory

//Format:
//rrrrrrrr Tsssssss dddddddd ...
//r = RAM address, T = Type, s = Size in bytes (aligned to 4), d = Data (size)
//repeat until r = 0
//T = 0, then copy (rrrrrrrr 0sssssss dddddddd ...)
//T = 1, then fill (rrrrrrrr 1sssssss 000000dd) 

EZLJ_PATCH1:
//---code (File)
//Entrance Table
dw 0x800F9E50, EZLJ_ENTRANCE_TABLE1.size
insert EZLJ_ENTRANCE_TABLE1,"../other/code_entrance_table.bin"

//Entrance Cutscene Table
dw 0x800EFEC4, EZLJ_ENTRANCE_CUTSCENE_TABLE1.size
insert EZLJ_ENTRANCE_CUTSCENE_TABLE1,"../other/code_entrance_cutscene_table.bin"

//Tunic Colors
dw 0x800F7C98, 8
dw 0x4C971446, 0x2640003C


//---Object List
//exemple in case of use
//dw (0x800F8FF0 + 8 + (8 * id)), 8
//dw start, end

//---Actor Overlay Table
//ovl_Item_Shield
//dw (0x800E8530 + (0x10 * 0xEE)), 8
//dw (DDHOOK_OVL_ITEM_SHIELD), (DDHOOK_OVL_ITEM_SHIELD + 0xA10)

//---Particle Overlay Table
//ovl_Effect_Ss_Stick
//dw (0x800E7C40 + (0x1C * 0x10)), 8
//dw (DDHOOK_OVL_EFFECT_SS_STICK), (DDHOOK_OVL_EFFECT_SS_STICK + 0x3A0)

//---Setup Link (Child) Optimized (by CrookedPoe)
include "../patch/misc-opti_link_child.1.patch"

include "../patch/misc-getitem.1.patch"

//include "../patch/ovl_En_Fz.1.patch"

//include "../patch/ovl_Bg_Vb_Sima.1.patch"

//include "../patch/ovl_En_Wf.1.patch"

//include "../patch/ovl_Boss_Fd.1.patch"
//include "../patch/ovl_Boss_Fd2.1.patch"
//include "../patch/ovl_Bg_Hidan_Curtain.1.patch"

dw 0
EZLJ_PATCH1_END: