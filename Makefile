# $Id: Makefile 36 2008-06-29 23:46:07Z lybrown $

smb.run:
blends.run:
img.run:
diskloader.boot:
smb.obx: assets.asm sprites.asm song.asm font.asm
diskloader.obx: smb.xex
assets.asm: level.json pal.ppm tileset-fullcolor.png json2am
#assets.asm: level1-2.json pal.ppm tileset-fullcolor.png json2am
#assets.asm: dizzy.json pal.ppm dizzy-map_bank.png json2am
	./json2am $^ > $@
sprites.asm: sprites.png sprites
	./sprites $< > $@
font.asm: smb1-font.png
	./img2font $< > $@

ntsc := 0
atari = /c/Documents\ and\ Settings/lybrown/Documents/Altirra.exe

%.png: %-fullcolor.png pal.ppm
	convert +dither -compress none $< -remap pal.ppm $@

%.run: %.xex
	$(atari) $<

%.boot: %.atr
	$(atari) $<

%.xex: %.obx
	cp $< $@

%.asm.pl: %.asm.pp
	echo 'sub interp {($$_=$$_[0])=~s/<<<(.*?)>>>/eval $$1/ge;print}' > $@
	perl -pe 's/^\s*>>>// or s/(.*)/interp <<'\''EOF'\'';\n$$1\nEOF/;' $< >> $@

%.asm: %.asm.pl
	perl $< > $@
	
%.obx: %.asm
	xasm /l /d:ntsc=$(ntsc) $<

%.dfl: %.bin gzip2deflate
	#7z a -tgzip -mx=9 -so dummy $< | ./gzip2deflate >$@
	gzip -c -9 $< | ./gzip2deflate >$@

%.atr: %.obx obx2atr
	./obx2atr $< > $@

gzip2deflate: gzip2deflate.c
	gcc -o $@ $<

bin:
	mkdir -p binaries
	make ntsc=0 diskloader.atr -W smb.asm.pp
	mv smb.xex binaries/smb-pal.xex
	mv diskloader.atr binaries/smb-pal.atr
	#rm smb.obx
	#make ntsc=1 diskloader.atr -W smb.asm.pp
	#mv smb.xex binaries/smb-ntsc.xex
	#mv diskloader.atr binaries/smb-ntsc.atr

clean:
	rm -f *.{obx,atr,lst} *.{tmc,tm2,pgm,wav}.asm *~

.PRECIOUS: %.xex %.ppm %.asm %.asm.pl %.atr
