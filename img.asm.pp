    opt l-h+f-
    icl 'hardware.asm'
    org $2000
init
    sei
    lda #0
    sta IRQEN
    sta NMIEN
    sta DMACTL
    mva #0 GRACTL
    mva #0 GRAFP0
    mva #0 GRAFP1
    mva #0 GRAFP2
    mva #0 GRAFP3
    mva #0 GRAFM
    mva #0 COLBK
    mva #$22 DMACTL
    lda #3
    cmp:rne VCOUNT
    sta WSYNC
    rts
showframe
    mva <dlist DLISTL
    mva >dlist DLISTH
    ldx #0
image
    sta WSYNC
    mva #$32 COLPF0
    mva #$72 COLPF1
    mva #$d2 COLPF2
    sta WSYNC
    mva #6 COLPF0
    mva #10 COLPF1
    mva #14 COLPF2
    :2 inx
    cpx #240
    bne image
    ldx #0
blank
    sta WSYNC
    inx:cpx #[312-240]
    bne blank
    jmp showframe
bitmap equ [$4000+$10]
dlist
    dta $4e,a(bitmap)
    :101 dta $e
    dta $4e,a(bitmap+$1000-$10)
    :101 dta $e
    dta $4e,a(bitmap+$2000-$10)
    :35 dta $e
    dta $41,a(dlist)
    ini init
    org bitmap
   icl 'ruff0000.ppm.asm'
    run showframe
