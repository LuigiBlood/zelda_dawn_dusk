//Zelda Expansion Disk
//By LuigiBlood

//Uses ARM9 bass

//Scene Entries
EZLJ_SCENELIST: {
	n64dd_SceneEntry("Cave Passage",		EZLJ_SCENE07, 0x00000000, 0x00, 0x00, 0x07)
	n64dd_SceneEntry("Red Ice Cavern",		EZLJ_SCENE09, EZLJ_SCENENAME09, 0x00, 0x00, 0x09)
	n64dd_SceneEntry("Dusk Palace Chamber",	EZLJ_SCENE15, 0x00000000, 0x00, 0x1D, 0x15)
	n64dd_SceneEntry("Dawngrove House 1",	EZLJ_SCENE2C, 0x00000000, 0x00, 0x00, 0x2C)
	n64dd_SceneEntry("Dawngrove Shop",		EZLJ_SCENE2E, 0x00000000, 0x00, 0x00, 0x2E)
	n64dd_SceneEntry("Dawngrove Inn",		EZLJ_SCENE34, 0x00000000, 0x00, 0x00, 0x34)
	n64dd_SceneEntry("Dawngrove House 2",	EZLJ_SCENE35, 0x00000000, 0x00, 0x00, 0x35)
	n64dd_SceneEntry("Great Dusk Chasm",	EZLJ_SCENE54, EZLJ_SCENENAME54, 0x00, 0x00, 0x54)
	n64dd_SceneEntry("Dawngrove Village",	EZLJ_SCENE55, EZLJ_SCENENAME55, 0x00, 0x09, 0x55)
	n64dd_SceneEntry("Dusk Palace Gardens",	EZLJ_SCENE59, EZLJ_SCENENAME59, 0x00, 0x2E, 0x59)
	n64dd_SceneEntry("Dawngrove",			EZLJ_SCENE5B, EZLJ_SCENENAME5B, 0x00, 0x2E, 0x5B)
	n64dd_SceneEntry("Cutscene Map",		EZLJ_SCENE60, 0x00000000, 0x00, 0x00, 0x60)
}
EZLJ_SCENELIST_END:
constant EZLJ_SCENELIST_SIZE(EZLJ_SCENELIST_END - EZLJ_SCENELIST)
