//_dummyallign
//.dsb 4


//.dsb 256-(*&255) // tres important !!!
randtable   // 0-255
.byt $ef,$de,$6e,$fa,$b3,$f4,$ea,$ab,$8c,$f1,$4b,$84,$4c,$bd,$11,$72;
.byt $e0,$74,$66,$f9,$59,$14,$2b,$22,$06,$36,$25,$cd,$0a,$82,$6a,$d8;
.byt $d6,$87,$b4,$78,$7e,$d0,$03,$db,$46,$33,$1c,$a7,$3d,$73,$b7,$df;
.byt $4e,$e4,$b2,$21,$d7,$ac,$be,$86,$e6,$c9,$19,$e7,$8a,$68,$f5,$95;
.byt $0e,$56,$38,$e5,$5f,$f8,$16,$f3,$d4,$93,$a0,$d2,$12,$fb,$7d,$1d;
.byt $69,$32,$e8,$b5,$e9,$b9,$a5,$8e,$a3,$cc,$08,$d1,$4d,$c5,$d3,$a8;
.byt $bb,$62,$81,$ec,$2a,$c7,$23,$13,$1b,$af,$2c,$a2,$9f,$fc,$41,$7a;
.byt $64,$57,$8b,$cf,$92,$a9,$b1,$91,$b6,$45,$58,$ce,$c8,$e1,$79,$50;
.byt $94,$ad,$80,$2f,$e3,$6d,$40,$7b,$44,$ae,$c2,$01,$63,$29,$ca,$b8;
.byt $d5,$85,$eb,$26,$00,$7c,$6b,$a6,$5b,$a1,$fd,$c4,$6c,$f7,$3c,$0d;
.byt $5d,$55,$43,$6f,$27,$bc,$3e,$7f,$10,$9a,$96,$5a,$bf,$dd,$60,$47;
.byt $8d,$c1,$52,$1a,$fe,$90,$83,$1f,$3a,$0f,$34,$24,$39,$17,$c6,$35;
.byt $42,$48,$18,$20,$f2,$e2,$75,$2d,$0c,$70,$0b,$d9,$89,$53,$15,$4a;
.byt $97,$77,$a4,$3b,$ee,$09,$4f,$3f,$b0,$88,$02,$71,$c3,$51,$9b,$8f;
.byt $9c,$c0,$ff,$99,$37,$65,$07,$49,$30,$ed,$5c,$9d,$ba,$da,$cb,$1e;
.byt $98,$04,$54,$28,$9e,$f6,$5e,$76,$31,$dc,$61,$2e,$aa,$67,$f0,$05;

tablemul2
.byt 0,2,4,6,8,10,12,14,16,18,20
.byt 22,24,26,28,30,32,34,36,38,40
.byt 42,44,46,48,50,52,54,56,58,60
.byt 62,64,66,68,70,72,74,76,78,80
.byt 82,84,86,88,90,92,94,96,98,100
.byt 102,104,106,108,110,112,114,116,118,120
.byt 122,124,126,128,130,132,134,136,138,140
.byt 142,144,146,148,150,152,154,156,158,160

_unbuff
.dsb 1120-969,"."

_STRING_BOULDERDASH_TITLE
//         0000000000111111111122222222223333333333
//         0123456789012345678901234567890123456789
.byt  16,31,"++",3,"     NOT ANOTHER        ",3,96," PSYPOKER" 
.byt  16,31,"  ****+                  ",3,"  15.01.2023"
.byt  16,31,"  **+ *+****+**+*+**+  ***+ ****+***+ "
.byt  16,31,"  ****+ **+*+**+*+**+  **+*+**+  **+*+"
.byt  16,31,"  **+ *+**+*+**+*+**+  **+*+***+ ***+ "
.byt  16,31,"  **+ *+**+*+**+*+**+  **+*+**+  ****+"
.byt  16,31,"  *****+****+****+****+****+****+**+*+"
.byt  16,31,"  ****+ ****+****+****+***+ ****+**+*+"
.byt  16,31,10                                
.byt  16,31,"        ****+",7,"              TM",10
.byt  16,31,"        **+ *+ **+ ****+**+*+",10
.byt  16,31,"        **+ *+**+*+**+  **+*+",10
.byt  16,31,"  ",9,"WXY",8," **+ *+****+****+****+",9," EFG",10
.byt  16,31,"  ",9,"Z[\",8," **+ *+**+*+  **+**+*+",9," HIJ",10
.byt  16,31,"        *****+**+*+****+**+*+",10
.byt  16,31,"        ****+ **+*+****+**+*+",5,"  FINAL!" 
.byt  16,31,"    Git And Cheats! ",3,"  CLONE ! ",5,"REV126" 
//        0000000000111111111122222222223333333333
//        0123456789012345678901234567890123456789
.byt  23,1,"      FOR THE ORIC ATMOS 48K",10
.byt  16,1,12,"DISCLAIMER! UNOFFICIAL FAN RELEASE",10
.byt  6,"GAME CONCEPT BY P.LIEPA AND C.GRAY",10
.byt  5,"LICENSED FROM FIRSTSTARSOFTWARE INC.",10
.byt  6,"CONVERSION BY SEB WITH THE GREAT OSDK",10
.byt  5,"INSPIRED FROM CODEINCOMPLETE.COM",10
.byt  2,"ARROWS:MOVE SPACE:GRAB1 DEADKEYS:GRAB2",10
.byt  2,"DEL:PREV RETURN:NEXT ESC:RESET S:SOUND",10
.byt  2,"C:COLOR I:INV T:TXT G:GFX P:PARAMS ...",10
.byt  16,1,14,"           HIT ANY KEY",10
.byt  16,1,14,"           HIT ANY KEY",10

//"""

_rockford_to_xpos
.byt $00,$00,$00,$00,$00,$00,$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1A,$1B,$1B,$1B,$1B,$1B,$1B,$1B




_rockford_to_ypos
.byt $00,$00,$00,$00,$00,$00,$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$09,$09,$09,$09,$09,$09

table_mult_80_lo
.byt $00,$50,$A0,$F0,$40,$90,$E0,$30,$80,$D0,$20,$70,$C0,$10,$60,$B0,$00,$50,$A0,$F0,$40,$90
 
table_mult_80_hi
.byt $00,$00,$00,$00,$01,$01,$01,$02,$02,$02,$03,$03,$03,$04,$04,$04,$05,$05,$05,$05,$06,$06
 
/*"
/*********************************************************************************************
_OBJECT
_SPACE:             { code: 0x00, rounded: false, explodable: false, consumable: true  },
_DIRT:              { code: 0x01, rounded: false, explodable: false, consumable: true  },
_BRICKWALL:         { code: 0x02, rounded: true,  explodable: false, consumable: true  },
_MAGICWALL:         { code: 0x03, rounded: false, explodable: false, consumable: true  },
_PREOUTBOX:         { code: 0x04, rounded: false, explodable: false, consumable: false },
_OUTBOX:            { code: 0x05, rounded: false, explodable: false, consumable: false },

_STEELWALL:         { code: 0x07, rounded: false, explodable: false, consumable: false },
_FIREFLY1:          { code: 0x08, rounded: false, explodable: true,  consumable: true  },
_FIREFLY2:          { code: 0x09, rounded: false, explodable: true,  consumable: true  },
_FIREFLY3:          { code: 0x0A, rounded: false, explodable: true,  consumable: true  },
_FIREFLY4:          { code: 0x0B, rounded: false, explodable: true,  consumable: true  },

_BOULDER:           { code: 0x10, rounded: true,  explodable: false, consumable: true  },

_BOULDERFALLING:    { code: 0x12, rounded: false, explodable: false, consumable: true  },

_DIAMOND:           { code: 0x14, rounded: true,  explodable: false, consumable: true  },

_DIAMONDFALLING:    { code: 0x16, rounded: false, explodable: false, consumable: true  },

_EXPLODETOSPACE0:   { code: 0x1B, rounded: false, explodable: false, consumable: false },
_EXPLODETOSPACE1:   { code: 0x1C, rounded: false, explodable: false, consumable: false },
_EXPLODETOSPACE2:   { code: 0x1D, rounded: false, explodable: false, consumable: false },
_EXPLODETOSPACE3:   { code: 0x1E, rounded: false, explodable: false, consumable: false },
_EXPLODETOSPACE4:   { code: 0x1F, rounded: false, explodable: false, consumable: false },
_EXPLODETODIAMOND0: { code: 0x20, rounded: false, explodable: false, consumable: false },
_EXPLODETODIAMOND1: { code: 0x21, rounded: false, explodable: false, consumable: false },
_EXPLODETODIAMOND2: { code: 0x22, rounded: false, explodable: false, consumable: false },
_EXPLODETODIAMOND3: { code: 0x23, rounded: false, explodable: false, consumable: false },
_EXPLODETODIAMOND4: { code: 0x24, rounded: false, explodable: false, consumable: false },
_PREROCKFORD1:      { code: 0x25, rounded: false, explodable: false, consumable: false },
_PREROCKFORD2:      { code: 0x26, rounded: false, explodable: false, consumable: false },
_PREROCKFORD3:      { code: 0x27, rounded: false, explodable: false, consumable: false },
_PREROCKFORD4:      { code: 0x28, rounded: false, explodable: false, consumable: false },
_BUTTERFLY1:        { code: 0x30, rounded: false, explodable: true,  consumable: true  },
_BUTTERFLY2:        { code: 0x31, rounded: false, explodable: true,  consumable: true  },
_BUTTERFLY3:        { code: 0x32, rounded: false, explodable: true,  consumable: true  },
_BUTTERFLY4:        { code: 0x33, rounded: false, explodable: true,  consumable: true  },
_ROCKFORD:          { code: 0x38, rounded: false, explodable: true,  consumable: true  },
_AMOEBA:            { code: 0x3A, rounded: false, explodable: false, consumable: true  }
**********************************************************************************************/

/*********************************************************************************************
ROCKFORD:          { code: 0x38, rounded: false, explodable: true,  consumable: true,

$00 Space
$01 Dirt
$02 Brick wall
$03 Magic wall
$04 Pre outbox (ie before it starts flashing)
$05 Flashing outbox
$06 *
$07 Steel wall
$08 Firefly position 1
$09 Firefly position 2
$0A Firefly position 3
$0B Firefly position 4
$0C Firefly position 1, scanned this frame
$0D Firefly position 2, scanned this frame
$0E Firefly position 3, scanned this frame
$0F Firefly position 4, scanned this frame
$10 Boulder, stationary
$11 Boulder, stationary, scanned this frame
$12 Boulder, falling
$13 Boulder, falling, scanned this frame
$14 Diamond, stationary
$15 Diamond, stationary, scanned this frame
$16 Diamond, falling
$17 Diamond, falling, scanned this frame
$18
$19
$1A
$1B Explode to Space stage 0
$1C Explode to Space stage 1
$1D Explode to Space stage 2
$1E Explode to Space stage 3
$1F Explode to Space stage 4
$20 Explode to Diamond stage 0
$21 Explode to Diamond stage 1
$22 Explode to Diamond stage 2
$23 Explode to Diamond stage 3
$24 Explode to Diamond stage 4
$25 Pre Rockford stage 1 (ie when inbox morphs into Rockford)
$26 Pre Rockford stage 2
$27 Pre Rockford stage 3
$28 Pre Rockford stage 4
$29
$2A
$2B
$2C
$2D
$2E
$2F
$30 Butterfly position 1
$31 Butterfly position 2
$32 Butterfly position 3
$33 Butterfly position 4
$34 Butterfly position 1, scanned this frame
$35 Butterfly position 2, scanned this frame
$36 Butterfly position 3, scanned this frame
$37 Butterfly position 4, scanned this frame
$38 Rockford
$39 Rockford, scanned this frame
$3A Amoeba
$3B Amoeba, scanned this frame
$3C
$3D
$3E *
$3F *
****************************************************************************************/
/*"*/

_table 
//   1stchar|object id & name
.byt 111    ;0 space
.byt 33     ;1 dirt
.byt 39+128 ;2 brick
.byt 45+128 ;3 magic
.byt 51+128 ;4 preout
.byt 51+128 ;5 outbox
.byt 0      ;6
.byt 57+128 ;7 steelwall
.byt 63+128 ;8 firefly1
.byt 63+128 ;9 firefly2
.byt 63+128 ;a firefly3
.byt 63+128 ;b firefly4
.byt 0+128  ;c firefly1 scanned this frame
.byt 0+128  ;d firefly2 scanned this frame
.byt 0+128  ;e firefly3 scanned this frame
.byt 0+128  ;f firefly4 scanned this frame
.byt 69     ;10 boulder
.byt 0      ;11 boulder scanned this frame
.byt 69+128 ;12 boulder falling
.byt 69     ;13 boulder falling scanned this frame
.byt 75     ;14 diamond
.byt 0      ;15 diamond scanned this frame
.byt 75+128 ;16 diamond falling
.byt 0      ;17 diamond falling scanned this frame
.byt 0      ;18
.byt 0      ;19
.byt 0      ;1a
.byt 99+128 ;1b explode to space 0
.byt 99+128 ;1c explode to space 1
.byt 99+128 ;1d explode to space 2
.byt 99+128 ;1e explode to space 3
.byt 99+128 ;1f explode to space 4

.byt 105+128    ;20 explode to diamond 0
.byt 105+128    ;21 explode to diamond 1
.byt 105+128    ;22 explode to diamond 2
.byt 105+128    ;23 explode to diamond 3
.byt 105+128    ;24 explode to diamond 4 

.byt 51+128 ;25 prerockford 1
.byt 87+128 ;26 prerockford 2
.byt 51+128 ;27 prerockford 3
.byt 87+128 ;28 prerockford 4
.byt 0      ;29
.byt 0      ;2a
.byt 0      ;2b
.byt 0      ;2c
.byt 0      ;2d
.byt 0      ;2e
.byt 0      ;2f
.byt 81     ;30 BUTTERFLY 1
.byt 81     ;31 BUTTERFLY 2
.byt 81     ;32 BUTTERFLY 3
.byt 81     ;33 BUTTERFLY 4
.byt 81     ;34 BUTTERFLY 1 STF
.byt 81     ;35 BUTTERFLY 2 STF
.byt 81     ;36 BUTTERFLY 3 STF
.byt 81     ;37 BUTTERFLY 4 STF
.byt 87     ;38 ROCKFORD
.byt 87     ;39 ROCKFORD STF
.byt 93+128 ;3a AMOEBA
.byt 93     ;3a AMOEBA STF

/*
 
#define mask_rounded    0x04
#define mask_explodable 0x02
#define mask_consumable 0x01
*/

_table_mask
// index = code  , value = mask (butterfly,0,rounded,explodable,consumable)
//   mask       |object id & name
.byt %00001     ;0 space
.byt %00001     ;1 dirt
.byt %00101     ;2 brick
.byt %00001     ;3 magic
.byt %00000     ;4 preout
.byt %00000     ;5 outbox
.byt 0          ;6
.byt %00000     ;7 steelwall
.byt %01011     ;8 firefly1
.byt %01011     ;9 firefly2
.byt %01011     ;a firefly3
.byt %01011     ;b firefly4
.byt 0          ;c firefly1 scanned this frame
.byt 0          ;d firefly2 scanned this frame
.byt 0          ;e firefly3 scanned this frame
.byt 0          ;f firefly4 scanned this frame
.byt %00101     ;10 boulder
.byt 0          ;11 boulder scanned this frame
.byt %00001     ;12 boulder falling
.byt 0          ;13 boulder falling scanned this frame
.byt %00101     ;14 diamond
.byt 0          ;15 diamond scanned this frame
.byt %00001     ;16 diamond falling
.byt 0          ;17 diamond falling scanned this frame
.byt 0          ;18
.byt 0          ;19
.byt 0          ;1a
.byt %00000     ;1b explode to space 0
.byt %00000     ;1c explode to space 1
.byt %00000     ;1d explode to space 2
.byt %00000     ;1e explode to space 3
.byt %00000     ;1f explode to space 4
.byt %00000     ;20 explode to diamond 0
.byt %00000     ;21 explode to diamond 1
.byt %00000     ;22 explode to diamond 2
.byt %00000     ;23 explode to diamond 3
.byt %00000     ;24 explode to diamond 4 
.byt %00000     ;25 prerockford 1
.byt %00000     ;26 prerockford 2
.byt %00000     ;27 prerockford 3
.byt %00000     ;28 prerockford 4
.byt 0          ;29
.byt 0          ;2a
.byt 0          ;2b
.byt 0          ;2c
.byt 0          ;2d
.byt 0          ;2e
.byt 0          ;2f
.byt %10011     ;30 BUTTERFLY 1
.byt %10011     ;31 BUTTERFLY 2
.byt %10011     ;32 BUTTERFLY 3
.byt %10011     ;33 BUTTERFLY 4
.byt 0          ;34 BUTTERFLY 1 STF
.byt 0          ;35 BUTTERFLY 2 STF
.byt 0          ;36 BUTTERFLY 3 STF
.byt 0          ;37 BUTTERFLY 4 STF
.byt %00011     ;38 ROCKFORD
.byt 0          ;39 ROCKFORD STF
.byt %00001     ;3a AMOEBA
.byt 0          ;3a AMOEBA STF

 
_musictrack1
.byt 53,57,60,65,55,58,60,67,61,63,65,68,63,74,64,72,53,65,48,55,51,67,55,51,53,65,48,55,61,77,65,61,51,63,46,53,59,75,63,59,48,64,50,65,58,58,70,58,65,65,65,65,65,65,65,65,65,65,65,65,65,65,65,65,65,65,65,65,65,65,65,65,65,65,65,65,63,63,63,63,65,77,65,75,65,74,65,72,63,75,63,75,63,70,63,75,65,65,65,65,65,65,65,65,65,65,65,65,63,63,63,63,69,65,60,57,67,63,58,51,69,65,60,57,67,63,58,51

_musictrack2
.byt 41,48,53,56,39,50,51,58,37,37,49,37,51,70,52,68,41,41,41,41,39,39,39,39,41,41,41,41,49,49,49,49,39,39,39,39,47,47,47,47,36,60,36,60,34,34,41,41,41,41,41,41,53,53,41,41,39,39,39,39,51,51,39,39,41,69,41,70,53,69,41,70,39,69,39,70,51,67,39,68,41,41,41,72,53,53,41,68,39,39,39,39,51,51,39,39,41,69,41,70,53,69,41,70,39,69,39,70,51,67,39,68,65,60,57,53,63,58,55,39,72,69,65,60,58,55,51,39

 
 
mod39	// 0-255
.byt $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0a,$0b,$0c,$0d,$0e,$0f;
.byt $10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1a,$1b,$1c,$1d,$1e,$1f;
.byt $20,$21,$22,$23,$24,$25,$26,$00,$01,$02,$03,$04,$05,$06,$07,$08;
.byt $09,$0a,$0b,$0c,$0d,$0e,$0f,$10,$11,$12,$13,$14,$15,$16,$17,$18;

.byt $19,$1a,$1b,$1c,$1d,$1e,$1f,$20,$21,$22,$23,$24,$25,$26,$00,$01;
.byt $02,$03,$04,$05,$06,$07,$08,$09,$0a,$0b,$0c,$0d,$0e,$0f,$10,$11;
.byt $12,$13,$14,$15,$16,$17,$18,$19,$1a,$1b,$1c,$1d,$1e,$1f,$20,$21;
.byt $22,$23,$24,$25,$26,$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0a;
 


_readkeyA
.(
    ldy $208
    cpy #56
    beq exit0

    ldx _peek208-128,y
    rts

exit0
 
    ldx #0
 
    rts
.)


_peek208

.byt "7JMK UY8"
.byt "NT69.IHL"
.byt "5RB..OG0"
.byt "VF4..PE."
.byt "........"
.byt "1.Z...A."
.byt "XQ2...S."
.byt "3DC...W."
.byt "........"


_screen_instructions
.byt "ARROWS QA<>",9,"MOVE",10
.byt "SPACE",9,"TOGGLE GRAB",10
.byt "FUNC SHIFT CTRL",9,"GRAB",10
.byt "ESCAPE",9,"RESTART LEVEL",10
.byt "ENTER",9,"NEXT LEVEL",10
.byt "DEL",9,"PREVIOUS LEVEL",10
.byt "P",9,"PARAMETERS",10
.byt "S",9,"TOGGLE SOUND",10
.byt "M",9,"TOGGLE MUSIC",10
.byt "C",9,"CHANGE COLOR",10
.byt "I",9,"INVERSE MODE",10
.byt "G",9,"GRAPHIC MODE",10
.byt "T",9,"TEXT MODE",10
.byt "H",9,"HELP",10
.byt "P",9,"PAUSE",0

string_parameters
.byt 2,"***+PARAMETERS ***+",0
string_instructions
.byt 2,"***+INSTRUCTIONS ***+",0

string_difficulty
.byt "DIFFICULTY",0
string_musiclevel
.byt "MUSIC LEVEL",0
string_speed
.byt "SPEED",0
string_fps
.byt "FPS",0
string_reg306
.byt "IRQ306",0
string_tempo
.byt "TEMPO",0
string_beatmax
.byt "BEAT MAX",0

/*

unsigned int hiscores[]={808,707,606,505,303,202,101 
char *hinames[]=       {"T R ","T R ","T R ","T R ","T B ","M C ","S H " 

*/

_hiscores
.word 808,707,606,505,303,202,101

_hinames
.word _hinames0,_hinames1,_hinames2,_hinames3,_hinames4,_hinames5,_hinames6

_hinames0
.byt "TR.",0
_hinames1
.byt "TR.",0
_hinames2
.byt "TR.",0
_hinames3
.byt "TR.",0
_hinames4
.byt "TB.",0
_hinames5
.byt "MC.",0
_hinames6
.byt "SH.",0

 



_DATA01
.byt $01, $14, $0A, $0F, $0A, $0B, $0C, $0D, $0E, $0C, $0C, $0C, $0C, $0C, $96, $6E, $46, $28, $1E, $08, $0B, $09, $D4, $20, $00, $10, $14, $00, $3C, $32, $09, $00, $42, $01, $09, $1E, $02, $42, $09, $10, $1E, $02, $25, $03, $04, $04, $26, $12, $FF  
_DATA02
.byt $02, $14, $14, $32, $03, $00, $01, $57, $58, $0A, $0C, $09, $0D, $0A, $96, $6E, $46, $46, $46, $0A, $04, $09, $00, $00, $00, $10, $14, $08, $3C, $32, $09, $02, $42, $01, $08, $26, $02, $42, $01, $0F, $26, $02, $42, $08, $03, $14, $04, $42, $10,
.byt $03, $14, $04, $42, $18, $03, $14, $04, $42, $20, $03, $14, $04, $40, $01, $05, $26, $02, $40, $01, $0B, $26, $02, $40, $01, $12, $26, $02, $40, $14, $03, $14, $04, $25, $12, $15, $04, $12, $16, $FF  
_DATA03 
.byt $03, $00, $0F, $00, $00, $32, $36, $34, $37, $18, $17, $18, $17, $15, $96, $64, $5A, $50, $46, $09, $08, $09, $04, $00, $02, $10, $14, $00, $64, $32, $09, $00, $25, $03, $04, $04, $27, $14, $FF  
_DATA04
.byt $04, $14, $05, $14, $00, $6E, $70, $73, $77, $24, $24, $24, $24, $24, $78, $64, $50, $3C, $32, $04, $08, $09, $00, $00, $10, $00, $00, $00, $14, $00, $00, $00, $25, $01, $03, $04, $26, $16, $81, $08, $0A, $04, $04, $00, $30, $0A, $0B, $81, $10,
.byt $0A, $04, $04, $00, $30, $12, $0B, $81, $18, $0A, $04, $04, $00, $30, $1A, $0B, $81, $20, $0A, $04, $04, $00, $30, $22, $0B, $FF  
_DATA05
.byt $05, $14, $32, $5A, $00, $00, $00, $00, $00, $04, $05, $06, $07, $08, $96, $78, $5A, $3C, $1E, $09, $0A, $09, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $25, $01, $03, $04, $27, $16, $80, $08, $0A, $03, $03, $00, $80, $10, $0A, $03, $03,
.byt $00, $80, $18, $0A, $03, $03, $00, $80, $20, $0A, $03, $03, $00, $14, $09, $0C, $08, $0A, $0A, $14, $11, $0C, $08, $12, $0A, $14, $19, $0C, $08, $1A, $0A, $14, $21, $0C, $08, $22, $0A, $80, $08, $10, $03, $03, $00, $80, $10, $10, $03, $03, $00,
.byt $80, $18, $10, $03, $03, $00, $80, $20, $10, $03, $03, $00, $14, $09, $12, $08, $0A, $10, $14, $11, $12, $08, $12, $10, $14, $19, $12, $08, $1A, $10, $14, $21, $12, $08, $22, $10, $FF  
_DATA06
.byt $06, $14, $28, $3C, $00, $14, $15, $16, $17, $04, $06, $07, $08, $08, $96, $78, $64, $5A, $50, $0E, $0A, $09, $00, $00, $10, $00, $00, $00, $32, $00, $00, $00, $82, $01, $03, $0A, $04, $00, $82, $01, $06, $0A, $04, $00, $82, $01, $09, $0A, $04,
.byt $00, $82, $01, $0C, $0A, $04, $00, $41, $0A, $03, $0D, $04, $14, $03, $05, $08, $04, $05, $14, $03, $08, $08, $04, $08, $14, $03, $0B, $08, $04, $0B, $14, $03, $0E, $08, $04, $0E, $82, $1D, $03, $0A, $04, $00, $82, $1D, $06, $0A, $04, $00, $82,
.byt $1D, $09, $0A, $04, $00, $82, $1D, $0C, $0A, $04, $00, $41, $1D, $03, $0D, $04, $14, $24, $05, $08, $23, $05, $14, $24, $08, $08, $23, $08, $14, $24, $0B, $08, $23, $0B, $14, $24, $0E, $08, $23, $0E, $25, $03, $14, $04, $26, $14, $FF  
_DATA07
.byt $07, $4B, $0A, $14, $02, $07, $08, $0A, $09, $0F, $14, $19, $19, $19, $78, $78, $78, $78, $78, $09, $0A, $0D, $00, $00, $00, $10, $08, $00, $64, $28, $02, $00, $42, $01, $07, $0C, $02, $42, $1C, $05, $0B, $02, $7A, $13, $15, $02, $02, $14, $04,
.byt $06, $14, $04, $0E, $14, $04, $16, $14, $22, $04, $14, $22, $0C, $14, $22, $16, $25, $14, $03, $04, $27, $07, $FF  
_DATA08
.byt $08, $14, $0A, $14, $01, $03, $04, $05, $06, $0A, $0F, $14, $14, $14, $78, $6E, $64, $5A, $50, $02, $0E, $09, $00, $00, $00, $10, $08, $00, $5A, $32, $02, $00, $14, $04, $06, $14, $22, $04, $14, $22, $0C, $04, $00, $05, $25, $14, $03, $42, $01,
.byt $07, $0C, $02, $42, $01, $0F, $0C, $02, $42, $1C, $05, $0B, $02, $42, $1C, $0D, $0B, $02, $43, $0E, $11, $08, $02, $14, $0C, $10, $00, $0E, $12, $14, $13, $12, $41, $0E, $0F, $08, $02, $FF  
_DATA09
.byt $09, $14, $05, $0A, $64, $89, $8C, $FB, $33, $4B, $4B, $50, $55, $5A, $96, $96, $82, $82, $78, $08, $04, $09, $00, $00, $10, $14, $00, $00, $F0, $78, $00, $00, $82, $05, $0A, $0D, $0D, $00, $01, $0C, $0A, $82, $19, $0A, $0D, $0D, $00, $01, $1F,
.byt $0A, $42, $11, $12, $09, $02, $40, $11, $13, $09, $02, $25, $07, $0C, $04, $08, $0C, $FF  
_DATA10
.byt $0A, $14, $19, $3C, $00, $00, $00, $00, $00, $0C, $0C, $0C, $0C, $0C, $96, $82, $78, $6E, $64, $06, $08, $09, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $25, $0D, $03, $04, $27, $16, $54, $05, $04, $11, $03, $54, $15, $04, $11, $05, $80,
.byt $05, $0B, $11, $03, $08, $C2, $01, $04, $15, $11, $00, $0D, $04, $C2, $07, $06, $0D, $0D, $00, $0D, $06, $C2, $09, $08, $09, $09, $00, $0D, $08, $C2, $0B, $0A, $05, $05, $00, $0D, $0A, $82, $03, $06, $03, $0F, $08, $00, $04, $06, $54, $04, $10, $04, $04, $FF  
_DATA11
.byt $0B, $14, $32, $00, $00, $04, $66, $97, $64, $06, $06, $06, $06, $06, $78, $78, $96, $96, $F0, $0B, $08, $09, $00, $00, $00, $10, $08, $00, $64, $50, $02, $00, $42, $0A, $03, $09, $04, $42, $14, $03, $09, $04, $42, $1E, $03, $09, $04, $42, $09,
.byt $16, $09, $00, $42, $0C, $0F, $11, $02, $42, $05, $0B, $09, $02, $42, $0F, $0B, $09, $02, $42, $19, $0B, $09, $02, $42, $1C, $13, $0B, $01, $14, $04, $03, $14, $0E, $03, $14, $18, $03, $14, $22, $03, $14, $04, $16, $14, $23, $15, $25, $14, $14, $04, $26, $11, $FF  
_DATA12
.byt $0C, $14, $14, $00, $00, $3C, $02, $3B, $66, $13, $13, $0E, $10, $15, $B4, $AA, $A0, $A0, $A0, $0C, $0A, $09, $00, $00, $00, $10, $14, $00, $3C, $32, $09, $00, $42, $0A, $05, $12, $04, $42, $0E, $05, $12, $04, $42, $12, $05, $12, $04, $42, $16,
.byt $05, $12, $04, $42, $02, $06, $0B, $02, $42, $02, $0A, $0B, $02, $42, $02, $0E, $0F, $02, $42, $02, $12, $0B, $02, $81, $1E, $04, $04, $04, $00, $08, $20, $05, $81, $1E, $09, $04, $04, $00, $08, $20, $0A, $81, $1E, $0E, $04, $04, $00, $08, $20, $0F, $25, $03, $14,
.byt $04, $27, $16, $FF  
_DATA13
.byt $0D, $8C, $05, $08, $00, $01, $02, $03, $04, $32, $37, $3C, $46, $50, $A0, $9B, $96, $91, $8C, $06, $08, $0D, $00, $00, $10, $00, $00, $00, $28, $00, $00, $00, $25, $12, $03, $04, $0A, $03, $3A, $14, $03, $42, $05, $12, $1E, $02, $70, $05, $13,
.byt $1E, $02, $50, $05, $14, $1E, $02, $C1, $05, $15, $1E, $02, $FF  
_DATA14
.byt $0E, $14, $0A, $14, $00, $00, $00, $00, $00, $1E, $23, $28, $2A, $2D, $96, $91, $8C, $87, $82, $0C, $08, $09, $00, $00, $10, $00, $00, $00, $00, $00, $00, $00, $81, $0A, $0A, $0D, $0D, $00, $70, $0B, $0B, $0C, $03, $C1, $0C, $0A, $03, $0D, $C1,
.byt $10, $0A, $03, $0D, $C1, $14, $0A, $03, $0D, $50, $16, $08, $0C, $02, $48, $16, $07, $0C, $02, $C1, $17, $06, $03, $04, $C1, $1B, $06, $03, $04, $C1, $1F, $06, $03, $04, $25, $03, $03, $04, $27, $14, $FF  
_DATA15
.byt $0F, $08, $0A, $14, $01, $1D, $1E, $1F, $20, $0F, $14, $14, $19, $1E, $78, $78, $78, $78, $8C, $08, $0E, $09, $00, $00, $00, $10, $08, $00, $64, $50, $02, $00, $42, $02, $04, $0A, $03, $42, $0F, $0D, $0A, $01, $41, $0C, $0E, $03, $02, $43, $0C,
.byt $0F, $03, $02, $04, $14, $16, $25, $14, $03, $FF  
_DATA16
.byt $10, $14, $0A, $14, $01, $78, $81, $7E, $7B, $0C, $0F, $0F, $0F, $0C, $96, $96, $96, $96, $96, $09, $0A, $09, $00, $00, $10, $00, $00, $00, $32, $00, $00, $00, $25, $01, $03, $04, $27, $04, $81, $08, $13, $04, $04, $00, $08, $0A, $14, $C2, $07,
.byt $0A, $06, $08, $43, $07, $0A, $06, $02, $81, $10, $13, $04, $04, $00, $08, $12, $14, $C2, $0F, $0A, $06, $08, $43, $0F, $0A, $06, $02, $81, $18, $13, $04, $04, $00, $08, $1A, $14, $81, $20, $13, $04, $04, $00, $08, $22, $14, $FF  
_DATA17
.byt $11, $14, $1E, $00, $0A, $0B, $0C, $0D, $0E, $06, $06, $06, $06, $06, $0A, $0A, $0A, $0A, $0A, $0E, $02, $09, $00, $00, $00, $14, $00, $00, $FF, $09, $00, $00, $87, $00, $02, $28, $16, $07, $87, $00, $02, $14, $0C, $00, $32, $0A, $0C, $10, $0A,
.byt $04, $01, $0A, $05, $25, $03, $05, $04, $12, $0C, $FF  
_DATA18
.byt $12, $14, $0A, $00, $0A, $0B, $0C, $0D, $0E, $10, $10, $10, $10, $10, $0F, $0F, $0F, $0F, $0F, $06, $0F, $09, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $87, $00, $02, $28, $16, $07, $87, $00, $02, $14, $0C, $01, $50, $01, $03, $09, $03,
.byt $48, $02, $03, $08, $03, $54, $01, $05, $08, $03, $50, $01, $06, $07, $03, $50, $12, $03, $09, $05, $54, $12, $05, $08, $05, $50, $12, $06, $07, $05, $25, $01, $04, $04, $12, $04, $FF  
_DATA19
.byt $13, $04, $0A, $00, $0A, $0B, $0C, $0D, $0E, $0E, $0E, $0E, $0E, $0E, $14, $14, $14, $14, $14, $06, $08, $09, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $87, $00, $02, $28, $16, $07, $87, $00, $02, $14, $0C, $00, $54, $01, $0C, $12, $02,
.byt $88, $0F, $09, $04, $04, $08, $25, $08, $03, $04, $12, $07, $FF  
_DATA20
.byt $14, $03, $1E, $00, $00, $00, $00, $00, $00, $06, $06, $06, $06, $06, $14, $14, $14, $14, $14, $06, $08, $09, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $87, $00, $02, $28, $16, $07, $87, $00, $02, $14, $0C, $01, $D0, $0B, $03, $03, $02,
.byt $80, $0B, $07, $03, $06, $00, $43, $0B, $06, $03, $02, $43, $0B, $0A, $03, $02, $50, $08, $07, $03, $03, $25, $03, $03, $04, $09, $0A, $FF  


_EXPLODETODIAMOND
.byt $20,$21,$22,$23,$24,$14  ; OBJECT_EXPLODETODIAMOND0,OBJECT_EXPLODETODIAMOND1,OBJECT_EXPLODETODIAMOND2,OBJECT_EXPLODETODIAMOND3,OBJECT_EXPLODETODIAMOND4,OBJECT_DIAMOND