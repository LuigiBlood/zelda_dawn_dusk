//Zelda 64 Dawn & Dusk - Expansion Disk
//By LuigiBlood

//Uses ARM9 bass

//Filesystem Patching

print "- Patch Game Files...\n"

//Change Room Addresses
seekDisk(EZLJ_SCENE07 + 0x60)
n64dd_RoomEntry(EZLJ_SCENE07_MAP00)

seekDisk(EZLJ_SCENE09 + 0x70)
n64dd_RoomEntry(EZLJ_SCENE09_MAP00)
n64dd_RoomEntry(EZLJ_SCENE09_MAP01)
n64dd_RoomEntry(EZLJ_SCENE09_MAP02)
n64dd_RoomEntry(EZLJ_SCENE09_MAP03)
n64dd_RoomEntry(EZLJ_SCENE09_MAP04)
n64dd_RoomEntry(EZLJ_SCENE09_MAP05)

seekDisk(EZLJ_SCENE15 + 0x60)
n64dd_RoomEntry(EZLJ_SCENE15_MAP00)

seekDisk(EZLJ_SCENE2C + 0x60)
n64dd_RoomEntry(EZLJ_SCENE2C_MAP00)

seekDisk(EZLJ_SCENE2E + 0x60)
n64dd_RoomEntry(EZLJ_SCENE2E_MAP00)

seekDisk(EZLJ_SCENE34 + 0x70)
n64dd_RoomEntry(EZLJ_SCENE34_MAP00)
n64dd_RoomEntry(EZLJ_SCENE34_MAP01)
n64dd_RoomEntry(EZLJ_SCENE34_MAP02)
n64dd_RoomEntry(EZLJ_SCENE34_MAP03)
n64dd_RoomEntry(EZLJ_SCENE34_MAP04)
n64dd_RoomEntry(EZLJ_SCENE34_MAP05)

seekDisk(EZLJ_SCENE35 + 0x60)
n64dd_RoomEntry(EZLJ_SCENE35_MAP00)

seekDisk(EZLJ_SCENE52 + 0x60)
n64dd_RoomEntry(EZLJ_SCENE52_MAP00)

seekDisk(EZLJ_SCENE54 + 0x70)
n64dd_RoomEntry(EZLJ_SCENE54_MAP00)
n64dd_RoomEntry(EZLJ_SCENE54_MAP01)
n64dd_RoomEntry(EZLJ_SCENE54_MAP02)

seekDisk(EZLJ_SCENE55 + 0x70)
n64dd_RoomEntry(EZLJ_SCENE55_MAP00)

seekDisk(EZLJ_SCENE59 + 0x70)
n64dd_RoomEntry(EZLJ_SCENE59_MAP00)

seekDisk(EZLJ_SCENE5B + 0x70)
n64dd_RoomEntry(EZLJ_SCENE5B_MAP00)
n64dd_RoomEntry(EZLJ_SCENE5B_MAP01)
n64dd_RoomEntry(EZLJ_SCENE5B_MAP02)

seekDisk(EZLJ_SCENE60 + 0x60)
n64dd_RoomEntry(EZLJ_SCENE60_MAP00)
