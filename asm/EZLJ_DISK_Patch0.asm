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


//Object List
//gameplay_dangeon_keep - TODO: move to RAM
dw (0x800F8FF0 + 8 + (0x03 * 8)), 8
dw (EZLJ_GAMEPLAY_DANGEON_KEEP + 0xC0000000), (EZLJ_GAMEPLAY_DANGEON_KEEP + 0xC0000000 + EZLJ_GAMEPLAY_DANGEON_KEEP.size)

//object_link_child - TODO: move to RAM
dw (0x800F8FF0 + 8 + (0x15 * 8)), 8
dw (EZLJ_OBJECT_LINK_CHILD + 0xC0000000), (EZLJ_OBJECT_LINK_CHILD + 0xC0000000 + EZLJ_OBJECT_LINK_CHILD.size)

//Actor Overlay Table
//ovl_Item_Shield
dw (0x800E8530 + (0x10 * 0xEE)), 8
dw (DDHOOK_OVL_ITEM_SHIELD), (DDHOOK_OVL_ITEM_SHIELD + 0xA10)

//Pause/Player Overlay Table
//ovl_kaleido_scope
dw (0x800FE480 + 4), 8
dw (DDHOOK_OVL_KALEIDO_SCOPE), (DDHOOK_OVL_KALEIDO_SCOPE + 0x1C990)
//ovl_player_actor
dw (0x800FE480 + 0x1C + 4), 8
dw (DDHOOK_OVL_PLAYER_ACTOR), (DDHOOK_OVL_PLAYER_ACTOR + 0x26560)

//Particle Overlay Table
//ovl_Effect_Ss_Stick
dw (0x800E7C40 + (0x1C * 0x10)), 8
dw (DDHOOK_OVL_EFFECT_SS_STICK), (DDHOOK_OVL_EFFECT_SS_STICK + 0x3A0)

//Setup Link (Child) Optimized (by CrookedPoe)
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
dw (0x800110A0 + 0xE671C + (0x10 * 32)), 4, 0x06016458      //Left Fist + Megaton Hammer
dw (0x800110A0 + 0xE671C + (0x10 * 33)), 4, 0x0601F7A0      //Left Fist + Boomerang
dw (0x800110A0 + 0xE671C + (0x10 * 34)), 4, 0x06016EB8      //Outstretched Left Hand for Holding Bottles
dw (0x800110A0 + 0xE671C + (0x10 * 35)), 4, 0               //FPS Left Forearm (Adult Link)
dw (0x800110A0 + 0xE671C + (0x10 * 35) + 8), 4, 0           //FPS Left Hand (Adult Link)
dw (0x800110A0 + 0xE671C + (0x10 * 36)), 4, 0x06017340      //Right Shoulder
dw (0x800110A0 + 0xE671C + (0x10 * 36) + 8), 4, 0           //FPS Right Forearm (Adult Link)
dw (0x800110A0 + 0xE671C + (0x10 * 37)), 4, 0x0601F7F0      //FPS Right Arm + Fairy Slingshot

dw (0x800110A0 + 0xE671C + 0x410), 4, 0x060194A8            //Empty Bottle

dw (0x800110A0 + 0xE6B74), 4, 0x0601C3C8                    //Fairy Slingshot String

//ovl_player_actor
dw (DDHOOK_OVL_PLAYER_ACTOR + 0x2253C), 0x20
dw 0x0601D108, 0x0601C878, 0x0601CC68, 0x0601F290
dw 0x0601D9F8, 0x0601DF48, 0x0601E990, 0x0601D538

dw (DDHOOK_OVL_PLAYER_ACTOR + 0x184FC), 4
dw 0x1000000B

dw (DDHOOK_OVL_PLAYER_ACTOR + 0x2139C), 8
dw 0x14804599, 0x00C61080

//ovl_Effect_Ss_Stick
dw (DDHOOK_OVL_EFFECT_SS_STICK + 0x334), 4, 0x0601BF30      //Deku Stick

//ovl_Item_Shield
dw (DDHOOK_OVL_ITEM_SHIELD + 0x7EC), 8                      //Deku Shield
dw 0x35050602, 0x24A59D58

//---Object gameplay_keep
//TODO Just take original file and change Link`s hair 0x1A40 (DBG and 1.0)

//---ovl_kaleido_scope
//Item Usability / Highlight Tables
dw (DDHOOK_OVL_KALEIDO_SCOPE + 0x165B4), EZLJ_ITEM_USABILITY_TABLE.size
insert EZLJ_ITEM_USABILITY_TABLE,"../other/pause_item_usability.bin"

//icon_item_field_static
dw (DDHOOK_OVL_KALEIDO_SCOPE + 0x12FB4), 0x10
dw (0x3C050000 + DDHOOK_ICON_ITEM_FIELD_STATIC.shi), (0x3C0F0000 + DDHOOK_ICON_ITEM_FIELD_STATIC.ehi)
dw (0x25EF0000 + DDHOOK_ICON_ITEM_FIELD_STATIC.elo), (0x24A50000 + DDHOOK_ICON_ITEM_FIELD_STATIC.slo)
//dw 0x3C050085, 0x3C0F0086, 0x25EFD930, 0x24A52000

//icon_item_nes_static
dw (DDHOOK_OVL_KALEIDO_SCOPE + 0x14520), 0x10
dw (0x3C050000 + DDHOOK_ICON_ITEM_NES_STATIC.shi), (0x24A50000 + DDHOOK_ICON_ITEM_NES_STATIC.slo)
dw 0x15E0000B, (0x3C0E0000 + DDHOOK_ICON_ITEM_NES_STATIC.ehi)
//dw 0x3C050087, 0x24A52000, 0x15E0000B, 0x3C0E0088

dw (DDHOOK_OVL_KALEIDO_SCOPE + 0x14558), 0x4
dw (0x25CE0000 + DDHOOK_ICON_ITEM_NES_STATIC.elo)
//dw 0x25CEFC80

dw 0
EZLJ_PATCH0_END: