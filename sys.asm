;<HESS.ATARI>SYSMAC.SML.27  8-Mar-82 08:39:38, Edit by HESS

;6502 SYSTEM -*-MACRO-*- DEFINITIONS

; ***** ATARI SYSTEM DEFS *****

;       VECTOR TABLE

EDITRV  equ $E400                  ;EDITOR
SCRENV  equ $E410                  ;TELEVISION SCREEN
KEYBDV  equ $E420                  ;KEYBOARD
PRINTV  equ $E430                  ;PRINTER
CASETV  equ $E440                  ;CASSETTE

;       JUMP VECTOR TABLE

DISKIV  equ $E450                  ;DISK INITIALIZATION
DSKINV  equ $E453                  ;DISK INTERFACE
CIOV    equ $E456                  ;CIO ROUTINE
SIOV    equ $E459                  ;SIO ROUTINE
SETVBV  equ $E45C                  ;SET VERTICAL BLANK VECTORS
SYSVBV  equ $E45F                  ;SYSTEM VERTICAL BLANK ROUTINE
XITVBV  equ $E462                  ;EXIT VERTICAL BLANK ROUTINE
SIOINV  equ $E465                  ;SIO INIT
SENDEV  equ $E468                  ;SEND ENABLE ROUTINE
INTINV  equ $E46B                  ;INTERRUPT HANDLER INIT
CIOINV  equ $E46E                  ;CIO INIT
BLKBDV  equ $E471                  ;BLACKBOARD MODE
WARMSV  equ $E474                  ;WARM START ENTRY POINT
COLDSV  equ $E477                  ;COLD START ENTRY POINT
RBLOKV  equ $E47D                  ;CASSETTE READ BLOCK VECTOR
DSOPIV  equ $E480                  ;CASSETTE OPEN FOR INPUT VECTOR

;       SOME USEFUL INTERNAL ROUTINES

KGETCH  equ $F6E2                  ;GET CHAR FROM KEYBOARD
EOUTCH  equ $F6A4                  ;OUTPUT CHAR TO SCREEN
PUTLIN  equ $F385                  ;OUTPUT LINE TO IOCB#0

;       COMMAND CODES FOR IOCB

OPEN    equ $03                    ;OPEN FOR INPUT/OUTPUT
GETREC  equ $05                    ;GET RECORD (TEXT)
GETCHR  equ $07                    ;GET CHARACTER(S)
PUTREC  equ $09                    ;PUT RECORD (TEXT)
PUTCHR  equ $0B                    ;PUT CHARACTER(S)
CLOSE   equ $0C                    ;CLOSE DEVICE
STATIS  equ $0D                    ;STATUS REQUEST
SPECIL  equ $0E                    ;SPECIAL ENTRY COMMANDS

;       SPECIAL ENTRY COMMANDS

DRAWLN  equ $11                    ;DRAW LINE
FILLIN  equ $12                    ;DRAW LINE WITH RIGHT FILL
RENAME  equ $20                    ;RENAME DISK FILE
DELETE  equ $21                    ;DELETE DISK FILE
FORMAT  equ $22                    ;FORMAT DISK
LOCKFL  equ $23                    ;LOCK FILE (READ ONLY)
UNLOCK  equ $24                    ;UNLOCK FILE
POINT   equ $25                    ;POINT SECTOR
NOTE1   equ $26                    ;NOTE SECTOR

CCIO    equ $28                    ;CONCURRENT I/O MODE

IOCFRE  equ $FF                    ;IOCB "FREE"

;       AUX1 VALUES FOR OPEN

APPEND  equ $01                    ;OPEN FOR APPEND
DIRECT  equ $02                    ;OPEN FOR DIRECTORY ACCESS
OPNIN   equ $04                    ;OPEN FOR INPUT
OPNOT   equ $08                    ;OPEN FOR OUTPUT
OPNINO  equ OPNIN|OPNOT            ;OPEN FOR INPUT/OUTPUT
MXDMOD  equ $10                    ;OPEN FOR MIXED MODE
INSCLR  equ $20                    ;OPEN WITHOUT CLEARING SCREEN

; OS STATUS CODES

SUCCES  equ $01                    ;SUCCESSFUL OPERATION
BRKABT  equ $80                    ;(128) BREAK KEY ABORT
PRVOPN  equ $81                    ;(129) IOCB ALREADY OPEN
NONDEV  equ $82                    ;(130) NON-EX DEVICE
WRONLY  equ $83                    ;(131) IOCB OPENED FOR WRITE ONLY
NVALID  equ $84                    ;(132) INVALID COMMAND
NOTOPN  equ $85                    ;(133) DEVICE OR FILE NOT OPEN
BADIOC  equ $86                    ;(134) INVALID IOCB NUMBER
RDONLY  equ $87                    ;(135) IOCB OPENED FOR READ ONLY
EOFERR  equ $88                    ;(136) END OF FILE
TRNRCD  equ $89                    ;(137) TRUNCATED RECORD
TIMOUT  equ $8A                    ;(138) DEVICE TIMEOUT
DNACK   equ $8B                    ;(139) DEVICE DOES NOT ACK COMMAND
FRMERR  equ $8C                    ;(140) SERIAL BUS FRAMING ERROR
CRSROR  equ $8D                    ;(141) CURSOR OUT OF RANGE
OVRRUN  equ $8E                    ;(142) SERIAL BUS DATA OVERRUN
CHKERR  equ $8F                    ;(143) SERIAL BUS CHECKSUM ERROR
DERROR  equ $90                    ;(144) DEVICE ERROR (OPERATION INCOMPLETE)
BADMOD  equ $91                    ;(145) BAD SCREEN MODE NUMBER
FNCNOT  equ $92                    ;(146) FUNCTION NOT IN HANDLER
SCRMEM  equ $93                    ;(147) INSUFFICIENT MEMORY FOR SCREEN MODE

;       PAGE 0 LOCATIONS

LINZBS  equ $00                    ;LINBUG STORAGE
 
;  THESE LOCS ARE NOT CLEARED

CASINI  equ $02                    ;CASSETTE INIT LOC
RAMLO   equ $04                    ;RAM POINTER FOR MEM TEST
TRAMSZ  equ $06                    ;TEMP LOC FOR RAM SIZE
TSTDAT  equ $07                    ;RAM TEST DATA LOC

;  CLEARED ON COLDSTART ONLY

WARMST  equ $08                    ;WARM START FLAG
BOOTQ   equ $09                    ;SUCCESSFUL BOOT FLAG
DOSVEC  equ $0A                    ;DOS START VECTOR
DOSINI  equ $0C                    ;DOS INIT ADDRESS
APPMHI  equ $0E                    ;APPLICATION MEM HI LIMIT

;  CLEARED ON COLD OR WARM START

INTZBS  equ $10                    ; START OF OS RAM CLEAR LOC => $7F
POKMSK  equ $10                    ;SYSTEM MASK FOR POKEY IRQ ENABLE
BRKKEY  equ $11                    ;BREAK KEY FLAG
RTCLOK  equ $12                    ;REAL TIME CLOCK (60HZ OR 16.66666 MS)
BUFADR  equ $15                    ;INDIRECT BUFFER ADDRESS REG
ICCOMT  equ $17                    ;COMMAND FOR VECTOR HANDLER
DSKFMS  equ $18                    ;DISK FILE MANAGER POINTER
DSKUTL  equ $1A                    ;DISK UTILITIES POINTER
PTIMOT  equ $1C                    ;PRINTER TIME OUT REGISTER
PBPNT   equ $1D                    ;PRINT BUFFER POINTER
PBUFSZ  equ $1E                    ;PRINT BUFFER SIZE
PTEMP   equ $1F                    ;TEMP REG

ZIOCB   equ $20                    ;PAGE 0 I/O CONTROL BLOCK
IOCBSZ  equ 16                     ;NUMBER OF BYTES / IOCB
MAXIOC  equ 8*IOCBSZ               ;LENGTH OF IOCB AREA
IOCBAS  equ ZIOCB

ICHIDZ  equ $20                    ;HANDLER INDEX NUMBER ($FF := IOCB FREE)
ICDNOZ  equ $21                    ;DEVICE NUMBER (DRIVE NUMBER)
ICCOMZ  equ $22                    ;COMMAND CODE
ICSTAZ  equ $23                    ;STATUS OF LAST IOCB ACTION
ICBALZ  equ $24                    ;BUFFER ADDRESS (LOW)
ICBAHZ  equ $25                    ;  "       "    (HIGH)
ICPTLZ  equ $26                    ;PUT BYTE ROUTINE ADDRESS - 1
ICPTHZ  equ $27
ICBLLZ  equ $28                    ;BUFFER LENGTH (LOW)
ICBLHZ  equ $29                    ;  "       "   (HIGH)
ICAX1Z  equ $2A                    ;AUX INFO
ICAX2Z  equ $2B
ICSPRZ  equ $2C                    ;SPARE BYTES (CIO LOCAL USE)
ICIDNO  equ ICSPRZ+2               ;IOCB LUMBER * 16
CIOCHR  equ ICSPRZ+3               ;CHARACTER BYTE FOR CURRENT OPERATION

STATUS  equ $30                    ;INTERNAL STATUS STORAGE
CHKSUM  equ $31                    ;CHECKSUM (SINGLE BYTE SUM WITH CARRY)
BUNRLO  equ $32                    ;POINTER TO DATA BUFFER (LO BYTE)
BUFRHI  equ $33                    ;POINTER TO DATA BUFFER (HI BYTE)
BFENLO  equ $34                    ;NEXT BYTE PAST END OF BUFFER (LO BYTE)
BNENHI  equ $35                    ;NEXT BYTE PAST END OF BUFFER (HI BYTE)
CRETRY  equ $36                    ;NUMBER OF COMMAND FRAM RETRIES
DRETRY  equ $37                    ;NUMBER OF DEVICE RETRIES
BUFRFL  equ $38                    ;DATA BUFFER FULL FLAG
RECVDN  equ $39                    ;RECEIVE DONE FLAG
XMTDON  equ $3A                    ;XMIT DONE FLAG
CHKSNT  equ $3B                    ;CHECKSUM SENT FLAG
NOCKSM  equ $3C                    ;NO CHECKSUM FOLLOWS DATA FLAG

BPTR    equ $3D                    ;BUFFER POINTER (CASSETTE)
FTYPE   equ $3E                    ;FILE TYPE (SHORT IRG/LONG IRG)
FEOF    equ $3F                    ;END OF FILE FLAG (CASSETTE)
FREQ    equ $40                    ;FREQ COUNTER FOR CONSOLE SPEAKER
SOUNDR  equ $41                    ;NOISY I/O FLAG. (ZERO IS QUIET)
CRITIC  equ $42                    ;CRITICAL CODE IF NON-ZERO)

FMSZPG  equ $43                    ;DISK FILE MANAGER SYSTEM STORAGE (7 BYTES)

CKEY    equ $4A                    ;SET WHEN GAME START PRESSED
CASSBT  equ $4B                    ;CASSETTE BOOT FLAG
DSTAT   equ $4C                    ;DISPLAY STATUS
ATRACT  equ $4D                    ;ATTRACT MODE FLAG
DRKMSK  equ $4E                    ;DARK ATTRACT MASK
COLRSH  equ $4F                    ;ATTRACT COLOR SHIFTER (XOR'D WITH PLAYFIELD)

TMPCHR  equ $50                    ;TEMP CHAR STORAGE (DISPLAY HANDLER)
HOLD1   equ $51                    ;TEMP STG (DISPLAY HANDLER)
LMARGN  equ $52                    ;LEFT MARGIN
RMARGN  equ $53                    ;RIGHT MARGIN
ROWCRS  equ $54                    ;CURSOR COUNTERS
COLCRS  equ $55
DINDEX  equ $57                    ;DISPLAY INDEX (VARIOUS QUANTS)
SAVMSC  equ $58
OLDROW  equ $5A                    ;PREVIOUS ROW/COL
OLDCOL  equ $5B
OLDCHR  equ $5D                    ;DATA UNDER CURSOR
OLDADR  equ $5E
NEWROW  equ $60                    ;POINT DRAWS TO HERE
NEWCOL  equ $61
LOGCOL  equ $63                    ;POINTS AT COLUMN IN LOGICAL LINE
ADRESS  equ $64                    ;INDIRECT POINTER
MLTTMP  equ $66                    ;MULTIPLY TEMP
OPNTMP  equ MLTTMP                 ;FIRST BYTE IS USED IN OPEN AS TEMP
SAVADR  equ $68
RAMTOP  equ $6A                    ;RAM SIZE DEFINED BY POWER ON LOGIC
BUFCNT  equ $6B                    ;BUFFER COUNT
BUFSTR  equ $6C                    ;EDITOR GETCH POINTER
BITMSK  equ $6E                    ;BIT MASK
SHFAMT  equ $6F                    ;OUTCHR SHIFT

ROWAC   equ $70                    ;USED BY "DRAW"
COLAC   equ $72
ENDPT   equ $74
DELTAR  equ $76
DELTAC  equ $77
ROWINC  equ $79
COLINC  equ $7A
SWPFLG  equ $7B                    ;NON-0 IF TXT AND RAM SWAPPED
HOLDCH  equ $7C                    ;CH BEFORE CNTL & SHFT PROCESSING IN KGETCH
INSDAT  equ $7D                    ;INSERT CHAR SAVE
COUNTR  equ $7E                    ;DRAW COUNTER

;;;     $80 TO $FF ARE RESERVED FOR USER APPLICATIONS

;       PAGE 2 LOCATIONS

INTABS  equ $200                   ;INTERRUPT TABLE
VDSLST  equ $200                   ;DISPLAY LIST NMI VECTOR
VPRCED  equ $202                   ;PROCEED LINE IRQ VECTOR
VINTER  equ $204                   ;INTERRUPT LINE IRQ VECTOR
VBREAK  equ $206                   ;"BRK" VECTOR
VKEYBD  equ $208                   ;POKEY KEYBOARD IRQ VECTOR
VSERIN  equ $20A                   ;POKEY SERIAL INPUT READY
VSEROR  equ $20C                   ;POKEY SERIAL OUTPUT READY
VSEROC  equ $20E                   ;POKEY SERIAL OUTPUT DONE
VTIMR1  equ $210                   ;POKEY TIMER 1 IRQ
VTIMR2  equ $212                   ;POKEY TIMER 2 IRQ
VTIMR4  equ $214                   ;POKEY TIMER 4 IRQ (DO NOT USE)
VIMIRQ  equ $216                   ;IMMEDIATE IRQ VECTOR
CDTMV1  equ $218                   ;COUNT DOWN TIMER 1
CDTMV2  equ $21A                   ;COUNT DOWN TIMER 2
CDTMV3  equ $21C                   ;COUNT DOWN TIMER 3
CDTMV4  equ $21E                   ;COUNT DOWN TIMER 4
CDTMV5  equ $220                   ;COUNT DOWN TIMER 5
VVBLKI  equ $222                   ;IMMEDIATE VERTICAL BLANK NMI VECTOR
VVBLKD  equ $224                   ;DEFERRED VERTICAL BLANK NMI VECTOR
CDTMA1  equ $226                   ;COUNT DOWN TIMER 1 JSR ADDRESS
CDTMA2  equ $228                   ;COUNT DOWN TIMER 2 JSR ADDRESS
CDTMF3  equ $22A                   ;COUNT DOWN TIMER 3 FLAG
SRTIMR  equ $22B                   ;SOFTWARE REPEAT TIMER
CDTMF4  equ $22C                   ;COUNT DOWN TIMER 4 FLAG
INTEMP  equ $22D                   ;IAN'S TEMP (???)
CDTMF5  equ $22E                   ;COUNT DOWN TIMER 5 FLAG
SDMCTL  equ $22F                   ;SAVE DMACTL REGISTER
SDLSTL  equ $230                   ;SAVE DISPLAY LIST (LOW)
SDLSTH  equ $231                   ;SAVE DISPLAY LIST (HIGH)
SSKCTL  equ $232                   ;SKCTL REGISTER RAM

LPENH   equ $234                   ;LIGHT PEN HORIZ VALUE
LPENV   equ $235                   ;LIGHT PEN VERT VALUE
                                ; ($236 - $239 SPARE)
CDEVIC  equ $23A                   ;COMMAND FRAME BUFFER - DEVICE
CCOMND  equ $23B                   ;COMMAND
CAUX1   equ $23C                   ;COMMAND AUX BYTE 1
CAUX2   equ $23D                   ;COMMAND AUX BYTE 2
TEMP    equ $23E                   ;YES
ERRFLG  equ $23F                   ;ERROR FLAG - ANY DEVICE ERROR EXCEPT TIMEOUT

DFLAGS  equ $240                   ;DISK FLAGS FROM SECTOR ONE
DBSECT  equ $241                   ;NUMBER OF DISK BOOT SECTORS
BOOTAD  equ $242                   ;ADDRESS FOR DISK BOOT LOADER
COLDST  equ $244                   ;COLDSTART FLAG (1 = DOING COLDSTART)
                                ;($245 SPARE)
DSKTIM  equ $246                   ;DISK TIME OUT REG
LINBUF  equ $247                   ;CHAR LINE BUFFER (40 BYTES)

GPRIOR  equ $26F                   ;GLOBAL PRIORITY CELL
PADDL0  equ $270                   ;POT 0 SHADOW
PADDL1  equ $271                   ;POT 1 SHADOW
PADDL2  equ $272                   ;POT 2 SHADOW
PADDL3  equ $273                   ;POT 3 SHADOW
PADDL4  equ $274                   ;POT 4 SHADOW
PADDL5  equ $275                   ;POT 5 SHADOW
PADDL6  equ $276                   ;POT 6 SHADOW
PADDL7  equ $277                   ;POT 7 SHADOW
STICK0  equ $278                   ;JOYSTICK 0 SHADOW
STICK1  equ $279                   ;JOYSTICK 1 SHADOW
STICK2  equ $27A                   ;JOYSTICK 2 SHADOW
STICK3  equ $27B                   ;JOYSTICK 3 SHADOW
PTRIG0  equ $27C                   ;PADDLE 0 TRIGGER
PTRIG1  equ $27D                   ;PADDLE 1 TRIGGER
PTRIG2  equ $27E                   ;PADDLE 2 TRIGGER
PTRIG3  equ $27F                   ;PADDLE 3 TRIGGER
PTRIG4  equ $280                   ;PADDLE 4 TRIGGER
PTRIG5  equ $281                   ;PADDLE 5 TRIGGER
PTRIG6  equ $282                   ;PADDLE 6 TRIGGER
PTRIG7  equ $283                   ;PADDLE 7 TRIGGER
STRIG0  equ $284                   ;JOYSTICK 0 TRIGGER
STRIG1  equ $285                   ;JOYSTICK 1 TRIGGER
STRIG2  equ $286                   ;JOYSTICK 2 TRIGGER
STRIG3  equ $287                   ;JOYSTICK 3 TRIGGER

CSTAT   equ $288                   ;(UNUSED)
WMODE   equ $289                   ;R/W FLAG FOR CASSETTE
BLIM    equ $28A                   ;BUFFER LIMIT (CASSETTE)
                                ;($28B - $28F SPARE)
TXTROW  equ $290                   ;TEXT ROWCRS
TXTCOL  equ $291                   ;TEXT ROWCOL
TINDEX  equ $293                   ;TEXT INDEX
TXTMSC  equ $294                   ;FOOLS CONVRT INTO NEW MSC
TXTOLD  equ $296                   ;OLDROW & OLDCOL FOR TEXT (AND THEN SOME)
TMPX1   equ $29C
HOLD3   equ $29D
SUBTMP  equ $29E
HOLD2   equ $29F
DMASK   equ $2A0
TMPLBT  equ $2A1
ESCFLG  equ $2A2                   ;ESCAPE FLAG
TABMAP  equ $2A3                   ;TAB BUFFER
LOGMAP  equ $2B2                   ;LOGICAL LINE START BIT MAP
INVFLG  equ $2B6                   ;INVERSE VIDEO FLAG (ATARI KEY)
FILFLG  equ $2B7                   ;RIGHT FILL FLAG FOR DRAW
TMPROW  equ $2B8
TMPCOL  equ $2B9
SCRFLG  equ $2BB                   ;SET IF SCROLL OCCURS
HOLD4   equ $2BC                   ;MORE DRAW TEMPS
HOLD5   equ $2BD
SHFLOK  equ $2BE                   ;SHIFT LOCK KEY
BOTSCR  equ $2BF                   ;BOTTOM OF SCREEN (24 NORM, 4 SPLIT)

PCOLR0  equ $2C0                   ;P0 COLOR
PCOLR1  equ $2C1                   ;P1 COLOR
PCOLR2  equ $2C2                   ;P2 COLOR
PCOLR3  equ $2C3                   ;P3 COLOR
COLOR0  equ $2C4                   ;COLOR 0
COLOR1  equ $2C5
COLOR2  equ $2C6
COLOR3  equ $2C7
COLOR4  equ $2C8                   ;BACKGROUND
                                ;($2C9 - $2DF SPARE)
GLBABS  equ $2E0                   ;GLOBAL VARIABLES
                                ;($2E0 - $2E3 SPARE)
RAMSIZ  equ $2E4                   ;RAM SIZE (HI BYTE ONLY)
MEMTOP  equ $2E5                   ;TOP OF AVAILABLE MEMORY
MEMLO   equ $2E7                   ;BOTTOM OF AVAILABLE MEMORY
                                ;($2E9 SPARE)
DVSTAT  equ $2EA                   ;STATUS BUFFER
CBAUDL  equ $2EE                   ;CASSETTE BAUD RATE (LO BYTE)
CBAUDH  equ $2EF                   ;   "      "    "   (HI BYTE)
CRSINH  equ $2F0                   ;CURSOR INHIBIT (00 = CURSOR ON)
KEYDEL  equ $2F1                   ;KEY DELAY
CH1     equ $2F2
CHACT   equ $2F3                   ;CHACTL REGISTER (SHADOW)
CHBAS   equ $2F4                   ;CHBAS REGISTER (SHADOW)
                                ;($2F5 - $2F9 SPARE)
CHAR    equ $2FA
ATACHR  equ $2FB                   ;ATASCII CHARACTER
CH      equ $2FC                   ;GLOBAL VARIABLE FOR KEYBOARD
FILDAT  equ $2FD                   ;RIGHT FILL DATA (DRAW)
DSPFLG  equ $2FE                   ;DISPLAY FLAG: DISP CONTROLS IF NON-ZERO
SSFLAG  equ $2FF                   ;START/STOP FLAG (CNTL-1) FOR PAGING

;       PAGE 3 LOCATIONS

DCB     equ $300                   ;DEVICE CONTROL BLOCK
DDEVIC  equ $300                   ;BUS I.D. NUMBER
DUNIT   equ $301                   ;UNIT NUMBER
DCOMND  equ $302                   ;BUS COMMAND
DSTATS  equ $303                   ;COMMAND TYPE/STATUS RETURN
DBUFLO  equ $304                   ;DATA BUFFER POINTER
DBUFHI  equ $305                   ; ...
DTIMLO  equ $306                   ;DEVICE TIME OUT IN 1 SEC. UNITS
DUNUSE  equ $307                   ;UNUSED
DBYTLO  equ $308                   ;BYTE COUNT
DBYTHI  equ $309                   ; ...
DAUX1   equ $30A                   ;COMMAND AUXILLARY BYTES
DAUX2   equ $30B                   ; ...

TIMER1  equ $30C                   ;INITIAL TIMER VALUE
ADDCOR  equ $30E                   ;ADDITION CORRECTION
CASFLG  equ $30F                   ;CASSETTE MODE WHEN SET
TIMER2  equ $310                   ;FINAL TIME VALUE (USED TO COMPUTE BAUD RATE)
TEMP1   equ $312                   ;TEMP LOCATIONS
TEMP2   equ $314                   ; ...
TEMP3   equ $315                   ; ...
SAVIO   equ $316                   ;SAVE SERIAL IN DATA PORT
TIMFLG  equ $317                   ;TIME OUT FLAG FOR BAUD RATE CORRECTION
STACKP  equ $318                   ;SIO STACK POINTER SAVE LOC
TSTAT   equ $319                   ;TEMP STATUS LOC

HATABS  equ $31A                   ;HANDLER ADDRESS TABLE 
MAXDEV  equ $21                    ;MAXIMUM HANDLER ADDRESS INDEX

;       IOCB OFFSETS 

IOCB    equ $340                   ;I/O CONTROL BLOCKS
ICHID   equ $340                   ;HANDLER INDEX ($FF = FREE)
ICDNO   equ $341                   ;DEVICE NUMBER (DRIVE NUMBER)
ICCOM   equ $342                   ;COMMAND CODE
ICSTA   equ $343                   ;STATUS
ICBAL   equ $344                   ;BUFFER ADDRESS
ICBAH   equ $345                   ; ...
ICPTL   equ $346                   ;PUT BYTE ROUTINE ADDRESS - 1
ICPTH   equ $347                   ; ...
ICBLL   equ $348                   ;BUFFER LENGTH
ICBLH   equ $349                   ; ...
ICAX1   equ $34A                   ;AUXILLARY INFO
ICAX2   equ $34B                   ; ...
ICSPR   equ $34C                   ;4 SPARE BYTES

PRNBUF  equ $3C0                   ;PRINTER BUFFER
                                ;($3EA - $3FC SPARE)

;       PAGE 4 LOCATIONS

CASBUF  equ $3FD                   ;CASSETTE BUFFER

; USER AREA STARTS HERE AND GOES TO THE END OF PAGE 5

USAREA  equ $480

;ATASCII CHARACTER DEFS

ATCLR   equ $7D                    ;CLEAR SCREEN CHARACTER
ATRUB   equ $7E                    ;BACK SPACE (RUBOUT)
ATTAB   equ $7F                    ;TAB
ATEOL   equ $9B                    ;END-OF-LINE
ATBEL   equ $FD                    ;CONSOLE BELL
ATURW   equ $1C                    ;UP-ARROW
ATDRW   equ $1D                    ;DOWN-ARROW
ATLRW   equ $1E                    ;LEFT-ARROW
ATRRW   equ $1F                    ;RIGHT-ARROW

; USEFUL VALUES

LEDGE   equ 2                      ;LMARGN'S INITIAL VALUE
REDGE   equ 39                     ;RMARGN'S INITIAL VALUE

ZPC     equ 0              ;PC CODE FOR ZERO PAGE PC
P6PC    equ 1              ;PC CODE FOR PAGE 6
PPC     equ 2              ;PC CODE FOR PROGRAM MEMORY

;INIT PC VALUES

CURPC   equ 0
PC0     equ 0              ;PAGE ZERO
PC1     equ $600           ;PAGE 6 PC
PC2     equ $3800          ;PROGRAM PC

;.MACRO  PCBRK
;  .PRINT PC0    ;PAGE ZERO BREAK
;  .PRINT PC1    ;PAGE 6 BREAK
;  .PRINT PC2    ;PROGRAM BREAK
;.ENDM

;; ***** KIM SYSTEM DEFS *****
;
;; .MACRO  KIMDEF
;
;;LOCATIONS IN 6530-002 I/O
;
;KSAD    equ $1740          ;PORT A DATA
;KPADD   equ $1741          ;PORT A DATA DIRECTION
;KSBD    equ $1742          ;PORT B DATA
;KSBDD   equ $1743          ;PORT B DATA DIRECTION
;KC1T    equ $1744          ;CLOCK /1
;KC8T    equ $1745          ;CLOCK /8
;KC64T   equ $1746          ;CLOCK /64
;KCKT    equ $1747          ;CLOCK /1024
;
;;LOCATIONS IN 6530-003 I/O
;
;PAD     equ $1700          ;PORT A DATA
;PADD    equ $1701          ;PORT A DATA DIRECTION
;PBD     equ $1702          ;PORT B DATA
;PBDD    equ $1703          ;PORT B DATA DIRECTION
;CLK1T   equ $1704          ;CLOCK /1
;CLK8T   equ $1705          ;CLOCK /8
;CLK64T  equ $1706          ;CLOCK /64
;CLKKT   equ $1707          ;CLOCK /1024
;IC1T    equ $170C          ;CLOCK /1 INTS ENABLED
;IC8T    equ $170D          ;CLOCK /8       "
;IC64T   equ $170E          ;CLOCK /64      "
;ICKT    equ $170F          ;CLOCK /1024    "
;
;KRAM    equ $1780          ;SCRATCH PAD RAM
;KRAMX   equ $17FF          ;KRAM END
;;PAGE ZERO VARIABLES USED BY KIM MONITOR
;
;PCL     equ $EF            ;PROGRAM COUNTER
;PCH     equ $F0
;PS      equ $F1            ;PROCESSOR STATUS REG
;SP      equ $F2            ;STACK POINTER
;AC      equ $F3            ;ACCUMULATOR
;YREG    equ $F4            ;Y INDEX
;XREG    equ $F5            ;X INDEX
;CHKSUM  equ $F6            ;CHECKSUM TEMP (2 BYTES)
;INBUF   equ $F8            ;INPUT BUFFER (2 BYTES)
;POINT   equ $FA            ;OPEN CELL ADDRS (2 BYTES)
;TEMP    equ $FC            ;TEMPORARY
;TMPX    equ $FD            ;TEMPORARY X SAVE
;CHAR    equ $FE            ;INPUT CHARACTER
;MODE    equ $FF            ;ADDRS/DATA FLAG FOR DPY
;
;;PAGE 23 VARIABLES USED BY KIM MONITOR
;
;CHKL    equ $17E7          ;ANOTHER CHECKSUM
;CHKH    equ $17E8
;SAVX    equ $17E9          ;3 BYTE SCRATCH AREA
;VEB     equ $17EC          ;6 BYTE PROGRAM FOR CASETTE CODE
;CNTL    equ $17F2          ;TTY DELAY COUNT
;CNTH    equ $17F3
;TIMH    equ $17F4          ;TEMP FOR TTY TIMING
;SAL     equ $17F5          ;START ADDRS FOR CASETTE
;SAH     equ $17F6
;EAL     equ $17F7          ;END ADDRS FOR CASSETE
;EAH     equ $17F8
;CID     equ $17F9          ;FILE ID FOR CASETTE
;
;;INTERUPT VECTORS
;
;NMIV    equ $17FA          ;NMI VECTOR (STOP := $1C00)
;RSTV    equ $17FC          ;RESET VECTOR
;IRQV    equ $17FE          ;IRQ VECTOR (BRK := $1C00)
;;VARIOUS HANDY ROUTINE LOCATIONS IN KIM MONITOR
;
;SAVE    equ $1C00          ;KIM ENTRY TO SAVE WORLD FIRST
;SAVER   equ $1C05          ;KIM ENTRY VIA JSR (A LOST)
;RESET   equ $1C22          ;KIM RESET ENTRY
;KIM     equ $1C4F          ;KIM START ADDRS
;GOEXEC  equ $1DC8          ;RESTORE MACHINE AND RETURN
;PRTPNT  equ $1E1E          ;ROUTINE TO PRINT "POINT" (CALLS CHK)
;CRLF    equ $1E2F          ;PRINT CRLF
;PRTBYT  equ $1E3B          ;PRINT 1 HEX BYTE AS 2 ASCII CHARS
;                        ;A PRESERVED
;HEXTA   equ $1E4C          ;PRINT 1 ASCII HEX DIGIT (4 BITS)
;GETCH   equ $1E5A          ;GET CHARACTER (PRESERVES X)
;INITS   equ $1E88          ;INITIALIZATION
;OUTSP   equ $1E9E          ;PRINT A SPACE
;OUTCH   equ $1EA0          ;PRINT CHARACTER IN A
;AK      equ $1EFE          ;KEYBOARD ROUTINE
;SCANDS  equ $1F1F          ;DISPLAY F9-FB
;INCPT   equ $1F63          ;INCREMENT "POINT"
;GETKEY  equ $1F6A          ;GET KEY FROM KEYBOARD
;CHK     equ $1F91          ;CHECKSUM ROUTINE (COMPUTES "CHKSUM")
;GETBYT  equ $1F9D          ;GET 2 ASCII CHARS INTO HEX BYTE
;                        ;X PRESERVED
;PACK    equ $1FAC          ;PACK CHAR INTO INPUT BUFFER
;                        ;RETURNS A=0 IF HEX CHAR
;OPEN    equ $1FCC          ;COPIES INBUF TO POINT
;DPYTAB  equ $1FE7          ;HEX TO 7 SEGMENT TABLE
;
;;ROUTINES IN CASSETTE DRIVER
;
;CHKT    equ $194C          ;COMPUTE CHKSUM FOR TAPE
;INTVEB  equ $1932          ;INIT VEB WITH SAL,SAH / CLEAR CHKSUM
;INCVEB  equ $19EA          ;INCREMENT VEB+1,2
;RDBYT   equ $19F3          ;READ BYTE FROM TAPE
;PACKT   equ $1A00          ;PACK ASCII INTO SAVX
;RDCHT   equ $1A24          ;GET 1 CHAR FROM TAPE
;RDBIT   equ $1A41          ;GET 1 BIT FROM TAPE IN SIGN OF A
;DUMPT   equ $1800          ;DUMP MEM TO TAPE
;LOADT   equ $1873          ;LOAD MEM FROM TAPE
;
;ZPC     equ 0              ;PC CODE FOR ZERO PAGE PC
;PPC     equ 1              ;PC CODE FOR PROGRAM PC
;KPC     equ 2              ;PC CODE FOR KRAM PC
;XPC     equ 3              ;PC CODE FOR LOW 1K
;
;;INIT PC VALUES
;
;CURPC   equ 0
;PC0     equ 0              ;PAGE ZERO
;PC1     equ $200           ;PROGRAM PC
;PC2     equ KRAM           ;KRAM PC
;PC3     equ $200           ;PC FOR LOW 1K


;GENERAL 6502 DEFS

; .MACRO  M6502

;ASCII CHARACTER DEFS

; TODO: Convert octal to hex

;CHNUL   equ @00                    ;NULL
;CHSOH   equ @01                    ;SOH
;CHSTX   equ @02
;CHETX   equ @03
;CHEOT   equ @04
;CHENQ   equ @05
;CHACK   equ @06
;CHBEL   equ @07
;CHBS    equ @10
;CHTAB   equ @11
;CHLF    equ @12
;CHVT    equ @13
;CHFF    equ @14
;CHCR    equ @15
;CHSO    equ @16
;CHSI    equ @17
;CHDLE   equ @20
;CHDC1   equ @21
;CHDC2   equ @22
;CHDC3   equ @23
;CHDC4   equ @24
;CHNAK   equ @25
;CHSYN   equ @26
;CHETB   equ @27
;CHCAN   equ @30
;CHEM    equ @31
;CHSUB   equ @32
;CHESC   equ @33
;CHFS    equ @34
;CHGS    equ @35
;CHRS    equ @36
;CHUS    equ @37
;CHSP    equ @40
;        
;CHRUB   equ @177
