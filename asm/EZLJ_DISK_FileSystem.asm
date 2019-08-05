//Zelda Expansion Disk
//By LuigiBlood

//Uses ARM9 bass

//Filesystem

print "- Insert Game Files...\n"

seekDisk(0)
base 0

seekDisk(0x4D08)
//Error Screens (Hardcoded, do not move them)
insert EZLJ_ERROR_IPL,"../images/error_screens/EZLJ_error_IPL.bin"
insert EZLJ_ERROR_VER,"../images/error_screens/EZLJ_error_version.bin"
insert EZLJ_ERROR_SAV,"../images/error_screens/EZLJ_error_save.bin"
insert EZLJ_RESET,"../images/error_screens/EZLJ_reset.bin"

//Scene Title Cards
insert EZLJ_SCENENAME09,"../images/g_pn/g_pn_0x09.bin"
insert EZLJ_SCENENAME54,"../images/g_pn/g_pn_0x54.bin"
insert EZLJ_SCENENAME55,"../images/g_pn/g_pn_0x55.bin"
insert EZLJ_SCENENAME59,"../images/g_pn/g_pn_0x59.bin"
insert EZLJ_SCENENAME5B,"../images/g_pn/g_pn_0x5B.bin"

//Scenes / Rooms
insert EZLJ_SCENE07,"../scene/Cave Passage.zscene"
insert EZLJ_SCENE07_MAP00,"../scene/Cave Passage Room 0.zmap"

insert EZLJ_SCENE09,"../scene/Red Ice Cavern.zscene"
insert EZLJ_SCENE09_MAP00,"../scene/Red Ice Cavern Room 0.zmap"
insert EZLJ_SCENE09_MAP01,"../scene/Red Ice Cavern Room 1.zmap"
insert EZLJ_SCENE09_MAP02,"../scene/Red Ice Cavern Room 2.zmap"
insert EZLJ_SCENE09_MAP03,"../scene/Red Ice Cavern Room 3.zmap"
insert EZLJ_SCENE09_MAP04,"../scene/Red Ice Cavern Room 4.zmap"
insert EZLJ_SCENE09_MAP05,"../scene/Red Ice Cavern Room 5.zmap"

insert EZLJ_SCENE15,"../scene/Dusk Palace Chamber.zscene"
insert EZLJ_SCENE15_MAP00,"../scene/Dusk Palace Chamber Room 0.zmap"

insert EZLJ_SCENE2C,"../scene/Dawngrove House 1.zscene"
insert EZLJ_SCENE2C_MAP00,"../scene/Dawngrove House 1 Room 0.zmap"

insert EZLJ_SCENE2E,"../scene/Dawngrove Shop.zscene"
insert EZLJ_SCENE2E_MAP00,"../scene/Dawngrove Shop Room 0.zmap"

insert EZLJ_SCENE34,"../scene/Dawngrove Inn.zscene"
insert EZLJ_SCENE34_MAP00,"../scene/Dawngrove Inn Room 0.zmap"
insert EZLJ_SCENE34_MAP01,"../scene/Dawngrove Inn Room 1.zmap"
insert EZLJ_SCENE34_MAP02,"../scene/Dawngrove Inn Room 2.zmap"
insert EZLJ_SCENE34_MAP03,"../scene/Dawngrove Inn Room 3.zmap"
insert EZLJ_SCENE34_MAP04,"../scene/Dawngrove Inn Room 4.zmap"
insert EZLJ_SCENE34_MAP05,"../scene/Dawngrove Inn Room 5.zmap"

insert EZLJ_SCENE35,"../scene/Dawngrove House 2.zscene"
insert EZLJ_SCENE35_MAP00,"../scene/Dawngrove House 2 Room 0.zmap"

insert EZLJ_SCENE52,"../scene/Credits.zscene"
insert EZLJ_SCENE52_MAP00,"../scene/Credits Room 0.zmap"

insert EZLJ_SCENE54,"../scene/Great Dusk Chasm.zscene"
insert EZLJ_SCENE54_MAP00,"../scene/Great Dusk Chasm Room 0.zmap"
insert EZLJ_SCENE54_MAP01,"../scene/Great Dusk Chasm Room 1.zmap"
insert EZLJ_SCENE54_MAP02,"../scene/Great Dusk Chasm Room 2.zmap"

insert EZLJ_SCENE55,"../scene/Dawngrove Village.zscene"
insert EZLJ_SCENE55_MAP00,"../scene/Dawngrove Village Room 0.zmap"

insert EZLJ_SCENE59,"../scene/Dusk Palace Gardens.zscene"
insert EZLJ_SCENE59_MAP00,"../scene/Dusk Palace Gardens Room 0.zmap"

insert EZLJ_SCENE5B,"../scene/Dawngrove.zscene"
insert EZLJ_SCENE5B_MAP00,"../scene/Dawngrove Room 0.zmap"
insert EZLJ_SCENE5B_MAP01,"../scene/Dawngrove Room 1.zmap"
insert EZLJ_SCENE5B_MAP02,"../scene/Dawngrove Room 2.zmap"

insert EZLJ_SCENE60,"../scene/Cutscene Map.zscene"
insert EZLJ_SCENE60_MAP00,"../scene/Cutscene Map Room 0.zmap"

//Exception, to be loaded via DMA ROM to RAM hook instead
insert EZLJ_SCENE3E,"../scene/Grottos.zscene"
insert EZLJ_SCENE3E_MAP13,"../scene/Grottos Room 13.zmap"

//Audio
insert EZLJ_AUDIOBANK0,"../audio/audiobank.dawn.0.bin" // 1.0 & 1.1
insert EZLJ_AUDIOBANK2,"../audio/audiobank.dawn.2.bin" // 1.2

//ovl_opening Replacement
include "EZLJ_DISK_ovl_opening.asm"

//Main Static Files (follows RAM Allocation)
EZLJ_DISK_FS_STATICMAIN_START:
insert EZLJ_AUDIOSEQ,"../audio/audioseq.dawn.bin"
insert EZLJ_AUDIOBANK_TABLE,"../audio/audiobank.dawn.table.bin"
insert EZLJ_AUDIOINST_TABLE,"../audio/audioinst.dawn.table.bin"
insert EZLJ_AUDIOSEQ_TABLE,"../audio/audioseq.dawn.table.bin"

//Text
insert EZLJ_NES_MESSAGE_TABLE,"../text/MessageTable.tbl"
insert EZLJ_NES_MESSAGE_DATA_STATIC,"../text/StringData.bin"

include "EZLJ_DISK_PatchGeneric.asm"

//Scene Table
include "EZLJ_DISK_SceneList.asm"

EZLJ_DISK_FS_STATICMAIN_END:
constant EZLJ_DISK_FS_STATICMAIN_SIZE(EZLJ_DISK_FS_STATICMAIN_END-EZLJ_DISK_FS_STATICMAIN_START)

//Virtual File Table Replacement & Patch for each game version
dw 0
include "EZLJ_DISK_FileData0.asm"
dw 0,0,0
include "EZLJ_DISK_Patch0.asm"

dw 0,0,0
include "EZLJ_DISK_FileData1.asm"
dw 0,0,0
include "EZLJ_DISK_Patch1.asm"

dw 0,0,0
include "EZLJ_DISK_FileData2.asm"
dw 0,0,0
include "EZLJ_DISK_Patch2.asm"

//For precaution with 64DD Disk loading on real hardware, all these files will be loaded contiguous to RAM in one go.
//(follows RAM Allocation)
dw 0,0,0
EZLJ_DISK_FS_STATIC_START:
insert EZLJ_MAP_MINIMAP_TABLE_LENGTH,"../other/code_overworld_minimap_table_length.bin"
insert EZLJ_MAP_MINIMAP_TABLE_OFFSET,"../other/code_overworld_minimap_table_offset.bin"
insert EZLJ_MAP_MINIMAP_TABLE_XPOS,"../other/code_overworld_minimap_table_xpos.bin"
insert EZLJ_MAP_MINIMAP_TABLE_YPOS,"../other/code_overworld_minimap_table_ypos.bin"
insert EZLJ_MAP_MINIMAP_TABLE_COMPASS,"../other/code_overworld_minimap_table_compass.bin"
insert EZLJ_MAP_MINIMAP_TABLE_WIDTH,"../other/code_overworld_minimap_table_width.bin"
insert EZLJ_MAP_MINIMAP_TABLE_HEIGHT,"../other/code_overworld_minimap_table_height.bin"

insert EZLJ_GAMEPLAY_DANGEON_KEEP,"../object/gameplay_dangeon_keep.bin"
insert EZLJ_OBJECT_LINK_CHILD,"../object/object_link_child.bin"

insert EZLJ_ICON_ITEM_FIELD_STATIC,"../images/icon_item_field_static.bin"
insert EZLJ_ICON_ITEM_NES_STATIC,"../images/icon_item_nes_static.bin"

insert EZLJ_MAP_NAME_STATIC_LAND,"../images/map_name_static/map_name_static_landdawndusk_5800.bin"
insert EZLJ_MAP_NAME_STATIC_DAWN,"../images/map_name_static/map_name_static_dawnside.bin"
insert EZLJ_MAP_NAME_STATIC_DUSK,"../images/map_name_static/map_name_static_duskside.bin"

insert EZLJ_MAP_GRAND_STATIC,"../images/map_grand_static.bin"

insert EZLJ_ITEM_NAME_STATIC_SLINGSHOT,"../images/item_name_static/item_name_static_slingshot_1800.bin"
insert EZLJ_ITEM_NAME_STATIC_HAMMER,"../images/item_name_static/item_name_static_hammer_4400.bin"
insert EZLJ_ITEM_NAME_STATIC_SWORD1,"../images/item_name_static/item_name_static_sword1_EC00.bin"
insert EZLJ_ITEM_NAME_STATIC_SHIELD1,"../images/item_name_static/item_name_static_shield1_F800.bin"
insert EZLJ_ITEM_NAME_STATIC_SHIELD2,"../images/item_name_static/item_name_static_shield2_FC00.bin"
insert EZLJ_ITEM_NAME_STATIC_TUNIC1,"../images/item_name_static/item_name_static_tunic1_10400.bin"
insert EZLJ_ITEM_NAME_STATIC_TUNIC2,"../images/item_name_static/item_name_static_tunic2_10800.bin"
insert EZLJ_ITEM_NAME_STATIC_BOOTS1,"../images/item_name_static/item_name_static_boots1_11000.bin"
insert EZLJ_ITEM_NAME_STATIC_BRACELET,"../images/item_name_static/item_name_static_bracelet_14000.bin"

insert EZLJ_OBJECT_GI_BRACELET,"../object/object_gi_bracelet.bin"
insert EZLJ_OBJECT_GI_CLOTHES,"../object/object_gi_clothes.bin"
insert EZLJ_OBJECT_GI_SHIELD1,"../object/object_gi_shield_1.bin"
insert EZLJ_OBJECT_GI_SHIELD2,"../object/object_gi_shield_2.bin"

insert EZLJ_OBJECT_FD,"../object/object_fd.ntsc.bin"

insert EZLJ_MAP_48X85_STATIC,"../images/map_48x85_static.bin"

EZLJ_DISK_FS_STATIC_END:
constant EZLJ_DISK_FS_STATIC_SIZE(EZLJ_DISK_FS_STATIC_END-EZLJ_DISK_FS_STATIC_START)
