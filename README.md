SMB
===

Tiled Side-Scroller Demo using PAL Blending.

Screenshot
----------

[![tiles](https://github.com/lybrown/tiles/raw/master/screenshots/smb.png)](https://github.com/lybrown/tiles/blob/master/screenshots/smb.png)

Video
-----

* TODO

Binaries
--------

* [smb-pal.xex](https://github.com/lybrown/smb/raw/master/binaries/smb-pal.xex)
* [smb-pal.atr](https://github.com/lybrown/smb/raw/master/binaries/smb-pal.atr)
* [smb-ntsc.xex](https://github.com/lybrown/smb/raw/master/binaries/smb-ntsc.xex)
* [smb-ntsc.atr](https://github.com/lybrown/smb/raw/master/binaries/smb-ntsc.atr)

Requirements
------------

* Atari 8-bit computer with 128K of memory
* Functions on 64K but displays garbage sprites

Interface
---------

* Joystick left and right for horizontal motion
* Joystick button or up for jump
* Select to toggle music
* Start to reload map
* Option to change tile luminance

Engine
------

* Changes two playfield colors every scan line
  * Pixels mix vertically in PAL for effectively square pixels at 16 colors
  * Less mixing in NTSC but still somewhat colorful
* No computation during raster
* 50fps or 60fps on PAL or NTSC
* Pared down display height on NTSC to make up for less vertical blank time
* Platforms and blockages
* Gravity
* X acceleration

Tiles
-----

* 4x4 Antic Mode 4 or effectively 16x16 pixels
* Effectively 16 colors
* 32 different tiles fit into four 128-entry
  [character sets](https://github.com/lybrown/smb/raw/master/tileset.png)
* Twiddle CHBASE every 8 scanlines so each row of the tileset can use a
  different 128-entry character set
* 4K memory

Map
---

* 512x16 [tiles](https://github.com/lybrown/smb/blob/master/screenshots/level.png)
* Created in Tiled Qt
* 2 layers: visual, blockages
* One byte per tile
  * 5 bits for tile
  * 1 bit for horizontal blockage
  * 1 bit for vertical blockage
* 8K memory

Sprites
-------

* 16x40 pixels
* All four players for multicolor
* Stored in extended memory
* No vertical movement
* Poses selected by PMBASE and PORTB
* 16K memory
* No enemies or projectiles

Screen
------

* Effectively 160x120 pixels at 16 colors
* 10x7.5 tiles
* 16 quarter tile slices along vertical edge are updated every frame in direction of x movement
* Takes advantage of Antic LMS wrap for continuous scrolling
* 1 full tile can be replaced per frame (coin -> background)
* Coin collision dectection alternates between lower and upper tile of hero every frame

Music
-----

* SAP by Sim Piko

Related Efforts
---------------

* analmux
  * http://www.atariage.com/forums/topic/150778-super-mario-bros-on-atari-8bit/page__hl__%20analmux%20%20mario
* prObe
  * http://atarionline.pl/v01/index.php?ct=katalog&sub=S&tg=Super+Mario+Bros#Super_Mario_Bros

Thanks
------

* Super Mario Brothers
  * http://en.wikipedia.org/wiki/Super_Mario_Bros.
* Sim Piko for Super Mario Brothers SAP
  * http://asma.atari.org/asmadb/search.php?q1=1&q2=Super+Mario+Brothers&q4=1&q3=1
* flashjazzcat, popmilo, XL-Paint Max, et. al. for PAL Blending
  * http://www.atariage.com/forums/topic/197450-mode-15-pal-blending/
* Rybags for full-screen VSCROL technique and high HSCROL lighter DMA technique
  * http://www.atariage.com/forums/topic/154718-new-years-disc-2010/page__st__50#entry1911485
  * http://www.atariage.com/forums/topic/197450-mode-15-pal-blending/page__st__100#entry2637036
* phaeron for Altirra and VirtualDub
  * http://www.virtualdub.org/altirra.html
* fox for xasm
  * http://atariarea.krap.pl/x-asm/
* AtariAge Forums
  * http://www.atariage.com/forums/forum/12-atari-8-bit-computers/
* Tiled Qt
  * http://www.mapeditor.org/
* ImageMagick
  * http://www.imagemagick.org/script/index.php
