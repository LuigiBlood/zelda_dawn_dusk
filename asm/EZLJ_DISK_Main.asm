//Zelda 64 Dawn & Dusk - Expansion Disk
//By LuigiBlood

//Uses ARM9 bass

//Main Disk Assembly

print "Assembling Custom Zelda Disk Expansion...\n"

if {defined DEV} {
	print "Development Version - "
} else {
	print "Retail Version - "
}

if {defined USA} {
	print "USA Region\n"
	output "../EZLE_DawnDusk.ndd", create
} else {
	print "JPN Region\n"
	output "../EZLJ_DawnDusk.ndd", create
}

if !{defined DISKTYPE} {
	define DISKTYPE(6)
}

if ({DISKTYPE} > 6) {
	error "\n\nERROR: Disk Type must be around 0-6.\n"
}

print "Disk Type - {DISKTYPE}\n"

arch n64.cpu
endian msb

include "N64.INC"
include "N64_GFX.INC"

include "EZLJ_DISK_Macros.asm"
include "EZLJ_DISK_RAM.asm"
include "EZLJ_DISK_System.asm"
include "EZLJ_DISK_FileSystem.asm"
include "EZLJ_DISK_FileSystemPatch.asm"

//LBA 24 - 64DD IPL Boot
include "EZLJ_DISK_Boot.asm"

//LBA 25 - Zelda Disk
include "EZLJ_DISK_Hook.asm"

print "- Done!\n"
