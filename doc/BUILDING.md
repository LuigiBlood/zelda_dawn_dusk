# Building

## Build Disk Expansion

To build the disk, ARM9's fork of bass is required (https://github.com/ARM9/bass).
**Put bass.exe in the root folder of this repository and use one of the batch files.**

 * `_build_JPN.bat` - Build a japanese region \*.ndd image file (Requires Japanese Retail 64DD IPL ROM)
 * `_build_USA.bat` - Build an american region \*.ndd image file (Requires American Retail 64DD IPL ROM)
 * `_build_XXX_DEV.bat` - Build a development \*.ndd image file (Requires ANY 64DD IPL ROM)
 * `_build_XXX_D64.bat` - Build a master disk \*.d64 image.

A development blue disk does not use disk region locking, therefore it works using any NTSC version of the game as the detection code does not make the difference between EZLJ and EZLE, regardless of in-game language. Therefore the region locking is solely done by the 64DD library itself.
 
 ## Build ROM Version

Building the ROM version is meant for flashcart users who cannot play the disk version via emulator or real disk.

This ROM version will do the following:
  * Patches the game in a identical way to the disk version.
  * Replaces and adds new files appropriately.
  * Converts the ROM to a US language ROM (game ID would be forced to _CZLE_).
  * Forces "Disk" to appear on the Title Screen for authenticity.
  * Completely disables 64DD detection, bypassing the region locking freeze when using the US version with a Japanese Retail 64DD unit.

To build the ROM, the following is required:
 * A **FULLY DECOMPRESSED The Legend of Zelda - Ocarina of Time NTSC ROM dump** (US / JP), **any version** (1.0 / 1.1 / 1.2)
   * Use Yaz0Decompressor from CloudModding (https://cloudmodding.com/n64) to make a decompressed ROM.
   * The file should be at the repository root and named **CZLJ00_D.z64 / CZLJ01_D.z64 / CZLJ02_D.z64** (depending on the version).
 * ARM9's fork of bass (https://github.com/ARM9/bass) for assembling.
   * **Put bass.exe in the root folder of this repository.**
 * Real N64 CRC Tool (rn64crc.exe) for updating the checksum to work on real hardware.
   * **Put rn64crc.exe in the ./dev/ folder of this repository.**

Use the appropriate `_build_ROM_vX.bat` file corresponding to your ROM version to build a ROM image named _"CZLJ_DawnDusk.z64"_.
