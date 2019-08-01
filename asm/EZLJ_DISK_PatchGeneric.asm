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

include "../patch/parameter_static.patch"

include "../patch/object_po_composer.patch"
include "../patch/object_hidan_objects.patch"
include "../patch/object_bdoor.patch"
include "../patch/object_mizu_objects.patch"
include "../patch/object_ice_objects.patch"
include "../patch/object_spot02_objects.patch"
include "../patch/object_sd.patch"
include "../patch/object_fd2.patch"
include "../patch/object_box.patch"

include "../patch/ovl_kaleido_scope.all.patch"
include "../patch/ovl_En_Ossan.all.patch"
include "../patch/ovl_En_Fz.all.patch"
include "../patch/ovl_Bg_Vb_Sima.all.patch"
include "../patch/ovl_En_Wf.all.patch"
include "../patch/ovl_Boss_Fd.all.patch"
include "../patch/ovl_Boss_Fd2.all.patch"
include "../patch/ovl_Bg_Hidan_Curtain.all.patch"
dw 0
EZLJ_PATCH_ALL_END: