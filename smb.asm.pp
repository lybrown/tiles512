    opt l+h+f-
    icl 'hardware.asm'
    org $80
coarse org *+2
mappos org *+2
mapfrac org *+1
tilepos org *+2
mapy org *+1
edgeoff org *+1
tmp org *+1
framecount org *+1
scrpos org *+2
reppos org *+2
xpos org *+2
xposlast org *+2
jframe org *+1
screeny org *+1
veldir org *+1
vel org *+1
runframe org *+1
rightleft org *+1
footpos org *+2
foottile org *+1
tilechar org *+1
checkpos org *+2
checktile org *+1
ground org *+1
lastjump org *+1
midair org *+1
pmbank org *+1
cointype org *+1
lastselect org *+1
laststart org *+1
lastoption org *+1
lumi org *+1
lum1 org *+1
lum2 org *+1
lum3 org *+1
drawpos org *+2
silent org *+1

inflate_zp equ $F0

main equ $2000
dlist equ $3B00
splash equ $3C00
song equ $4000
mapcopy equ $6000
scr equ $A000
map equ $B000
chset equ $E000
buffer equ $8000

    ift ntsc
bottomvcount equ 98
hy equ 82/2+12
    els
bottomvcount equ 122
hy equ 114/2+12
    eif
mapheight equ 16
mapwidth equ 512
linewidth equ $40
herox equ 4
hx equ 100+12-16+8
bank0 equ $82
bank1 equ $86
bank2 equ $8A
bank3 equ $8E
bankmain equ $FE
velstill equ 15
runframemax equ 3*8-1
false equ 0
chromabak equ $00
chroma0 equ $88
chroma1 equ $24
chroma2 equ $B6
chroma3 equ $0F
lumabak equ $00
luma0 equ $88
luma1 equ $06
luma2 equ $0C
luma3 equ $0E

    org splash
splashfont
    icl 'font.asm'
splashdlist
    :8 dta $70
    dta $42,a(splashtext)
    :6 dta $2
splashready
    dta $41,a(splashdlist)
    dta $2
    dta $41,a(splashdlist)
splashtext
>>> my $text = <<'EOF';
>>>TILED SIDE SCROLLER DEMO
>>>USING PAL BLENDING
>>>ANTIC MODE 4
>>>
>>>CODE - XUEL
>>>MUSIC - SIMPIKO
>>>
>>>PRESS START OR FIRE!
>>>EOF
>>> #$text .= "\n"x10;
>>> printf "    dta $_\n" for
>>>   map { $_==45?40:$_==32?47:$_==33?43:$_<64?$_-48:$_<90?$_-55:() }
>>>   map ord, map { (m/(.)/g) }
>>>   map { $p=40-length;" "x($p/2),$_," "x(($p+1)/2) }
>>>   ($text =~ m{^(.*)?$}gm);
    :2 dta 47
splashshow
    lda #0
    sta 712
    sta 710
    mva #15 711
    mva #15 709
    mva #15 708
    mva >splashfont 756
    mwa #splashdlist 560
    mva #$22 559
    cmp:rne VCOUNT
    sta WSYNC
    cmp:rne VCOUNT
    rts
    ini splashshow

    org main
relocate
    sei
    lda #0
    sta IRQEN
    sta NMIEN
    ;sta DMACTL
    cmp:rne VCOUNT
    ldx buffer+4
    lda banks,x
    sta PORTB
    mwa #buffer+5 ld+1
    mwa buffer st+1
ld  lda $FFFF
st  sta $FFFF
    inc ld+1
    sne:inc ld+2
    inc st+1
    sne:inc st+2
    lda st+1
    cmp buffer+2
    bne ld
    lda st+2
    cmp buffer+3
    bne ld
    cli
setbank0
    mva #bank0|1 PORTB
    rts
setbank1
    mva #bank1|1 PORTB
    rts
setbank2
    mva #bank2|1 PORTB
    rts
setbank3
    mva #bank3|1 PORTB
    rts
setbankmain
    mva #bankmain|1 PORTB
    rts
clearbank
    mva #$40 clearst+2
    mva #$60 clearst+5
    ldx #0
    lda #0
    ldy #$60
clearst
    sta $4000,x
    sta $6000,x
    inx
    bne clearst
    inc clearst+2
    inc clearst+5
    cpy clearst+2
    bne clearst
    rts
banks
    :4 dta bank0+[[#%4]<<2]
    rts
preinit
    jsr setbank0
    jsr clearbank
    mwa #mapcopy buffer
    mwa #mapcopy+$2000 buffer+2
    jsr relocate
    jsr setbankmain
    rts

    org dlist
    ift ntsc
    :25 dta $54+[#!=24]*$20,a(scr+#<<6)
    els
    :31 dta $54+[#==0]*$20,a(scr+#<<6)
    eif
jvb
    dta $41,a(dlist)
    icl 'sprites.asm'
    icl 'assets.asm'
    ini preinit
    ;opt h-
    ;ins 'Super_Mario_Brothers_Over.bin'
    ;opt h+
    org song
    icl 'song.asm'

    org main
    sei
    lda #0
    sta IRQEN
    sta NMIEN
    ;sta DMACTL
    sta SIZEP0
    sta SIZEP1
    sta SIZEP2
    sta SIZEP3
    sta silent
    mva #$31 PRIOR
    mva #$FF SIZEM
    mva #$34 COLPM1
    sta COLPM3
    mva #$F8 COLPM0
    sta COLPM2
    mva #hx HPOSP0
    sta HPOSP1
    mva #hx+8 HPOSP2
    sta HPOSP3
    mva #2 lumi
    ; TODO: relocate music
    ;jsr $C80
    jsr songreloc

    ift ntsc
    ;mva #6 tempo
    eif

;    mva #bankmain|1 PORTB
;    ldx #0
;chcopy1
;    mva chset,x buffer,x
;    mva chset+$100,x buffer+$100,x
;    mva chset+$200,x buffer+$200,x
;    mva chset+$300,x buffer+$300,x+
;    bne chcopy1
;    mva #bankmain PORTB
;    ldx #0
;chcopy2
;    mva buffer,x chset,x
;    mva buffer+$100,x chset+$100,x
;    mva buffer+$200,x chset+$200,x
;    mva buffer+$300,x chset+$300,x+
;    bne chcopy2

    lda #0
    cmp:rne VCOUNT
    :3 sta splashready+#
splashwait
    lda TRIG0
    and CONSOL
    and #1
    bne splashwait

    mva #bankmain PORTB
    mwa #vbi $FFFA

die
    lda #0
    sta NMIEN
    sta DMACTL
    sta GRACTL
    sta edgeoff
    sta lastjump
    sta midair

    mva #velstill|$80 veldir
    mva #bankmain PORTB
    mva #japex jframe
    mva #runframemax runframe
    mva #26 ground
    mwa #$0080 xpos
    sta xposlast
    mwa #0 coarse

    ; reset music
    jsr songinit

initdraw
    jsr drawedgetiles
    inc coarse
    lda coarse
    cmp #linewidth
    bne initdraw
    mva #0 coarse

    lda #bottomvcount
    cmp:rne VCOUNT
    mwa #jvb DLISTL
    mva #$2E DMACTL
    mva #$40 NMIEN
    jmp *
vbi
    pla
    pla
    pla
    jmp blank
showframe
    inc framecount
    mva pmbank PORTB
    mva #3 GRACTL
preraster
    ldy jframe
    ldx jumprow,y
    mva rowtablelo,x rowjmp+1
    mva rowtablehi,x rowjmp+2
    mva chbasetable,x CHBASE
    mvx #chromabak COLBK
    mvx #chroma0 COLPF0
    mvx #chroma1 COLPF1
    mvx #chroma2 COLPF2
    mvx #chroma3 COLPF3
    ldx #3
    cpx:rne VCOUNT
line7
    stx WSYNC
line8_firstbadline
    stx WSYNC
line9_firstgoodline
    stx WSYNC
    mvx #luma1 COLPF1
    mvx #luma2 COLPF2
    mvx #7 VSCROL
    ldx #chroma1
    ldy #chroma2
rowjmp
    jmp row1

>>> for $row (0 .. 15) {
row<<<$row>>>
    ; possible badline
    sta WSYNC
    sta CHBASE
    stx COLPF1
    sty COLPF2
    ; goodline
    sta WSYNC
    mva #luma1 COLPF1
    mva #luma2 COLPF2
    lda >[chset+$400*[[<<<$row>>>+1]>>2&3]]
    ldx #chroma1
    ldy #chroma2
>>> }
    jmp row0

blank
    ift ntsc
    mva #0 GRACTL
    sta GRAFP0
    sta GRAFP1
    sta GRAFP2
    sta GRAFP3
    sta GRAFM
    eif
    mwa #dlist DLISTL

ymove
    lda PORTA
    and TRIG0
    cmp lastjump
    sta lastjump
    bcs nojump ; didn't just press up or button
    lda midair
    bne nojump ; midair
    lda #japex
    cmp jframe
    bcc nojump ; japex < jframe
    lda ground
    sub #jmapheight
    sta ground
    mva #jlast jframe
    mva #1 midair
    bne ymovedone
nojump
    lda jframe
    sne:mva #jextra jframe
    dec jframe
ymovedone

    ; PORTA bits: right,left,down,up
    ; vi+=1 if right, clamp max
    ; vi-=1 if left, clamp min
    ; vi+=sign(v) if !right and !left, clamp 0
    ; dir=1 if v>0
    ; dir=0 if v<0
    ; dir'=dir if v==0
    ; p+=v[vi]
    ; runframe=0 if v==0
    ; runframe+=1 if v!=0, modulus

xmove
    lda PORTA
    and #%1100
    sta rightleft
    :3 asl @
    ora veldir
    tax
    lda veldirtable,x
    sta veldir
    and #$1F
    ldy #0
    cmp #velstill
    scc:ldy #48
    sty edgeoff
    sta vel
    tax
    mwa xpos xposlast
    lda veltablelo,x
    add:sta xpos
    lda veltablehi,x
    adc:sta xpos+1
xmovedone

adjust
    ; mapy = ground + jumpmap[jframe]
    ldx jframe
    lda jumpmap,x
    add ground
    sta mapy

checkpit
    bmi nopit
    cmp #30
    scc:jmp die
nopit

    ; foottile = map[xpos_w>>6 + herox + mapy<<8]
    mva xpos+1 footpos
    lda xpos
    asl @
    rol footpos
    asl @
    rol footpos
    lda mapy
    and #$1F
    adc >map
    sta footpos+1
    ldy #herox ; herox offset
    lda (footpos),y
floor
    sta foottile

    ; debug
    ;and #$F8
    ;ora #7
    ;sta (footpos),y

    and #$80
    ; if tile.blockx: vel = dir ? 1 : -1; xpos = xposlast
    beq adjusty
adjustx
    ldx #[velstill-1]
    ldy veldir
    spl:ldx #[[velstill+1]|$80]
    stx veldir
    mwx xposlast xpos

adjusty
    ; if tile.blocky: ground = mapy; jframe = japex
    lda foottile
    and #$40
    beq setmidair
    ; skip if jframe >= japex
    ldy #japex
    cpy jframe
    bcc adjustdone
    sty jframe
    mva mapy ground
    mva #0 midair
    beq adjustdone
setmidair
    mva #1 midair
adjustdone

music
    mva #bankmain PORTB
    lda CONSOL
    and #2
    cmp lastselect
    sta lastselect
    bcs noselect ; didn't just press select
    lda #$FF
    eor:sta silent
    ;:2 sta silent+1+#
    beq noselect
    lda #0
    sta AUDC1
    sta AUDC2
    sta AUDC3
    sta AUDC4
noselect
    ;jsr player+$303 ; play music
    ;jsr play
    lda silent
    sne:jsr songplay

musicdone

start
    lda CONSOL
    and #1
    cmp laststart
    sta laststart
    bcs startdone ; didn't just press start

    mva #0 NMIEN
    mva #0 DMACTL
    cmp:rne VCOUNT
    sta GRACTL
    mva #bank0 PORTB
    mva >mapcopy memcpy+2
    mva >map memcpy+5
    ldx #0
    ldy #$20
memcpy
    mva mapcopy,x map,x
    inx
    bne memcpy
    inc memcpy+2
    inc memcpy+5
    dey
    bne memcpy

    jmp die
startdone

option
    lda CONSOL
    and #4
    cmp lastoption
    sta lastoption
    bcs nooption ; didn't just press option
    inc lumi
nooption
    lda lumi
    and #7
    asl @
    asl @
    tax
    mva lumtable+1,x lum1
    mva lumtable+2,x lum2
    mva lumtable+3,x lum3
optiondone

pose
    ; midair
    lda midair
    ; still
    ldy vel
    cpy #velstill
    bne moving
    ldy rightleft
    cpy #%1100
    bne moving
    ora #2
moving
    ; dir
    ldy veldir
    spl:ora #4
    tax
    ldy vel
    cpy #velstill
    scc:eor #4
    tay
    mva bank_dir_still_midair,x pmbank
    lda pmbase_skid_still_midair,y
    bpl notrunning
    lda runframe
    :3 lsr @
    tax
    mva pmbasetable,x PMBASE
    lda runframe
    ldy vel
    sub runframedeltatable,y
    spl:add #runframemax
    sta runframe
    jmp posedone
notrunning
    sta PMBASE
    mva #runframemax runframe
posedone

update_display
    ; coarse = xpos>>4
    mva xpos coarse
    lda xpos+1
    lsr @
    ror coarse
    lsr @
    ror coarse
    lsr @
    ror coarse
    lsr @
    ror coarse
    sta coarse+1

    ; HSCROL = table[(xpos & $C) >> 2]
    lda xpos
    and #$C
    :2 lsr @
    tax
    mva hscroltable,x HSCROL

    ; VSCROL = table[jframe]
    ; scrpos = coarse + table[jframe] + table[ground]
    ldx jframe
    mva jumpvscrol,x VSCROL
    lda coarse
    add jumpscrlo,x
    sta scrpos
    lda jumpscrhi,x
    ldx ground
    adc ground2scr,x
    tay
    add coarse+1
    sta scrpos+1

    ; update low bytes of dlist
    lda scrpos
    sta tmp
    :8 sta dlist+1+12*#
    add #linewidth
    :8 sta dlist+4+12*#
    add #linewidth
    :8 sta dlist+7+12*#
    add #linewidth
    :7 sta dlist+10+12*#

    ; update high bytes of dlist
    ; dlist{hi}[i] = scrhitable[(scrpos & $FC0) >> 6]
    lda scrpos+1
    and #$F
    asl tmp
    rol @
    asl tmp
    rol @
    tax
    :31 dta {lda a:,x},a(scrhitable+#),{sta a:},a(dlist+2+3*#)

    ldx <skyline
    lda >skyline
>>> for $c (0 .. 3) {
    iny
    cpy #$12
    bcs skydone
    stx dlist+1+3*<<<$c*4>>>
    sta dlist+2+3*<<<$c*4>>>
    stx dlist+1+3*<<<$c*4+1>>>
    sta dlist+2+3*<<<$c*4+1>>>
    stx dlist+1+3*<<<$c*4+2>>>
    sta dlist+2+3*<<<$c*4+2>>>
    stx dlist+1+3*<<<$c*4+3>>>
    sta dlist+2+3*<<<$c*4+3>>>
>>> }
skydone

replacetile
    ; skip if out of time this frame
    ;lda VCOUNT
    ;cmp #$88
    ;scc:jmp replacedone

    ; skip if x blocked
    lda foottile
    and #$80
    seq:jmp replacedone

    ; checkpos = footpos - ((framecount&1) ? 0 : $200)
    lda framecount
    ror @
    php
    mva footpos checkpos
    lda footpos+1
    scs:sbc #1 ; -2 because carry clear
    sta checkpos+1

    ; reppos = scr + (((scrpos-jump{lo}+$500)
    ;          - ((framecount&1) ? 0 : $100)) & $FFC)
    ldx jframe
    lda scrpos
    sub jumpscrlo,x
    and #$FC
    php
    add #[herox*4]
    sta reppos
    lda scrpos+1
    sbc #-5+1*ntsc
    plp
    adc #0
    plp
    sbc #0 ; -1 if carry clear
    and #$F
    add >scr
    sta reppos+1

    ; tilechar = map[checkpos]&(7<<3)<<1
    ; map[checkpos] = map[checkpos]&$F8 | map[checkpos]&(7<<3)>>3
    ldy #herox
    lda (checkpos),y
    sta checktile
    and #$1F
    cmp #9
    beq replace
    cmp #16
    beq replace
    jmp replacedone
replace
    lda checktile
    and #$C0
    sta (checkpos),y

    ; blit to scr
    lda #0 ; tilechar
    :4 dta {ldy #},[#<<6],{sta (),y},reppos
    lda #2
    :4 dta {ldy #},[#<<6]+1,{sta (),y},reppos
    lda #3
    :4 dta {ldy #},[#<<6]+2,{sta (),y},reppos
    lda #4
    :4 dta {ldy #},[#<<6]+3,{sta (),y},reppos

replacedone

    jsr drawedgetiles

    jmp showframe

drawedgetiles
    ; drawpos = scr + coarse + edgeoff
    lda coarse
    add edgeoff
    sta drawpos
    lda coarse+1
    adc >scr
    sta drawpos+1

    ; mapfrac = (drawpos & 3) << 2
    ; mappos = map + (drawpos & $FFF) >> 2
    lda drawpos
    sta mappos
    and #3
    sta mapfrac
    lda drawpos+1
    and #$F
    lsr @
    ror mappos
    lsr @
    ror mappos
    sta mappos+1
    add >map
    sta mappos+1

edge
    ldy #0
    lda (mappos),y
    and #$3f
    :2 asl @
    add mapfrac
    ;ora #$80

    ldx >[scr+$F00]
    cpx drawpos+1
    bne fastblit
    stx slowblit+2
    mvx drawpos slowblit+1
    tax
    ldy #4
slowblit
    stx $FFFF
    lda #linewidth
    add:sta slowblit+1
    scc:mva >scr slowblit+2
    dey
    bne slowblit
    jmp donetile

fastblit
    sta (drawpos),y
    ldy #$40
    sta (drawpos),y
    ldy #$80
    sta (drawpos),y
    ldy #$C0
    sta (drawpos),y

donetile
    lda #1
    add drawpos+1
    cmp >[scr+$1000]
    sne:lda >scr
    sta drawpos+1

    lda #2
    add:sta mappos+1
    cmp >[map+$2000]
    bcc edge
    rts

tilex4
    :32 dta #*4
tilefrac
    :4 dta #*4
scrhitable
    :256 dta >[scr+[[#*linewidth]&$FFF]]
skyline
    :48 dta 4

>>> my $jsteps = 39;
>>> my $jextra = 32;
>>> my $jheight = 4;
>>> my $jhalf = int($jsteps / 2);
>>> my $japex = $jextra + $jhalf;
>>> my $jsoff = 11;
>>> print "jextra equ $jextra\n";
>>> print "jlast equ ",$jextra + $jsteps - 2,"\n";
>>> print "japex equ ",$japex,"\n";
>>> print "jheight equ $jheight\n";
>>> print "jmapheight equ ",$jheight*2,"\n";
>>> my $acc = $jheight/(($jsteps-1)/2)**2;
>>> my @traj = map { $jheight-$jheight+$acc*$_*$_ } -$jhalf-$jextra .. $jhalf-1;
>>> #unshift @traj, $jheight+$_/2 for 1 .. $jextra;
jumpscrlo
>>> printf "    dta %d\n", (int(($_)*4)&3)*0x40 for @traj;
jumpscrhi
>>> printf "    dta ntsc*1+%d\n", $jsoff + int($_) for @traj;
jumpmap
>>> printf "    dta %d\n", 2*int($_) for @traj;
jumpvscrol
>>> printf "    dta %d\n", int(($_)*32)&6 for @traj;
jumprow
>>> printf "    dta %d\n", int(($_)*16+1)&15 for @traj;
ground2scr
    :256 dta #/2

veldirtable
>>> my $i = 0;
>>> for my $dir (0, 1) {
>>> for my $rightb (0, 1) {
>>> for my $leftb (0, 1) {
>>> for my $vel (0 .. 31) {
>>>   my $dirn = !$rightb ? 1 : !$leftb ? 0 : $dir;
>>>   my $stop = !($rightb ^ $leftb) ? 1 : 0;
>>>   my $right = (!$rightb && $leftb) ? 1 : 0;
>>>   my $left = ($rightb && !$leftb) ? 1 : 0;
>>>   my $veln = $vel;
>>>   $veln += 1 if $right and $veln < 30;
>>>   $veln -= 1 if $left and $veln > 0;
>>>   $veln -= 1 if $stop and $veln > 15;
>>>   $veln += 1 if $stop and $veln < 15;
>>>   #$veln += 1 if $right and $veln < 15;
>>>   #$veln -= 1 if $left and $veln > 15;
>>>   printf "    ; i=%x dirn=$dirn stop=$stop right=$right left=$left", $i++;
>>>   printf " vel=$vel veln=$veln\n";
>>>   printf "    dta %d\n", $dirn<<7|$veln;
>>> }}}}
veltablelo
    :31 dta [#*16/15]-16
veltablehi
    :31 dta [#<15]*$FF
runframedeltatable
>>> printf "   dta %d\n", abs($_)/5+1 for -15 .. 15;
bank_dir_still_midair
>>> for my $dir (0, 1) {
>>> for my $still (0, 1) {
>>> for my $midair (0, 1) {
>>>   printf "    dta bank%s\n",
>>>     $dir ? 1 : 2;
>>> }}}
pmbase_skid_still_midair
>>> for my $skid (0, 1) {
>>> for my $still (0, 1) {
>>> for my $midair (0, 1) {
>>>   printf "    dta \$%x\n",
>>>     0x40 + 4 * ($midair ? 5 : $still ? 0 : $skid ? 4 : 16);
>>> }}}
pmbasetable
    ;:8 dta $40+4*#
    :2 dta $48,$4C,$44,$48
hscroltable
    :4 dta $F,$E,$D,$C
    ;:4 dta 11,10,9,8
lumtable
    dta 0,4,8,10
    dta 0,6,8,10
    dta 0,6,8,12
    dta 0,6,10,12
    dta 0,8,10,12
    dta 0,8,10,14
    dta 0,8,12,14
    dta 0,10,12,14
rowtablelo
>>> print "    dta <row$_\n" for 0 .. 15;
rowtablehi
>>> print "    dta >row$_\n" for 0 .. 15;
chbasetable
>>> print "    dta >[chset+\$400*[[$_]>>2&3]]\n" for 0 .. 15;

    run main
