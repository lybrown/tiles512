    opt l+h+f-
    icl 'hardware.asm'

main equ $2000
dlist equ $3000
scr equ $4000

izero equ 16
>>> my $x = <<'VERB';
chromabak equ $00
chroma0 equ $88
chroma1 equ $F2
chroma2 equ $B2
chroma3 equ $B2
lumabak equ $00
luma0 equ $88
luma1 equ $06
luma2 equ $0E
luma3 equ $0E
>>>VERB
>>> eval $x;
>>> $c{$1} = $2 while $x =~ /(\w+) equ \$(\w+)/g;

    org main
    sei
    lda #0
    sta IRQEN
    sta NMIEN
    sta DMACTL
    sta GRACTL
    sta COLBK
    sta COLPF3
    mva #$31 PRIOR
image
    lda #3
    cmp:rne VCOUNT
    mwa #dlist DLISTL
    mva #$2D DMACTL
    :25 sta WSYNC

    ldx #124
row
    sta WSYNC
    mva #chromabak COLBK
    mva #chroma0 COLPF0
    mva #chroma1 COLPF1
    mva #chroma2 COLPF2
    mva #chroma3 COLPF3
    sta WSYNC
    mva #lumabak COLBK
    mva #luma0 COLPF0
    mva #luma1 COLPF1
    mva #luma2 COLPF2
    mva #luma3 COLPF3
    cpx VCOUNT
    bne row
    jmp image

    org dlist
    dta $42,a(ctext),$42,a(ltext),$42,a(btext)
    :108 dta $4E,a(scr1),$4E,a(scr2)
    dta $41,a(dlist)

    org scr
ctext
    :4 dta d'<<<$c{chromabak}>>>'
    :4 dta d'<<<$c{chroma0}>>>'
    :4 dta d'<<<$c{chroma1}>>>'
    :4 dta d'<<<$c{chroma2}>>>'
ltext
>>> for (0 .. 3) {
    dta d'<<<$c{lumabak}>>>'
    dta d'<<<$c{luma0}>>>'
    dta d'<<<$c{luma1}>>>'
    dta d'<<<$c{luma2}>>>'
>>> }
btext
>>> for $c (0 .. 15) {
    dta d'<<<$c>>2>>>',d'<<<$c&3>>>'
>>> }
scr1
    :4 dta $00,$00
    :4 dta $55,$55
    :4 dta $AA,$AA
    :4 dta $FF,$FF
scr2
    :4 dta $00,$00,$55,$55,$AA,$AA,$FF,$FF

    run main
