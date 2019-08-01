//64drive Specific Functions
arch n64.cpu
endian msb

include "N64.INC"
include "N64_GFX.INC"

constant ci_dbg_area(0xB3F00000)

insert "../dev/bootcode6102.bin"
fill 0x100000

macro DMARead(start, end, dest) { // DMA Data Copy Cart<-DRAM: Start Cart Address, End Cart Address, Destination DRAM Address
  lui a0,PI_BASE // A0 = PI Base Register ($A4600000)
  -
    lw t0,PI_STATUS(a0) // T0 = Word From PI Status Register ($A4600010)
    andi t0,3 // AND PI Status With 3
    bnez t0,- // IF TRUE DMA Is Busy
    nop // Delay Slot

  la t0,{dest}&$7FFFFF // T0 = Aligned DRAM Physical RAM Offset ($00000000..$007FFFFF 8MB)
  sw t0,PI_DRAM_ADDR(a0) // Store RAM Offset To PI DRAM Address Register ($A4600000)
  la t0,$10000000|({start}&$3FFFFFF) // T0 = Aligned Cart Physical ROM Offset ($10000000..$13FFFFFF 64MB)
  sw t0,PI_CART_ADDR(a0) // Store ROM Offset To PI Cart Address Register ($A4600004)
  la t0,({end}-{start})-1 // T0 = Length Of DMA Transfer In Bytes - 1
  sw t0,PI_RD_LEN(a0) // Store DMA Length To PI Write Length Register ($A460000C)
}

macro PISpin() {
    lui at,PI_BASE // A0 = PI Base Register ($A4600000)
  -
    lw s0,PI_STATUS(at) // T0 = Word From PI Status Register ($A4600010)
    andi s0,3 // AND PI Status With 3
    bnez s0,- // IF TRUE DMA Is Busy
    nop // Delay Slot
}

ci_rom:
origin 0x1000
base 0x80000400
    N64_INIT()

    lui a1,PI_BASE
    ori a0,0,0x40
    //ori a0,0,0x05
    sw a0,PI_BSD_DOM1_LAT(a1)
    sw a0,PI_BSD_DOM2_LAT(a1)
    ori a0,0,0x12
    //ori a0,0,0x0C
    sw a0,PI_BSD_DOM1_PWD(a1)
    sw a0,PI_BSD_DOM2_PWD(a1)
    ori a0,0,0x07
    //ori a0,0,0x0E
    sw a0,PI_BSD_DOM1_PGS(a1)
    sw a0,PI_BSD_DOM2_PGS(a1)
    ori a0,0,0x03
    //ori a0,0,0x02
    sw a0,PI_BSD_DOM1_RLS(a1)
    sw a0,PI_BSD_DOM2_RLS(a1)

    PISpin()
    ori a0,0,1
    jal ci_rom_writable
    nop
    //DMARead(ci_dbg_area, ci_dbg_area+8, string_list)
    jal ci_usb_print_test
    nop

ci_rom_spin:
    j ci_rom_spin
    nop


ci_rom_writable:
    //Argument
    //A0 = 0 = Disable, 1 = Enable
    xori a0,a0,1
    ori a0,a0,0xF0

    lui v0,0xB800

    //Spin until ready
    -; lw v1,0x200(v0)
    andi v1,v1,0x1000
    bnez v1,-
    nop

    sw a0,0x208(v0)
    nop

    //Spin until done
    -; lw v1,0x200(v0)
    andi v1,v1,0x1000
    bnez v1,-
    nop

    jr ra
    nop

ci_usb_print_test:
    addiu sp,sp,-0x20
    sw ra,0x20(sp)

    li a0,string_list
    jal ci_usb_printf
    nop

    lw ra,0x20(sp)
    addiu sp,sp,0x20
    jr ra
    nop        

ci_usb_printf:
    //Arguments
    //A0=Address to string
    addiu sp,sp,-0x20
    sw ra,0x20(sp)
    sw a0,0x1C(sp)

    li s2,ci_dbg_area
    addiu s1,0,1
    sw s1,0xFFFC(s2)

    ori a1,0,0
    //Read until zero
    -; lbu v0,0(a0)
    addiu a1,a1,1
    addiu a0,a0,1
    bnez v0,-
    nop

    //align size to 32 bit
    addiu a2,0,4
    andi a3,a1,3
    subu a2,a2,a3
    addu a1,a1,a2

    //Copy TEXT
    sw a1,0x18(sp)
    li a2,ci_dbg_area
    lw a0,0x1C(sp)

    -; lw v0,0(a0)
    nop
    sw v0,0(a2)
    nop
    lw v1,0(a2)
    bne v0,v1,-
    nop
    addiu a0,a0,4
    addiu a2,a2,4
    addiu a1,a1,-4
    bgtz a1,-
    nop

    addiu s1,0,2
    sw s1,0xFFFC(s2)


    //spin for write status
    lui v0,0xB800

    //Spin until ready
    -; lw v1,0x400(v0)
    bnez v1,-
    nop

    addiu s1,0,3
    sw s1,0xFFFC(s2)

    //Write to registers
    li a2,ci_dbg_area
    li t1,0x0FFFFFFF
    and a2,a2,t1
    sra a2,a2,1
    lui v1,0x0100
    lw a1,0x18(sp)
    or a1,a1,v1
    addiu v1,0,0x08


    addiu s1,0,4
    sw s1,0xFFFC(s2)

    sw a2,0x404(v0)
    sw a2,0x404(v0)
    sw a2,0x404(v0)
    sw a1,0x408(v0)
    sw a1,0x408(v0)
    sw a1,0x408(v0)

    //Do command
    sw v1,0x400(v0)
    sw v1,0x400(v0)
    sw v1,0x400(v0)

    //Spin until ready
    -; lw v1,0x400(v0)
    bnez v1,-
    nop

    addiu s1,0,5
    sw s1,0xFFFC(s2)

    lw ra,0x20(sp)
    addiu sp,sp,0x20
    jr ra
    nop

string_list:
    db "TEST",0,0,0,0