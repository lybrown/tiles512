    opt l+h-f+
    icl 'sys.asm'
    icl 'hardware.asm'
    org $80
start org *+2
end org *+2
ptr org *+2
word org *+2
byte org *+1

buffer equ $700
runv equ $2E0
initv equ $2E2
main equ $600
loadsector equ 4

    org main
bootsector
    ; http://evilbill.org/old/orig/Atari/8-bit/Refman/chapter12.html
    ; Boot sector 6 byte header:
    dta 0           ; flags - DFLAGS
    dta 3           ; number of sectors to load into BOOTAD
    dta a(main)     ; load address - BOOTAD (the 6 byte header is included)
    dta a(loader)   ; init address - DOSINI

    ; readbuffer():
    ;   read buflen bytes
    ;   ptr = buffer
    ;
    ; byte():
    ;   byte = *ptr++
    ;   if (ptr == buffer + buflen)
    ;     readbuffer()
    ;     ptr = buffer
    ;
    ; word():
    ;   word = byte()+byte()*$100
    ;
    ; readbuffer()
    ; initv = runv = 0
    ;
    ; while true:
    ;   start = word()
    ;   if (start == $FFFF)
    ;     start = word()
    ;   end = word()
    ;
    ;   while (start < end)
    ;     *start++ = byte()
    ;
    ;   if (initv)
    ;     jsr *initv
    ;     initv = 0
    ;   if (runv)
    ;     jsr *runv
    ;     jmp *
    ;
    ; jmp *

    jmp loader
dlist
    :3 dta $70
    dta $42,a(scr)
    dta $41,a(dlist)
error
    sei
    mva #0 NMIEN
    lda #$25
    sta COLBK
    sta scr
    jmp *
readbuffer
    mva #$80 DBUFLO
    sta ptr
    jsr DSKINV
    bmi error
    inc DAUX1
    sne:inc DAUX2
    lda DAUX1
    and #$3f
    add #$5C
    sta HPOSP0
    eor #$FF
    sub #$8
    sta HPOSP1
    mva #0 GRACTL
    mva #15 PCOLR0
    mva #15 PCOLR1
    mva #$FF GRAFP0
    mva #$FF GRAFP1
    rts
getbyte
    ldy #0
    mva (ptr),y byte
    inc ptr
    sne:jmp readbuffer
    rts
getword
    jsr getbyte
    mva byte word
    jsr getbyte
    mva byte word+1
    rts
loader
    mwa #dlist SDLSTL
    mva #$2C scr
    mva >buffer DBUFHI
    sta ptr+1
    mwa #loadsector DAUX1
    mva #0 initv
    sta initv+1
    sta runv
    sta runv+1
    jsr readbuffer
loop
    jsr getword
    lda #$FF
    cmp word
    bne mark
    cmp word+1
    bne mark
    jsr getword
mark
    mwa word start
    jsr getword
    mwa word end
mem
    jsr getbyte
    ldy #0
    mva byte (start),y
    lda start
    cmp end
    bne memcont
    lda start+1
    cmp end+1
    beq checkvectors
memcont
    inc start
    sne:inc start+1
    bne mem
checkvectors
    lda initv
    bne callinit
    lda initv+1
    bne callinit
    lda runv
    bne callrun
    lda runv+1
    bne callrun
    beq loop
callinit
    mva #$29 scr
    lda:pha >[jinit+2]
    lda:pha <[jinit+2]
jinit
    jmp (initv)
    mwa #0 initv
    beq loop
callrun
    mva #$32 scr
    mva #0 HPOSP0
    sta HPOSP1
    sta COLPM0
    sta COLPM1
    lda:pha >[jrun+2]
    lda:pha <[jrun+2]
jrun
    jmp (runv)
spin
    mva #$33 scr
    jmp *
scr
    :40 dta 0

    :[$780-*] dta 0
    ins 'tiles.xex'
    :128 dta 0
