//Patch for uncompressed Ocarina of Time NTSC 1.0
//Access RAM Area instead of ROM Area LBA 1

arch n64.cpu
endian msb

include "N64.INC"
include "N64_GFX.INC"

output "../CZLJ_DawnDusk.z64", create

insert "../dev/CZLJ00_D.z64"

origin 0xB8AD30
base 0x801C6E80

//Disk Type 0,1,2,3,4,5,6
//0x18CF180, 0x2156880, 0x2928040, 0x30438C0, 0x36A9200, 0x3B9ED00, 0x3D78F40

origin 0xB95EF0
add_offset:
    li at,(0x2928040 - 0x4D08)
    //origin ({n} + 0x2928040 + 0x738C0 + 2)
    addu a1,a1,at
    or s0,a1,0
    or s1,a2,0
    jr ra
    nop

origin (0xB8AD30 + 0xD9C + 0xC)
    sw ra,0x1C(sp)
    jal add_offset
    nop

origin 0xB9CCD0
    db "DSCJ",0,0,0,0
    db "EZLJ",0,0,0,0
