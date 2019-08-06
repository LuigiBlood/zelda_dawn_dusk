@IF NOT EXIST "CZLJ01_D.z64" @goto :notexist
@IF EXIST "CZLJ_DawnDusk.z64" del "CZLJ_DawnDusk.z64"
bass ./asm/CZLJ01_Patch.asm
.\dev\rn64crc.exe -u CZLJ_DawnDusk.z64
@goto :end

:notexist
@echo You need Decompressed NTSC 1.1 ROM as "CZLJ01_D.z64" in root folder to use this.
@pause
:end