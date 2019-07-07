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

//Minimap Tables
dw 0x800F6854, EZLJ_MAP_MINIMAP_TABLE_LENGTH.size
insert EZLJ_MAP_MINIMAP_TABLE_LENGTH,"../other/code_overworld_minimap_table_length.bin"
dw 0x800F6884, EZLJ_MAP_MINIMAP_TABLE_OFFSET.size
insert EZLJ_MAP_MINIMAP_TABLE_OFFSET,"../other/code_overworld_minimap_table_offset.bin"
dw 0x800F68B4, EZLJ_MAP_MINIMAP_TABLE_XPOS.size
insert EZLJ_MAP_MINIMAP_TABLE_XPOS,"../other/code_overworld_minimap_table_xpos.bin"
dw 0x800F68E4, EZLJ_MAP_MINIMAP_TABLE_YPOS.size
insert EZLJ_MAP_MINIMAP_TABLE_YPOS,"../other/code_overworld_minimap_table_ypos.bin"
dw 0x800F6914, EZLJ_MAP_MINIMAP_TABLE_COMPASS.size
insert EZLJ_MAP_MINIMAP_TABLE_COMPASS,"../other/code_overworld_minimap_table_compass.bin"
dw 0x800F6A38, EZLJ_MAP_MINIMAP_TABLE_WIDTH.size
insert EZLJ_MAP_MINIMAP_TABLE_WIDTH,"../other/code_overworld_minimap_table_width.bin"
dw 0x800F6A68, EZLJ_MAP_MINIMAP_TABLE_HEIGHT.size
insert EZLJ_MAP_MINIMAP_TABLE_HEIGHT,"../other/code_overworld_minimap_table_height.bin"

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
//-Repoint Display Lists
//code
dw (0x800110A0 + 0x6922C), 8, 0x3C0F0602, 0x25EFC208        //Goron Bracelet

dw (0x800110A0 + 0x6A80C), 8, 0x3C0A0602, 0x254ABF30        //Deku Stick

dw (0x800110A0 + 0xE671C + (0x10 * 0)), 4, 0x06017E90       //Right Fist
dw (0x800110A0 + 0xE671C + (0x10 * 1)), 4, 0x0601F7B0       //Right Fist + Deku Shield
dw (0x800110A0 + 0xE671C + (0x10 * 2)), 4, 0x06017E90       //Right Fist + Hylian Shield
dw (0x800110A0 + 0xE671C + (0x10 * 3)), 4, 0x06017E90       //Right Fist + Mirror Shield
dw (0x800110A0 + 0xE671C + (0x10 * 4)), 4, 0x0601F6F0       //Sheathed Sword
dw (0x800110A0 + 0xE671C + (0x10 * 5)), 4, 0x0601F758       //Deku Shield + Sheathed Sword
dw (0x800110A0 + 0xE671C + (0x10 * 6)), 4, 0x0601F738       //Hylian Shield + Sheathed Sword
dw (0x800110A0 + 0xE671C + (0x10 * 7)), 4, 0x0601F6F0       //Mirror Shield + Sheathed Sword
dw (0x800110A0 + 0xE671C + (0x10 * 8)), 4, 0                //?
dw (0x800110A0 + 0xE671C + (0x10 * 9)), 4, 0x0601F718       //Deku Shield without Sheath
dw (0x800110A0 + 0xE671C + (0x10 * 9) + 8), 4, 0x0601F718   //Deku Shield without Sheath
dw (0x800110A0 + 0xE671C + (0x10 * 10)), 4, 0x060180A0      //Sword Sheath
dw (0x800110A0 + 0xE671C + (0x10 * 11)), 4, 0x0601F768      //Deku Shield + Sheath
dw (0x800110A0 + 0xE671C + (0x10 * 12)), 4, 0x0601F748      //Hylian Shield + Sheath
dw (0x800110A0 + 0xE671C + (0x10 * 13)), 4, 0x060180A0      //Mirror Shield + Sheath
dw (0x800110A0 + 0xE671C + (0x10 * 14)), 4, 0               //?
dw (0x800110A0 + 0xE671C + (0x10 * 15)), 4, 0x0601F718      //Deku Shield without Sheath
dw (0x800110A0 + 0xE671C + (0x10 * 15) + 8), 4, 0x0601F718  //Deku Shield without Sheath
dw (0x800110A0 + 0xE671C + (0x10 * 16)), 4, 0x0601F790      //Left Fist + Biggoron Sword
dw (0x800110A0 + 0xE671C + (0x10 * 17)), 4, 0x0601F790      //Left Fist + Broken Giant`s Knife
dw (0x800110A0 + 0xE671C + (0x10 * 18)), 4, 0x06016090      //Left Hand
dw (0x800110A0 + 0xE671C + (0x10 * 19)), 4, 0x06016458      //Left Fist
dw (0x800110A0 + 0xE671C + (0x10 * 20)), 4, 0x0601F778      //Left Fist + Kokiri Sword
dw (0x800110A0 + 0xE671C + (0x10 * 21)), 4, 0x0601F778      //Left Fist + Master Sword
dw (0x800110A0 + 0xE671C + (0x10 * 22)), 4, 0x06017AD0      //Right Hand
dw (0x800110A0 + 0xE671C + (0x10 * 23)), 4, 0x06017E90      //Right Fist
dw (0x800110A0 + 0xE671C + (0x10 * 24)), 4, 0x0601F7C0      //Right Fist + Fairy Slingshot (and/or Fairy Bow?)
dw (0x800110A0 + 0xE671C + (0x10 * 25)), 4, 0x0601F6F0      //Sheathed Sword
dw (0x800110A0 + 0xE671C + (0x10 * 26)), 4, 0x060180A0      //Sword Sheath
dw (0x800110A0 + 0xE671C + (0x10 * 27)), 4, 0x06011A80      //Waist
dw (0x800110A0 + 0xE671C + (0x10 * 28)), 4, 0x0601F7C0      //Right Fist + Fairy Slingshot (and/or Fairy Bow?)
dw (0x800110A0 + 0xE671C + (0x10 * 29)), 4, 0x0601F7D0      //Right Hand + Fairy Ocarina
dw (0x800110A0 + 0xE671C + (0x10 * 30)), 4, 0x0601F7E0      //Right Hand + Ocarina of Time
dw (0x800110A0 + 0xE671C + (0x10 * 31)), 4, 0x06017E90      //Right Fist + Hookshot
dw (0x800110A0 + 0xE671C + (0x10 * 32)), 4, 0x06022100      //Left Fist + Megaton Hammer
dw (0x800110A0 + 0xE671C + (0x10 * 33)), 4, 0x0601F7A0      //Left Fist + Boomerang
dw (0x800110A0 + 0xE671C + (0x10 * 34)), 4, 0x06016EB8      //Outstretched Left Hand for Holding Bottles
dw (0x800110A0 + 0xE671C + (0x10 * 35)), 4, 0               //FPS Left Forearm (Adult Link)
dw (0x800110A0 + 0xE671C + (0x10 * 35) + 8), 4, 0           //FPS Left Hand (Adult Link)
dw (0x800110A0 + 0xE671C + (0x10 * 36)), 4, 0x06017340      //Right Shoulder
dw (0x800110A0 + 0xE671C + (0x10 * 36) + 8), 4, 0           //FPS Right Forearm (Adult Link)
dw (0x800110A0 + 0xE671C + (0x10 * 37)), 4, 0x0601F7F0      //FPS Right Arm + Fairy Slingshot

dw (0x800110A0 + 0xE6B2C), 4, 0x060194A8                    //Empty Bottle

dw (0x800110A0 + 0xE6B74), 4, 0x0601C3C8                    //Fairy Slingshot String

//ovl_player_actor
dw (DDHOOK_OVL_PLAYER_ACTOR + 0x2253C), 0x20
dw 0x0601D108, 0x0601C878, 0x0601CC68, 0x0601F290
dw 0x0601D9F8, 0x0601DF48, 0x0601E990, 0x0601D538

//dw (DDHOOK_OVL_PLAYER_ACTOR + 0x2139C), 8
//dw 0x14804599, 0x00C61080

//ovl_Effect_Ss_Stick
dw (DDHOOK_OVL_EFFECT_SS_STICK + 0x334), 4, 0x0601BF30      //Deku Stick

//ovl_Item_Shield
dw (DDHOOK_OVL_ITEM_SHIELD + 0x7EC), 8                      //Deku Shield
dw 0x3C050602, 0x24A59D58

//---Enable Megaton Hammer rendering for Child Link
dw (DDHOOK_OVL_PLAYER_ACTOR + 0x184FC), 4
dw 0x1000000B

//---Object gameplay_keep
//TODO Just take original file and change Link`s hair 0x1A40 (DBG and 1.0)

//---ovl_kaleido_scope
//Item Usability / Highlight Tables
dw (DDHOOK_OVL_KALEIDO_SCOPE + 0x165B4), EZLJ_ITEM_USABILITY_TABLE.size
insert EZLJ_ITEM_USABILITY_TABLE,"../other/pause_item_usability.bin"

//---Get Item
//Wooden Shield GI
dw (0x800110A0 + 0xDED90 + (0x24*0x1C) + 4), 4
dw 0x06000A88

//Metal Shield GI (is not rendering)
dw (0x800110A0 + 0xDED90 + (0x24*0x2B) + 4), 4
dw 0x06001238

//Ruto`s Letter GI hack
dw (0x800110A0 + 0xDED90 + (0x24*0x44)), 0xC
dw 0x800582C0, 0x06000AE0, 0x00000000

//Ruto`s Letter GI to Empty Bottle GI
dw (DDHOOK_OVL_PLAYER_ACTOR + 0x21324 + (0x14*6)), 0x8
dw 0x14800142, 0x00C61080

//---icon_item_static
dw (DDHOOK_ICON_ITEM_STATIC + 0x3E000), EZLJ_ICON_ITEM_STATIC_SHIELD1.size
insert EZLJ_ICON_ITEM_STATIC_SHIELD1,"../images/icon_item_static/icon_item_static_shield1_3E000.bin"
dw (DDHOOK_ICON_ITEM_STATIC + 0x3F000), EZLJ_ICON_ITEM_STATIC_SHIELD2.size
insert EZLJ_ICON_ITEM_STATIC_SHIELD2,"../images/icon_item_static/icon_item_static_shield2_3F000.bin"
dw (DDHOOK_ICON_ITEM_STATIC + 0x41000), EZLJ_ICON_ITEM_STATIC_TUNIC1.size
insert EZLJ_ICON_ITEM_STATIC_TUNIC1,"../images/icon_item_static/icon_item_static_tunic1_41000.bin"
dw (DDHOOK_ICON_ITEM_STATIC + 0x42000), EZLJ_ICON_ITEM_STATIC_TUNIC2.size
insert EZLJ_ICON_ITEM_STATIC_TUNIC2,"../images/icon_item_static/icon_item_static_tunic2_42000.bin"
dw (DDHOOK_ICON_ITEM_STATIC + 0x50000), EZLJ_ICON_ITEM_STATIC_BRACELET.size
insert EZLJ_ICON_ITEM_STATIC_BRACELET,"../images/icon_item_static/icon_item_static_bracelet_50000.bin"

//---icon_item_24_static
dw (DDHOOK_ICON_ITEM_24_STATIC + 0x6300), 0x10000900    //Patch out that boss icon
dw 0

//---ovl_En_Ossan (Goron Shop)
dw (DDHOOK_OVL_EN_OSSAN + 0x5AF0), 0x3C
dw 0x000D0032, 0x0034FFEC, 0x00000032, 0x004CFFEC
dw 0x00040050, 0x0034FFFD, 0x00050050, 0x004CFFFD
dw 0x001DFFCE, 0x0034FFEC, 0x0008FFCE, 0x004CFFEC
dw 0x0009FFB0, 0x0034FFFD, 0x002BFFB0

//---object_po_composer
dw (DDHOOK_OBJECT_PO_COMPOSER + 0x2D18), 0x10000028
dw 0
dw (DDHOOK_OBJECT_PO_COMPOSER + 0x4458), 0x10000010
dw 0
dw (DDHOOK_OBJECT_PO_COMPOSER + 0x4478), 0x10000018
dw 0

dw (DDHOOK_OBJECT_PO_COMPOSER + 0x56E0), EZLJ_OBJECT_PO_COMPOSER_TEX0.size
insert EZLJ_OBJECT_PO_COMPOSER_TEX0,"../object/object_po_composer/object_po_composer_tex_56E0.bin"

dw (DDHOOK_OBJECT_PO_COMPOSER + 0x68E0), EZLJ_OBJECT_PO_COMPOSER_TEX1.size
insert EZLJ_OBJECT_PO_COMPOSER_TEX1,"../object/object_po_composer/object_po_composer_tex_68E0.bin"

dw (DDHOOK_OBJECT_PO_COMPOSER + 0x6CE0), 0x10000200
dw 0

dw 0
EZLJ_PATCH0_END: