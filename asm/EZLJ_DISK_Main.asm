//Zelda 64 Dawn & Dusk - Expansion Disk
//By LuigiBlood

//Uses ARM9 bass

//Main Disk Assembly

print "Assembling Custom Zelda Disk Expansion...\n"

if {defined DEV} {
	print "Development Version - "
	define LBA0_OFFSET(0x738C0)
} else if {defined D64} {
	print "Master Disk Image - "
	define NOFILL()
	define LBA0_OFFSET(0)
} else {
	print "Retail Version - "
	define LBA0_OFFSET(0x738C0)
}

if !{defined D64} {
	if {defined USA} {
		print "USA Region\n"
		output "../EZLE_DawnDusk.ndd", create
	} else {
		print "JPN Region\n"
		output "../EZLJ_DawnDusk.ndd", create
	}
} else {
	if {defined USA} {
		print "USA Region\n"
		output "../EZLE_DawnDusk.rom", create
	} else {
		print "JPN Region\n"
		output "../EZLJ_DawnDusk.rom", create
	}
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

//CHANGE THIS WHEN YOU ARE MAKING ANOTHER DISK (must NOT be 0)
constant EZLJ_SAVE_ID(0x4441574E)		//"DAWN"

if !{defined NOFILL} {
  print "- Fill Disk Data...\n"
  seek(0x0)
  fill 0x3DEC800
}

include "EZLJ_DISK_RAM.asm"
include "EZLJ_DISK_FileSystem.asm"
include "EZLJ_DISK_FileSystemPatch.asm"

//LBA 24 - 64DD IPL Boot
include "EZLJ_DISK_Boot.asm"

//LBA 25 - Zelda Disk
include "EZLJ_DISK_Hook.asm"

include "EZLJ_DISK_System.asm"

print "- Done!\n"
