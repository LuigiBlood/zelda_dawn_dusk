//Simulate Disk from ROM (0x0347E040)
arch n64.cpu
endian msb

include "N64.INC"
include "N64_GFX.INC"

macro seekRAM(addr) {
    origin ({addr} - 0x801C6E80 + 0xB8AD30)
}

output "../CZLJ_DawnDusk.z64", create

insert "../dev/CZLJ00_D.z64"

origin 0xB8AD30
base 0x801C6E80

//801C6E80 + 8
seekRAM(0x801CE120)
    //li v0,0x01000100
    //li v1,0x80121210
    //sb v0,0(v1)

    //ori v0,0,1
    //jr ra
    //nop


//801C7C1C
origin (0xB8AD30 + 0xD9C)
    addiu sp,sp,-0x20
    sw ra,0x20(sp)
    li a3,EZLJ_DATA
    addu a1,a1,a3

    jal 0x80000DF0  //DMA ROM to RAM
    nop

    lw ra,0x20(sp)
    addiu sp,sp,0x20
    jr ra
    nop

//check out 801C8424

seekRAM(0x801C81D4)
//ori v0,0,1
//jr ra
//nop

//origin (0xBA1160 + 0x110 + 0x18)
    //nop

origin 0x347E040
base 0x347E040
insert EZLJ_DATA,"../EZLJ_DawnDusk.ndd",0x785C8,0x881FC0

origin 0xD280
dw EZLJ_DATA, EZLJ_DATA + EZLJ_DATA.size, EZLJ_DATA, 0

origin 0xB9CCD0
    db "DSCJ",0,0,0,0
    db "EZLJ",0,0,0,0