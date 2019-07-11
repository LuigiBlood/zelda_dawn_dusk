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
dw 0x800FA2E0, EZLJ_ENTRANCE_TABLE2.size
insert EZLJ_ENTRANCE_TABLE2,"../other/code_entrance_table.bin"

//Entrance Cutscene Table
dw 0x800F0344, EZLJ_ENTRANCE_CUTSCENE_TABLE2.size
insert EZLJ_ENTRANCE_CUTSCENE_TABLE2,"../other/code_entrance_cutscene_table.bin"

//Tunic Colors
dw 0x800F8128, 8
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
//include "../patch/misc-opti_link_child.2.patch"

//include "../patch/ovl_kaleido_scope.2.patch"

//include "../patch/misc-getitem.2.patch"

//include "../patch/ovl_En_Ossan.2.patch"

//include "../patch/ovl_En_Fz.2.patch"

//include "../patch/ovl_Bg_Vb_Sima.2.patch"

//include "../patch/ovl_En_Wf.2.patch"

//include "../patch/ovl_Boss_Fd.2.patch"
//include "../patch/ovl_Boss_Fd2.2.patch"
//include "../patch/ovl_Bg_Hidan_Curtain.2.patch"

dw 0
EZLJ_PATCH2_END: