//Zelda Expansion Disk
//By LuigiBlood

//Uses ARM9 bass

//Filesystem

print "- Insert Game Files...\n"

seekDisk(0)
base 0

seekDisk(0x4D08)
//Error Screens (Hardcoded, do not move them)
insert EZLJ_ERROR_IPL,"../images/EZLJ_error_IPL.bin"
insert EZLJ_ERROR_VER,"../images/EZLJ_error_version.bin"

//Audio
insert EZLJ_AUDIOBANK0,"../audio/audiobank.dawn.0.bin" // 1.0
//insert EZLJ_AUDIOBANK1,"../audio/audiobank.dawn.1.bin" //1.1 TODO
insert EZLJ_AUDIOBANK2,"../audio/audiobank.dawn.2.bin" // 1.2
insert EZLJ_AUDIOSEQ,"../audio/audioseq.dawn.bin"
insert EZLJ_AUDIOBANK_TABLE,"../audio/audiobank.dawn.table.bin"
insert EZLJ_AUDIOINST_TABLE,"../audio/audioinst.dawn.table.bin"
insert EZLJ_AUDIOSEQ_TABLE,"../audio/audioseq.dawn.table.bin"

//Code / Other
insert EZLJ_ENTRANCE_TABLE,"../other/code_entrance_table.bin"
insert EZLJ_SAVE_DATA,"../other/default_save_test.bin"

//Text
insert EZLJ_NES_MESSAGE_TABLE,"../text/ezlj_nes_message_table.bin"
insert EZLJ_NES_MESSAGE_DATA_STATIC,"../text/ezlj_nes_message_data_static.bin"

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

insert EZLJ_SCENE34,"../scene/Dawngrove Inn.zscene"
insert EZLJ_SCENE34_MAP00,"../scene/Dawngrove Inn Room 0.zmap"
insert EZLJ_SCENE34_MAP01,"../scene/Dawngrove Inn Room 1.zmap"
insert EZLJ_SCENE34_MAP02,"../scene/Dawngrove Inn Room 2.zmap"
insert EZLJ_SCENE34_MAP03,"../scene/Dawngrove Inn Room 3.zmap"
insert EZLJ_SCENE34_MAP04,"../scene/Dawngrove Inn Room 4.zmap"
insert EZLJ_SCENE34_MAP05,"../scene/Dawngrove Inn Room 5.zmap"

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
