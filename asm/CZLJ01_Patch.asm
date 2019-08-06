//Zelda 64 Dawn & Dusk - NTSC 1.1 ROM Patch
//By LuigiBlood

//Uses ARM9 bass

arch n64.cpu
endian msb

include "N64.INC"
include "N64_GFX.INC"

output "../CZLJ_DawnDusk.z64", create

insert "../CZLJ01_D.z64"

print "Patching Zelda ROM (NTSC 1.1)...\n"

macro seek(n) {
	origin {n}
}

macro seekDisk(n) {
	origin {n}
}

//Patch Macro
macro n64dd_PatchCopy(addr, size) {
	origin {addr}
}

macro n64dd_PatchFill(addr, size, fill) {
	origin {addr}
    fill {size}, {fill}
}

macro n64dd_PatchEnd() {
    //Do nothing
}

macro n64dd_ImportFile(addr, name, file) {
    seek({addr})
    insert {name},{file}
}

macro n64dd_SceneEntry(name, scenestart, titlestart, unk0, renderinit, dd) {
    seek(DDHOOK_SCENETABLE + (0x14 * {dd}))

	dw ({scenestart}), ({scenestart} + {scenestart}.size)
	if {titlestart} != 0 {
		dw ({titlestart}), ({titlestart} + {titlestart}.size)
	} else {
		dw 0,0
	}
	db ({unk0}), ({renderinit}), ({dd}), 0x00
}

macro n64dd_RoomEntry(roomstart) {
	dw ({roomstart}), ({roomstart} + {roomstart}.size)
}

constant FREE_SPACE(0x347E040)

//Define constants for all patches
constant DDHOOK_CODE1(0x00A87000)
constant DDHOOK_N64DD(0x00B8AEF0)
constant DDHOOK_OVL_EN_MAG(0x00E6C410)

constant DDHOOK_OVL_PLAYER_ACTOR(0x00BCDD10)
constant DDHOOK_OVL_KALEIDO_SCOPE(0x00BB1380)
constant DDHOOK_OVL_EFFECT_SS_STICK(0x00EAD430)
constant DDHOOK_OVL_ITEM_SHIELD(0x00DB2240)
constant DDHOOK_GAMEPLAY_KEEP(0x00F03000)
constant DDHOOK_ICON_ITEM_STATIC(0x007BD000)
constant DDHOOK_ICON_ITEM_24_STATIC(0x00846000)
constant DDHOOK_OVL_EN_OSSAN(0x00C6C7B0)
constant DDHOOK_OBJECT_PO_COMPOSER(0x0191C000)
constant DDHOOK_OBJECT_HIDAN_OBJECTS(0x01125000)
constant DDHOOK_OBJECT_BDOOR(0x01484000)
constant DDHOOK_OBJECT_MIZU_OBJECTS(0x0122C000)
constant DDHOOK_OBJECT_ICE_OBJECTS(0x012A2000)
constant DDHOOK_OBJECT_SPOT02_OBJECTS(0x013FD000)
constant DDHOOK_PARAMETER_STATIC(0x01A3C000)
constant DDHOOK_OBJECT_SD(0x01389000)
constant DDHOOK_OBJECT_FD2(0x0142E000)
constant DDHOOK_OVL_EN_FZ(0x00DFCC70)
constant DDHOOK_OVL_BG_VB_SIMA(0x00D16FB0)
constant DDHOOK_OVL_EN_WF(0x00ED8450)
constant DDHOOK_OVL_BOSS_FD(0x00CE68C0)
constant DDHOOK_OVL_BOSS_FD2(0x00D04A60)
constant DDHOOK_OVL_BG_HIDAN_CURTAIN(0x00C81B20)
constant DDHOOK_OBJECT_BOX(0x00FEB000)

//Disable 64DD detection
seek(DDHOOK_N64DD)
    ori v0,0,0
    jr ra
    nop

//Force English language
seek(0x3E)
    db "E"

//Force Disk GFX on Title Screen
seek(DDHOOK_OVL_EN_MAG + 0x176B)
    db 4

//All files to replace
n64dd_ImportFile(DDHOOK_CODE1 + 0xEB04A, EZLJ_SAVE_DATA,"../other/default_save_data.bin")

n64dd_ImportFile(DDHOOK_CODE1 + 0xE5974, EZLJ_MAP_MINIMAP_TABLE_LENGTH,"../other/code_overworld_minimap_table_length.bin")
n64dd_ImportFile(DDHOOK_CODE1 + 0xE59A4, EZLJ_MAP_MINIMAP_TABLE_OFFSET,"../other/code_overworld_minimap_table_offset.bin")
n64dd_ImportFile(DDHOOK_CODE1 + 0xE59D4, EZLJ_MAP_MINIMAP_TABLE_XPOS,"../other/code_overworld_minimap_table_xpos.bin")
n64dd_ImportFile(DDHOOK_CODE1 + 0xE5A04, EZLJ_MAP_MINIMAP_TABLE_YPOS,"../other/code_overworld_minimap_table_ypos.bin")
n64dd_ImportFile(DDHOOK_CODE1 + 0xE5A34, EZLJ_MAP_MINIMAP_TABLE_COMPASS,"../other/code_overworld_minimap_table_compass.bin")
n64dd_ImportFile(DDHOOK_CODE1 + 0xE5B58, EZLJ_MAP_MINIMAP_TABLE_WIDTH,"../other/code_overworld_minimap_table_width.bin")
n64dd_ImportFile(DDHOOK_CODE1 + 0xE5B88, EZLJ_MAP_MINIMAP_TABLE_HEIGHT,"../other/code_overworld_minimap_table_height.bin")

n64dd_ImportFile(0x00852000, DDHOOK_ICON_ITEM_FIELD_STATIC, "../images/icon_item_field_static.bin")
n64dd_ImportFile(0x00872000, DDHOOK_ICON_ITEM_NES_STATIC, "../images/icon_item_nes_static.bin")

n64dd_ImportFile(0x0089EC00 + 0x1800, DDHOOK_ITEM_NAME_STATIC_SLINGSHOT, "../images/item_name_static/item_name_static_slingshot_1800.bin")
n64dd_ImportFile(0x0089EC00 + 0x4400, DDHOOK_ITEM_NAME_STATIC_HAMMER, "../images/item_name_static/item_name_static_hammer_4400.bin")
n64dd_ImportFile(0x0089EC00 + 0xEC00, DDHOOK_ITEM_NAME_STATIC_SWORD1, "../images/item_name_static/item_name_static_sword1_EC00.bin")
n64dd_ImportFile(0x0089EC00 + 0xF800, DDHOOK_ITEM_NAME_STATIC_SHIELD1, "../images/item_name_static/item_name_static_shield1_F800.bin")
n64dd_ImportFile(0x0089EC00 + 0xFC00, DDHOOK_ITEM_NAME_STATIC_SHIELD2, "../images/item_name_static/item_name_static_shield2_FC00.bin")
n64dd_ImportFile(0x0089EC00 + 0x10400, DDHOOK_ITEM_NAME_STATIC_TUNIC1, "../images/item_name_static/item_name_static_tunic1_10400.bin")
n64dd_ImportFile(0x0089EC00 + 0x10800, DDHOOK_ITEM_NAME_STATIC_TUNIC2, "../images/item_name_static/item_name_static_tunic2_10800.bin")
n64dd_ImportFile(0x0089EC00 + 0x11000, DDHOOK_ITEM_NAME_STATIC_BOOTS1, "../images/item_name_static/item_name_static_boots1_11000.bin")
n64dd_ImportFile(0x0089EC00 + 0x14000, DDHOOK_ITEM_NAME_STATIC_BRACELET, "../images/item_name_static/item_name_static_bracelet_14000.bin")

n64dd_ImportFile(0x00967000, DDHOOK_MAP_GRAND_STATIC, "../images/map_grand_static.bin")
n64dd_ImportFile(0x00A65000, DDHOOK_MAP_48X85_STATIC, "../images/map_48x85_static.bin")
n64dd_ImportFile(0x01638000, DDHOOK_OBJECT_GI_CLOTHES, "../object/object_gi_clothes.bin")
n64dd_ImportFile(0x01791000, DDHOOK_OBJECT_GI_BRACELET, "../object/object_gi_bracelet.bin")
n64dd_ImportFile(0x00F6D000, DDHOOK_GAMEPLAY_DANGEON_KEEP, "../object/gameplay_dangeon_keep.bin")
n64dd_ImportFile(0x00FBE000, DDHOOK_OBJECT_LINK_CHILD, "../object/object_link_child.bin")
n64dd_ImportFile(0x013C8000, DDHOOK_OBJECT_FD, "../object/object_fd.ntsc.bin")

n64dd_ImportFile(0x008BE000 + 0x5800, DDHOOK_MAP_NAME_STATIC_LAND, "../images/map_name_static/map_name_static_landdawndusk_5800.bin")
n64dd_ImportFile(0x008BE000 + 0x16400, DDHOOK_MAP_NAME_STATIC_DAWN, "../images/map_name_static/map_name_static_dawnside.bin")
n64dd_ImportFile(0x008BE000 + 0x19600, DDHOOK_MAP_NAME_STATIC_DUSK, "../images/map_name_static/map_name_static_duskside.bin")

n64dd_ImportFile(0x026B3000, EZLJ_SCENE3E, "../scene/Grottos.zscene")
n64dd_ImportFile(0x02710000, EZLJ_SCENE3E_MAP13, "../scene/Grottos Room 13.zmap")

n64dd_ImportFile(0x0000D390, EZLJ_AUDIOBANK0,"../audio/audiobank.dawn.0.bin") // 1.0 & 1.1
n64dd_ImportFile(0x00029DE0, EZLJ_AUDIOSEQ,"../audio/audioseq.dawn.bin")

n64dd_ImportFile(DDHOOK_CODE1 + 0x102860, EZLJ_AUDIOBANK_TABLE,"../audio/audiobank.dawn.table.bin")
n64dd_ImportFile(DDHOOK_CODE1 + 0x102AD0, EZLJ_AUDIOINST_TABLE,"../audio/audioinst.dawn.table.bin")
n64dd_ImportFile(DDHOOK_CODE1 + 0x102C90, EZLJ_AUDIOSEQ_TABLE,"../audio/audioseq.dawn.table.bin")

seek(DDHOOK_CODE1 + 0xFDBAC)
insert EZLJ_NES_MESSAGE_TABLE,"../text/MessageTable.tbl",0
seek(0x0092D000)
insert EZLJ_NES_MESSAGE_DATA_STATIC,"../text/StringData.bin",0,0x038100

//All files to import
seek(FREE_SPACE)
insert DDHOOK_OBJECT_GI_SHIELD1,"../object/object_gi_shield_1.bin"
insert DDHOOK_OBJECT_GI_SHIELD2,"../object/object_gi_shield_2.bin"

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
include "EZLJ_DISK_FileSystemPatch.asm"

//Deal with Scene Table
constant DDHOOK_SCENETABLE(DDHOOK_CODE1 + 0xEA600)
include "EZLJ_DISK_SceneList.asm"

include "EZLJ_DISK_PatchGeneric.asm"
include "EZLJ_DISK_Patch1.asm"
