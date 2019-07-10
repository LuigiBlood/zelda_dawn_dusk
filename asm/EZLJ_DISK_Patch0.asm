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
include "../patch/misc-opti_link_child.0.patch"

//---Enable Megaton Hammer rendering for Child Link
dw (DDHOOK_OVL_PLAYER_ACTOR + 0x184FC), 4
dw 0x1000000B

//---Object gameplay_keep
//TODO Just take original file and change Link`s hair 0x1A40 (DBG and 1.0)

include "../patch/ovl_kaleido_scope.0.patch"

include "../patch/misc-getitem.0.patch"

include "../patch/icon_item_static.patch"
include "../patch/icon_item_24_static.patch"

include "../patch/ovl_En_Ossan.0.patch"

include "../patch/object_po_composer.patch"
include "../patch/object_hidan_objects.patch"
include "../patch/object_bdoor.patch"
include "../patch/object_mizu_objects.patch"
include "../patch/object_ice_objects.patch"
include "../patch/object_spot02_objects.patch"
include "../patch/object_sd.patch"
include "../patch/object_fd2.patch"

include "../patch/parameter_static.patch"

include "../patch/ovl_En_Fz.0.patch"

include "../patch/ovl_Bg_Vb_Sima.0.patch"

include "../patch/ovl_En_Wf.0.patch"

include "../patch/ovl_Boss_Fd.0.patch"
include "../patch/ovl_Boss_Fd2.0.patch"
include "../patch/ovl_Bg_Hidan_Curtain.0.patch"

include "../patch/gameplay_keep.patch"

dw 0
EZLJ_PATCH0_END: