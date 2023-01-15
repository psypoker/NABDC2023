
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
GAME                = _game 
GAME_FRAME			=	0
GAME_BIRTH			=	2
GAME_TIMER			=	3
GAME_INDEX			=   4
GAME_FPS			=	5
GAME_FPS4			=	6
GAME_FPSMASK		=	7
GAME_FRAMESTEP		=	8
GAME_FRAMEFF		=	9
GAME_FLASH			=	10
GAME_WON			=	12
GAME_FOUNDROCKFORD	=	13
 

MAGIC 			=	__magic
MAGIC_ACTIVE	=	0
MAGIC_TIME		=	1

AMOEBA			=	__amoeba
AMOEBA_SLOW		=	0
AMOEBA_SIZE		=	1
AMOEBA_ENCLOSED =  	2
AMOEBA_DEAD		=   3

IDLE 			=	__idle
IDLE_BLINK		=	0
IDLE_TAP		=	1

MOVING   		=	_moving
MOVING_GRAB		=	0
MOVING_DIR      =	1
MOVING_DIROFFSET=   2

DIAMONDS 				= __diamonds
DIAMONDS_COLLECTED 		= 0
DIAMONDS_NEEDED			= 1
DIAMONDS_VALUE 			= 2
DIAMONDS_EXTRA 			= 3
DIAMONDS_CURRENTVALUE 	= 4
DIAMONDS_ENOUGH 		= 5
 


REG_P			= 	tmp4
REG_P2			= 	tmp5
REG_P3			=	tmp6

 
#define DEFAULT_TEMPO 4
#define DEFAULT_BEAT 7
#define DEFAULT_MUSICLEVEL 8
#define DEFAULT_FPS 15
#define DEFAULT_306 $2000

_resetDefParams
.(
	lda #0
	sta _beat
	lda #DEFAULT_TEMPO
	sta _tempobase
	sta _tempovalue
	sta _tempo
	lda #DEFAULT_MUSICLEVEL
	sta _musiclevel
	lda #DEFAULT_FPS
	sta GAME+GAME_FPS
	lda #255
	sta _speed
	lda #0
	sta _speed+1
	sei
	lda #<DEFAULT_306
	sta _reg306
	lda #>DEFAULT_306
	sta _reg306+1
	cli
	lda #0
	sta _difficulty
	rts
.)


_updateBoulderOrDiamondA
.(
	//	pdown = p + OFFDIR_DOWN;
 

	//	if (isEmpty(pdown))
	ldy #80
	lda (REG_P),y 
	bne isnotemptypdown 
 
 	// setCell(p, objectfalling);
	lda _objectfalling 
	ldy #0
	sta (REG_P),y 

 	lda GAME+GAME_FRAME 
 	iny
	sta (REG_P),y 

exit1
	rts


isnotemptypdown
 	// if (isRounded(pdown))
	tax
	lda _table_mask,x
	and #%00000100
	beq exit1
    
    // pleft = p+OFFDIR_LEFT; // p-2
 	// if (isEmpty(pleft))
	ldy #$fe
	dec REG_P+1
	lda (REG_P),y
	
	bne isnotemptypleft
	inc REG_P+1
	// pdownleft = p+OFFDIR_DOWNLEFT;
	ldy #78
	// if (isEmpty(pdownleft))
	lda (REG_P),y
	bne skip11

	//	moveCell(p,pleft,objectfalling);
	ldy #0
	lda #0
	sta (REG_P),y
	lda _objectfalling
	ldy #$fe
	dec REG_P+1
	sta (REG_P),y
	lda GAME+GAME_FRAME
	iny
	sta (REG_P),y
	inc REG_P+1
exit2
	rts

isnotemptypleft
	inc REG_P+1
	//pright= p+OFFDIR_RIGHT;
 	// if (isEmpty(pright))
skip11
	ldy #2
	lda (REG_P),y
	bne exit3
	
	// pdownright = p+OFFDIR_DOWNRIGHT;
 	// if (isEmpty(pdownright))
	ldy #82
	lda (REG_P),y
	bne exit3

	// moveCell(p,pright,objectfalling); 
	ldy #0
	lda #0
	sta (REG_P),y
	lda _objectfalling
	ldy #2
	sta (REG_P),y
	lda GAME+GAME_FRAME
	iny
	sta (REG_P),y

exit3
	rts

.)	
	

_updateBoulderOrDiamondFallingB
.(
 
	//	pdown = p + OFFDIR_DOWN;
 	ldy #80
	lda (REG_P),y
	bne isnotemptypdown0

	//	moveCell(p,pdown,p->code);
	ldy #0
	lda (REG_P),y
	ldy #80
	sta (REG_P),y

	lda #0
	ldy #0
	sta (REG_P),y

	lda GAME+GAME_FRAME
	ldy #81
	sta (REG_P),y

	rts


isnotemptypdown0
	//if (isExplodable(pdown))
	ldy #80
	lda (REG_P),y
	tax
	lda _table_mask,x
	and #2
	beq isnotexplodable

 	// explodeCell(pdown);	
 	clc
 	lda REG_P
 	adc #80
	ldy #0 
	sta (sp),y 
	iny 
	lda REG_P+1
	adc #0
	sta (sp),y 

	iny
	jmp _explodeCell 

		 
isnotexplodable	 

	//if (isMagic(pdown))
	 
	ldy #80
	lda (REG_P),y
	cmp #3
	bne notmagic

	ldy #0
	lda (REG_P),y
	cmp #$10
	bne skipbould1
	jsr _soundboulder
skipbould1
	jsr _sounddiamond

	//			doMagic(p);
	// if (game.magic.time > 0) 

	lda MAGIC+MAGIC_TIME
	beq	exitnotime

	// game.magic.active = TRUE;
	lda #1
	sta MAGIC+MAGIC_ACTIVE
 
	//	clearCell(p);
	ldy #0
	lda #0
	sta (REG_P),y

	// p2= p +  OFFDIR_DOWN2;
 	//if (isEmpty(p2))
	//ldy #160	
	 
	ldy #160
	lda (REG_P),y
	bne exitnotime

	//	setCell(p2, objectto);
	// ldy #160
	lda _objectto
	sta (REG_P),y
	iny
	lda GAME+GAME_FRAME
	sta (REG_P),y

	rts

exitnotime
	lda _objectfrom
	ldy #0
	sta (REG_P),y
	lda GAME+GAME_FRAME
	iny
	sta (REG_P),y
	rts
 

notmagic
	// if (isRounded(pdown))
	tay
	lda _table_mask,y
	and #4
	beq exit3
   
    // pleft = p+OFFDIR_LEFT; // p-2
 	// if (isEmpty(pleft))
	ldy #$fe
	dec REG_P+1
	lda (REG_P),y
	bne isnotemptypleft

	inc REG_P+1
	// pdownleft = p+OFFDIR_DOWNLEFT;
 	ldy #78
	// if (isEmpty(pdownleft))
	lda (REG_P),y
	bne exit3

	//	moveCell(p,pleft,p->code);
	ldy #0
	lda (REG_P),y
	ldy #$fe
	dec REG_P+1
	sta (REG_P),y
	inc REG_P+1
	ldy #0
	lda #0
	sta (REG_P),y
	lda GAME+GAME_FRAME
	ldy #$ff
	dec REG_P+1
	sta (REG_P),y
	inc REG_P+1
exit2
	rts

isnotemptypleft
	inc REG_P+1
	//pright= p+OFFDIR_RIGHT;
 	// if (isEmpty(pright))
	ldy #2
	lda (REG_P),y
	bne exit3
	// pdownright = p+OFFDIR_DOWNRIGHT;
	ldy #82
	// if (isEmpty(pdownright))
	lda (REG_P),y
	bne exit3

	// moveCell(p,pright,p->code); 
	ldy #0
	lda (REG_P),y
	ldy #2
	sta (REG_P),y
	ldy #0
	lda #0
	sta (REG_P),y
	lda GAME+GAME_FRAME
	ldy #3
	sta (REG_P),y
	rts

exit3
	//	setCell(p, objectfrom);
	lda _objectfrom
	ldy #0
	sta (REG_P),y
	lda GAME+GAME_FRAME
	iny
	sta (REG_P),y

	lda _objectfrom
	cmp #$10
	bne skipbould
	jmp _soundboulder
skipbould
	jmp _sounddiamond

.)	



//void updateAmoeba() ///////////////////////////////////////////////////////////////////////////////////////////////////////////
_updateAmoebaA
.(
	; struct Cell *p2;
	; unsigned char grow;
	; unsigned char dir;
	 

	//	if (game.amoeba.dead) 
	lda AMOEBA+AMOEBA_DEAD
	beq notdead

	//	setCell(p, game.amoeba.dead);
	ldy #0
	sta (REG_P),y 
	iny
	lda GAME+GAME_FRAME
	sta (REG_P),y
	rts

notdead
	// game.amoeba.size++;
	inc AMOEBA+AMOEBA_SIZE

	//	pup		= p+OFFDIR_UP;
	// if (isEmptyOrDirt(pup))
	ldy #$b0 //-80
	dec REG_P+1
	lda (REG_P),y
	inc REG_P+1
	and #$fe
	 
	// game.amoeba.enclosed = FALSE;
	beq preexit	////////////////////////////////////////////////////////////////////////////////////////

isnotemptyordirt1
	// pdown	= p+OFFDIR_DOWN;
	//if (isEmptyOrDirt(pdown))
	ldy #80  //+80
	lda (REG_P),y
	and #$fe

	// game.amoeba.enclosed = FALSE;
	beq preexit	////////////////////////////////////////////////////////////////////////////////////////

isnotemptyordirt2
 	// pright	= p+OFFDIR_RIGHT;
	// if (isEmptyOrDirt(pright))
	ldy #2
	lda (REG_P),y
	and #$fe
	 	 
	// game.amoeba.enclosed = FALSE;
	beq preexit	////////////////////////////////////////////////////////////////////////////////////////

isnotemptyordirt3

	// pleft	= p+OFFDIR_LEFT;
	//	if (isEmptyOrDirt(pleft)) 
	ldy #$fe
	dec REG_P+1
	lda (REG_P),y
	inc REG_P+1
	and #$fe
	bne isnotemptyordirt4							 
	//					game.amoeba.enclosed = FALSE;
preexit	
	lda #0
	sta AMOEBA+AMOEBA_ENCLOSED
 	sta AMOEBA+AMOEBA_DEAD


isnotemptyordirt4
////////////////////////////////////////////////////////////////////////////////////////
	 
	//if (game.frame >= game.birth) ???????????????????????????

	lda GAME+GAME_FRAME+1
    bne skipz 
	lda GAME+GAME_FRAME
	cmp GAME+GAME_BIRTH
 	bmi exit
skipz	
	// if (game.amoeba.slow)
	lda AMOEBA+AMOEBA_SLOW
	bne notslow
	//	grow = oneChanceOn(31);
	jsr _randomA
	and #31
	jmp skip2
notslow
	//	else
	//	grow = oneChanceOn(3);
	jsr _randomA
	and #3
skip2
	// if (grow)
	bne exit
	
	//			dir  = RANDOM_DIR[randomInt(3)];
	jsr _randomA
	and #3
	tay
	ldx _RANDOM_DIR2,y
	//			p2   = p+OFFDIR[dir];
	clc
	lda _OFFDIR2,x
	adc REG_P
	sta REG_P2
	inx
	lda _OFFDIR2,x
	adc REG_P+1
	sta REG_P2+1

	ldy #0
	//			if (isEmptyOrDirt(p2))
	lda (REG_P2),y
	and #$fe
	bne exit
	//
	//				setCell(p2, OBJECT_AMOEBA);
	lda #$3A
	sta (REG_P2),y
	iny
	lda GAME+GAME_FRAME
	sta (REG_P2),y
	//

exit
	rts

_OFFDIR2
.word $ffb0,$0002,$0050,$fffe
_RANDOM_DIR2
.byt 0,4,6,2

.)
_explodeCell_regP
.(
	
	ldy #0
	lda REG_P 
	sta (sp),y 
	iny 
	lda REG_P+1 
	sta (sp),y 
 
	iny
	jmp _explodeCell 
.)

; void updateFireflyOrButterfly() 	;  	struct Cell *p2,*p3;
_updateFireflyOrButterflyA
.(
; 	pup		= p+OFFDIR_UP;
	lda REG_P
	clc
	adc #<(-80) 
	sta __reg_pup__+1
	lda REG_P+1
	adc #>(-80)
	sta __reg_pup__+2
; 	if (isRockfordOrAmoeba(pup))
__reg_pup__
  	lda $1111
 	cmp #$37
 	bmi notrockfordoramoeba1	
; 		explodeCell(p);
 
 	jmp _explodeCell_regP 
 
notrockfordoramoeba1
 
; 		pdown	= p+OFFDIR_DOWN;	
	clc
	lda REG_P
	adc #80
	sta __reg_pdown__+1
	lda REG_P+1
	adc #0
	sta __reg_pdown__+2

; 		if (isRockfordOrAmoeba(pdown))
__reg_pdown__
	lda $2222
	cmp #$37
	bmi notrockfordoramoeba2
 
; 			explodeCell(p);
 
	jmp _explodeCell_regP 
 
 notrockfordoramoeba2

; 			pleft	= p+OFFDIR_LEFT;
	clc
	lda REG_P
	adc #<(-2)
	sta __reg_pleft__+1
	lda REG_P+1
	adc #>(-2)
	sta __reg_pleft__+2

; 			if (isRockfordOrAmoeba(pleft))
__reg_pleft__
	lda $3333
	cmp #$37
	bmi notrockfordoramoeba3
 	
; 	explodeCell(p);
 
	jmp _explodeCell_regP 

notrockfordoramoeba3

	; 			pright	= p+OFFDIR_RIGHT;
	clc
	lda REG_P
	adc #2
	sta __reg_pright__+1
	lda REG_P+1
	adc #0
	sta __reg_pright__+2

; 			if (isRockfordOrAmoeba(pright))
__reg_pright__
	lda $4444
	cmp #$37
	bmi notrockfordoramoeba4
 
; 	explodeCell(p);
 
	jmp _explodeCell_regP 

notrockfordoramoeba4
; 					p2 = p+OFF_NEWDIR;
	asl _OFF_NEWDIR
	rol _OFF_NEWDIR+1
	clc
	lda _OFF_NEWDIR
	adc REG_P
	sta REG_P2
	lda _OFF_NEWDIR+1
	adc REG_P+1
	sta REG_P2+1
; 					if (isEmpty(p2))
	ldy #0
	lda (REG_P2),y
	bne notemptyp2
; 						moveCell(p,p2,o_Ldir);
	lda _o_Ldir
	sta (REG_P2),y
	lda #0
 
	sta (REG_P),y
	lda GAME+GAME_FRAME
	iny
	sta (REG_P2),y
	rts
;  					else 
notemptyp2
; 						p3 = p+OFF_DIR;
	lda _OFF_DIR
	asl
	clc
	adc REG_P
	sta REG_P3
	lda _OFF_DIR+1
	adc REG_P+1
	sta REG_P3+1
; 						if (isEmpty(p3))
	ldy #0
	lda (REG_P3),y
	bne notempyp3
; 							moveCell(p,p3, p->code);
	lda (REG_P),y
	sta (REG_P3),y
	lda #0
	sta (REG_P),y
	lda GAME+GAME_FRAME
	iny
	sta (REG_P3),y
	rts
; 						else
notempyp3
; 							setCell(p, o_Rdir); 
	lda _o_Rdir
	sta (REG_P),y
	lda GAME+GAME_FRAME
	iny
	sta (REG_P),y

 	rts
.)




_beginFrameA
.(
	inc GAME+GAME_FRAME
	bne skip1
	inc GAME+GAME_FRAME+1
skip1
	jsr _render_frameA

	lda GAME+GAME_FRAME
	sta GAME+GAME_FRAMEFF

	and GAME+GAME_FPSMASK
//	sta GAME+GAME_FRAMESTEP

	lda #0
	sta AMOEBA+AMOEBA_SIZE

	lda #1
	sta AMOEBA+AMOEBA_ENCLOSED

	jsr _randomA 
	and #3
	bne nochanceon3
	lda IDLE+IDLE_BLINK
	eor #1
	sta IDLE+IDLE_BLINK
nochanceon3
	jsr _randomA
	and #15
	bne nochanceon15
	lda IDLE+IDLE_TAP
	eor #1
	sta IDLE+IDLE_TAP
nochanceon15
	rts
.)

/*
AMOEBA			=	__amoeba
AMOEBA_SLOW		=	0
AMOEBA_SIZE		=	1
AMOEBA_ENCLOSED =  	2
AMOEBA_DEAD		=   3
*/

_endFrame
.(
	lda #8	// reset move dir after game update !!!  no extra move ...
	sta MOVING+MOVING_DIR

	lda AMOEBA+AMOEBA_DEAD
	bne skipamo
		lda AMOEBA+AMOEBA_ENCLOSED
		beq skipenclosed
			lda #$14 // diamond
			sta AMOEBA+AMOEBA_DEAD
		
			jsr _disable_sound_amoeba
			jsr _play0000
			jmp skipamo
skipenclosed
			lda AMOEBA+AMOEBA_SIZE
			cmp #201	 // max+1
			bcc skipsize
				lda #$10 // boulder
				sta AMOEBA+AMOEBA_DEAD
				
				jsr _disable_sound_amoeba
				jsr _play0000
				jmp skipamo
skipsize			
				lda AMOEBA+AMOEBA_SLOW
				cmp #$ff
				beq skipamo
					dec AMOEBA+AMOEBA_SLOW
 					
					 
skipamo
	lda MAGIC+MAGIC_ACTIVE
	beq skipmag
		lda MAGIC+MAGIC_TIME
	//	cmp #0
		bne skiptime0
			lda #0
			sta MAGIC+MAGIC_ACTIVE 
			ldy #0
			lda #<_sprite_brickwall
			sta (sp),y
			iny
			lda #>_sprite_brickwall
			sta (sp),y
			iny
			lda #<($b400+45*8)
			sta (sp),y
			iny
			lda #>($b400+45*8)
			sta (sp),y
			iny
			lda #255
			sta (sp),y
			jsr _load_sprite_dataD
			jsr _disable_sound_magic
			jmp skipmag

skiptime0
		dec MAGIC+MAGIC_TIME

skipmag
	

	lda GAME+GAME_FLASH
	bne skipflash1
	lda DIAMONDS+DIAMONDS_ENOUGH
	beq skipflash1
	ldx GAME+GAME_FRAME
	inx
	stx GAME+GAME_FLASH

skipflash1

/*
 a 16-bit unsigned comparison which branches to LABEL2 if NUM1 < NUM2

           LDA NUM1H  ; compare high bytes
           CMP NUM2H
           BCC LABEL2 ; if NUM1H < NUM2H then NUM1 < NUM2
           BNE LABEL1 ; if NUM1H <> NUM2H then NUM1 > NUM2 (so NUM1 >= NUM2)
           LDA NUM1L  ; compare low bytes
           CMP NUM2L
           BCC LABEL2 ; if NUM1L < NUM2L then NUM1 < NUM2
    LABEL1
*/

	lda GAME+GAME_FLASH+1
	cmp GAME+GAME_FRAME+1
	bcc skipflash2		// ! game.flash<game.frame  ==> game.flash>=game.frame
	bne label1
	lda GAME+GAME_FLASH
	cmp GAME+GAME_FRAME
	bcc skipflash2
label1
	jsr _flashA

skipflash2

	lda GAME+GAME_WON
	beq skipwon
	jmp _runOutTimer 

skipwon
  
// game.frame - game.foundRockford > game.fps4 ?
	sec
	lda GAME+GAME_FRAME
	sbc GAME+GAME_FOUNDROCKFORD
	sta tmp
	lda GAME+GAME_FRAME+1
	sbc GAME+GAME_FOUNDROCKFORD+1
	sta tmp+1

	lda #0
	cmp tmp+1 
	bcc loose0

testfps
	lda GAME+GAME_FPS4
	cmp tmp 
	bcs skiploose0

loose0// try again
	lda #0	
	sta _choice		
  	jmp _looseLevel  

skiploose0

	lda GAME+GAME_TIMER
	bne skiptimer

loose1// out of time
	lda #1   
	sta _choice		
  	jmp _looseLevel

skiptimer
	ldy #0
	lda GAME+GAME_FRAME
	sta (sp),y
	iny
	lda GAME+GAME_FRAME+1
	sta (sp),y
	iny
	lda GAME+GAME_FPS
	sta (sp),y
	jsr _fmod
	
	cpx #0
	bne exit

	jsr _autoDecreaseTimer

	lda GAME+GAME_TIMER
	cmp #10
	bne skiptimer10

	lda #9
	sta $bb80+27
	lda #7
	sta $bb80+28
	lda #13
	sta $bb80+22
	lda #1
	sta $bb80+23
	rts

skiptimer10	  
	
	lda GAME+GAME_TIMER
	cmp #10
	bcs exit

	
	jmp _soundrunningoutoftime
 


exit
	rts

.)
 
_animateRockfordA
.(
	lda GAME+GAME_FOUNDROCKFORD
	beq exit

	lda _rockford_cycle
	bne skip000

	lda IDLE+IDLE_BLINK
	asl
	ora IDLE+IDLE_TAP
	tay
	


	lda _conditions,y  // ou <<3
	
	ora _cycle8
 	sta _rockford_cycle

skip000
  
//  lda _rockford_cycle
	asl
	tax
	lda _SP_ROCKFORD,x
	ldy #0
	sta (sp),y
	inx
	lda _SP_ROCKFORD,x

	iny
	sta (sp),y
	
	lda _P_ROCKFORD
	iny
	sta (sp),y
	
	lda _P_ROCKFORD+1
	iny
	sta (sp),y
	
	lda _inversecharset
	bne inversed
	iny
	sta (sp),y
	jmp _load_sprite_dataE

inversed
	lda #255
	iny
	sta (sp),y
	jmp _load_sprite_dataE

exit
	rts

_conditions
.byt 0	//ROCKFORD_FRONT
.byt 8	//ROCKFORD_TAP_1
.byt 16	//ROCKFORD_BLINK_1
.byt 24	//ROCKFORD_BLINKTAP_1

.)

 
_gameUpdateA
.(
CELL 	=	tmp7

JUMP 	=   _jump_+1

	jsr _beginFrameA

	lda GAME+GAME_WON
	bne exit
	lda #<_cells+80
	sta CELL
	sta _p
	lda #>_cells+80
	sta CELL+1
	sta _p+1
  
	lda #1
	sta _Y_
loop1
	ldy #0
	sty _X_
loop2
//	ldy _X_
	iny // frame
 	lda (CELL),y 

 	cmp GAME+GAME_FRAMEFF
 	beq SKIP

// (p = cell+y)



 	dey
 	lda (CELL),y_REG // code
	asl
	tax
  
//switch !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

	lda tableswitch,x
	sta JUMP
	lda tableswitch+1,x
	beq isnull
	sta JUMP+1

	lda _p
	sta REG_P
	lda _p+1
	sta REG_P+1

_jump_
	jmp $AAAA


isnull
	jmp _ping

SKIP
endSwitch
	
	clc
	lda _p
	adc #2
	sta _p
	lda _p+1
	adc #0
	sta _p+1

	inc _X_
	inc _X_

	ldy _X_
	cpy #80
	bne loop2

// new row
	clc
	lda CELL
	adc #80
	sta CELL
	lda CELL+1
	adc #0
	sta CELL+1

	inc _Y_
	ldx _Y_
	cpx #21
	bne loop1
exit
	jmp _endFrame

_X_		
.byt 0

_Y_	
.byt 0

amoeba
 	jsr _updateAmoebaA
	jmp endSwitch

boulder 
	lda #$12
	sta _objectfalling
	jsr _updateBoulderOrDiamondA
	jmp endSwitch

diamond 
	lda #$16
	sta _objectfalling
	jsr _updateBoulderOrDiamondA
	jmp endSwitch

boulderfalling 
	lda #$14
	sta _objectto
	lda #$10
	sta _objectfrom
	jsr _updateBoulderOrDiamondFallingB
	jmp endSwitch

diamondfalling 
 	lda #$10
	sta _objectto
	lda #$14
	sta _objectfrom
	jsr _updateBoulderOrDiamondFallingB
	jmp endSwitch

fireflyleft
 	lda #<(-1)
	sta _OFF_DIR
	lda #>(-1)
	sta _OFF_DIR+1
	lda #<(40)
	sta _OFF_NEWDIR
	lda #>(40)
	sta _OFF_NEWDIR+1
	lda #$0b
	sta _o_Ldir
	lda #$09 
	sta _o_Rdir
	 
	jsr _updateFireflyOrButterflyA
	jmp endSwitch

fireflyup
 	lda #<(-40) 
	sta _OFF_DIR
	lda #>(-40) 
	sta _OFF_DIR+1
	lda #<(-1) 
	sta _OFF_NEWDIR
	lda #>(-1) 
	sta _OFF_NEWDIR+1
	lda #$08
	sta _o_Ldir
	lda #$0a
	sta _o_Rdir
	 
	jsr _updateFireflyOrButterflyA
	jmp endSwitch

fireflyright
 	lda #<(1) 
	sta _OFF_DIR
	lda #>(1) 
	sta _OFF_DIR+1
	lda #<(-40)
	sta _OFF_NEWDIR
	lda #>(-40)
	sta _OFF_NEWDIR+1
	lda #$09
	sta _o_Ldir
	lda #$0b
	sta _o_Rdir
 
	jsr _updateFireflyOrButterflyA
	jmp endSwitch

fireflydown
	lda #<(40) 
	sta _OFF_DIR 
	lda #>(40) 
	sta _OFF_DIR+1 
	lda #<(1) 
	sta _OFF_NEWDIR 
	lda #>(1) 
	sta _OFF_NEWDIR+1 
	lda #$0a
	sta _o_Ldir
	lda #$08
	sta _o_Rdir
	 
	jsr _updateFireflyOrButterflyA
	jmp endSwitch

butterflyleft
	lda #<(-1) 
	sta _OFF_DIR 
	lda #>(-1) 
	sta _OFF_DIR+1 
	lda #<(-40) 
	sta _OFF_NEWDIR 
	lda #>(-40) 
	sta _OFF_NEWDIR+1 
	lda #$31
	sta _o_Ldir
	lda #$33
	sta _o_Rdir
	 
	jsr _updateFireflyOrButterflyA
	jmp endSwitch

butterflyup
	lda #<(-40) 
	sta _OFF_DIR 
	lda #>(-40) 
	sta _OFF_DIR+1 
	lda #<(1) 
	sta _OFF_NEWDIR 
	lda #>(1) 
	sta _OFF_NEWDIR+1 
	lda #$32
	sta _o_Ldir
	lda #$30
	sta _o_Rdir
	 
	jsr _updateFireflyOrButterflyA
	jmp endSwitch

butterflyright
	lda #<(1) 
	sta _OFF_DIR 
	lda #>(1) 
	sta _OFF_DIR+1 
	lda #<(40) 
	sta _OFF_NEWDIR 
	lda #>(40) 
	sta _OFF_NEWDIR+1 
	lda #$33
	sta _o_Ldir
	lda #$31
	sta _o_Rdir
	 
	jsr _updateFireflyOrButterflyA
	jmp endSwitch

butterflydown
	lda #<(40) 
	sta _OFF_DIR 
	lda #>(40) 
	sta _OFF_DIR+1 
	lda #<(-1) 
	sta _OFF_NEWDIR 
	lda #>(-1) 
	sta _OFF_NEWDIR+1 
	lda #$30
	sta _o_Ldir
	lda #$32
	sta _o_Rdir

	jsr _updateFireflyOrButterflyA
	jmp endSwitch

preoutbox
	lda DIAMONDS+DIAMONDS_ENOUGH
	beq notenough
	ldy _X_
	lda #$05
	sta (CELL),y
	iny
	lda GAME+GAME_FRAME
	sta (CELL),y
notenough
	jmp endSwitch

explodetospace0
	lda _explosespace_cycle
	cmp #6
	bne explodetospace1
	lda #1
	sta _explosespace_cycle
 
explodetospace1
explodetospace2
explodetospace3
	ldy _X_
	lda (CELL),y
	tax
	inx
	txa
	sta (CELL),y
	lda GAME+GAME_FRAME
	iny
	sta (CELL),y
	jmp endSwitch

explodetospace4
	ldy _X_
	lda #$00
	sta (CELL),y
	lda GAME+GAME_FRAME
	iny
	sta (CELL),y
	jmp endSwitch

explodetodiamond0
	lda _explosediamond_cycle
	cmp #6
	bne explodetodiamond1
	lda #1
	sta _explosediamond_cycle
  
explodetodiamond1
explodetodiamond2
explodetodiamond3
	ldy _X_
	lda (CELL),y
	tax
	inx
	txa
	sta (CELL),y
	lda GAME+GAME_FRAME
	iny
	sta (CELL),y
	jmp endSwitch

explodetodiamond4
	ldy _X_
	lda #$14
	sta (CELL),y
	lda GAME+GAME_FRAME
	iny
	sta (CELL),y
	jmp endSwitch

prerockford1
 	lda _X_
	lsr
	tax
	lda _rockford_to_xpos,x
	sta _current_xpos
	ldx _Y_
	lda _rockford_to_ypos,x
	sta _current_ypos
	
	clc
	lda GAME+GAME_FRAME
	adc #4
	cmp GAME+GAME_BIRTH
	bmi tooearly
prerockford2
prerockford3
	ldy _X_
	lda (CELL),y
	tax
	inx
	txa
	sta (CELL),y 
	jmp endSwitch

prerockford4
	ldy _X_
	lda #$38
	sta (CELL),y
	lda GAME+GAME_FRAME
	iny
	sta (CELL),y
	jmp endSwitch

rockford 
	lda _X_
	lsr
	tax
	lda _rockford_to_xpos,x
	sta _current_xpos
	ldx _Y_
	lda _rockford_to_ypos,x
	sta _current_ypos
	jsr _updateRockford
tooearly 
	jmp endSwitch


tableswitch
.word endSwitch,endSwitch,endSwitch,endSwitch;	// 0-3
.word preoutbox								 ;	// 4
.word endSwitch,endSwitch,endSwitch;	// 5-7
.word fireflyleft,fireflyup,fireflyright,fireflydown	; // 8-b
.word endSwitch,endSwitch,endSwitch,endSwitch ; // c-f
.word boulder 				;   0x10
.word endSwitch
.word boulderfalling 		;   0x12
.word endSwitch
.word diamond 				;	0x14
.word endSwitch
.word diamondfalling 		;	0x16
.word endSwitch,endSwitch,endSwitch,endSwitch ; 0x17-1A
.word explodetospace0 ; // 1b
.word explodetospace1 ; // 1c
.word explodetospace2 ; // 1d
.word explodetospace3 ; // 1e
.word explodetospace4 ; // 1f
.word explodetodiamond0 ; // 20
.word explodetodiamond1 ; // 21
.word explodetodiamond2 ; // 22
.word explodetodiamond3 ; // 23
.word explodetodiamond4 ; // 24
.word prerockford1 ; // 25
.word prerockford2 ; // 26
.word prerockford3 ; // 27
.word prerockford4 ; // 28
.word endSwitch,endSwitch,endSwitch,endSwitch,endSwitch,endSwitch,endSwitch ; // 29-2f
.word butterflyleft,butterflyup,butterflyright,butterflydown ; // 30-33
.word endSwitch,endSwitch,endSwitch,endSwitch ; 34-37
.word rockford; // 38
.word endSwitch; // 39
.word amoeba; // 3a
.word endSwitch; // 3b
.)

_pushCellRockfordA
.(

	lda _cell_rockford
	sta reg1
	lda _cell_rockford+1
	sta reg1+1

	lda _cell_rockford_p2
	sta reg2
	lda _cell_rockford_p2+1
	sta reg2+1

	clc
	lda reg2
	adc MOVING+MOVING_DIROFFSET
	sta reg3
	iny
	lda reg2+1
	adc MOVING+MOVING_DIROFFSET+1
	sta reg3+1

	clc
	lda reg3
	adc MOVING+MOVING_DIROFFSET
	sta reg3
	lda reg3+1
	adc MOVING+MOVING_DIROFFSET+1
	sta reg3+1


	ldy #0
	lda (reg3),y // empty ?
	bne exit


	jsr _randomA  // 1 chance /4
	and #3
	bne exit

	lda #$10 // boulder
	sta (reg3),y
	lda #$0 // space
	sta (reg2),y
	iny
	lda GAME+GAME_FRAME
	sta (reg3),y
	sta (reg2),y

//	lda _SOUND_ACTIVE
//	beq skipsound
	jsr _soundboulder

skipsound
	lda MOVING+MOVING_GRAB
	bne exit

	ldy #0
	lda #$38 // rockford
	sta (reg2),y
	lda #$0	// space
	sta (reg1),y
	lda GAME+GAME_FRAME
	iny
	sta (reg2),y
	sta (reg1),y
exit
	rts
.)


_handleKeyA
.(
 	lda $209
	cmp #56
	beq nodeadkey

	lda #1
	sta MOVING+MOVING_GRAB

	lda #5
	sta $bfb9 

	bne skip1


nodeadkey

	lda _spacegrab
	sta MOVING+MOVING_GRAB 
	sta $bfb9 
 
skip1
// switch (208)

	ldy $208
  	lda convertswitch2,y
  	asl
  	tay
	
	lda tableswitch2,y
	sta __jtmp__+1
	lda tableswitch2+1,y
	sta __jtmp__+2
__jtmp__
	jmp $1111
 
endSwitch
	rts
//////////////////////////////////

_132	;	8
	lda MOVING+MOVING_GRAB
	eor #1
	sta MOVING+MOVING_GRAB
	sta _spacegrab
	sta $bfb9
	rts

_180
	lda #4	//down
	sta MOVING+MOVING_DIR
	lda #<(40)
	sta MOVING+MOVING_DIROFFSET
	lda #>(40)
	sta MOVING+MOVING_DIROFFSET+1

	clc
	lda _cycle8
	adc #40
	sta _rockford_cycle
	rts

_156
	lda #0	//up
	sta MOVING+MOVING_DIR
	lda #<(-40)
	sta MOVING+MOVING_DIROFFSET
	lda #>(-40)
	sta MOVING+MOVING_DIROFFSET+1

	clc
	lda _cycle8
	adc #32
	sta _rockford_cycle
	rts

_172
	lda #6	//left
	sta MOVING+MOVING_DIR
	lda #<(-1)
	sta MOVING+MOVING_DIROFFSET
	lda #>(-1)
	sta MOVING+MOVING_DIROFFSET+1

	clc
	lda _cycle8
	adc #32
	sta _rockford_cycle
	rts

_188
	lda #2	//right
	sta MOVING+MOVING_DIR
	lda #<(1)
	sta MOVING+MOVING_DIROFFSET
	lda #>(1)
	sta MOVING+MOVING_DIROFFSET+1

	clc
	lda _cycle8
	adc #40
	sta _rockford_cycle
	rts

gameover
	jsr _removeIrq
	lda #0
	ldy #0
	sta (sp),y
	jmp _looseLevel


_169 // ESC

	//resetgame
	lda GAME+GAME_INDEX
	ldy #0
	sta (sp),y
	dec _lifes
	beq gameover

	jsr _removeIrq
	jmp _resetGame

 	 

_175 // "return"
	jsr _removeIrq
	jmp _nextGame
 
_173 //"ESC"
	jsr _removeIrq
	jmp _prevGame
	 

_56  //	""
	//stop
	lda #8	//none
	sta MOVING+MOVING_DIR
	lda #<(0)
	sta MOVING+MOVING_DIROFFSET
	lda #>(0)
	sta MOVING+MOVING_DIROFFSET+1

	lda #0
	sta _rockford_cycle
	rts

_141  //	"I"
	lda _inversecharset
	eor #1
	sta _inversecharset
	jsr _flashA 
	jmp _56   // fix bug if pressed after a move

_186 //	"C"
	jsr _choose_nextcolor
	jmp _56   // fix bug if pressed after a move 

_137 	// "T"
	jsr _removeIrq

	lda #1 
	sta _render
	ldy #0
	lda #" "
	sta (sp),y
 	jsr _clrscr
	jsr _init_stats
	lda #<$b400+"A"*8
	ldy #0
	sta (sp),y
	lda #>$b400+"A"*8
	iny
	sta (sp),y
	lda #<_data_previewcharset
	iny
	sta (sp),y
	lda #>_data_previewcharset
	iny
	sta (sp),y
	lda #<(512)
	iny 
	sta (sp),y
	lda #>(512)
	iny
	sta (sp),y
	jsr _memcpy
	jmp _56   // fix bug if pressed after a move 

_150	// "G"
	jsr _removeIrq

	lda #0
	sta _render
	ldy #0
	lda #" "
	sta (sp),y
 	jsr _clrscr
	jsr _init_render
	jsr _choose_samecolor
	jsr _init_stats
	jmp _56   // fix bug if pressed after a move
	 
_142  // "H"
	jsr _help
	jmp _init_stats
	jmp _56   // fix bug if pressed after a move

_182	// "S"
	lda _SOUND_ACTIVE
	eor #1
	sta _SOUND_ACTIVE
   	
   	beq exit182
   	lda _CHANNELS
   	ora #4
   	sta _CHANNELS	 
   	lda #";"
 	sta $bb80+39
	jmp _56   // fix bug if pressed after a move
exit182
	lda _CHANNELS
	and #3
	sta _CHANNELS
	lda #";"+128
 	sta $bb80+39
	jsr _disable_sound_amoeba
	jmp _56   // fix bug if pressed after a move

_130	// "M"
	lda _MUSIC_ACTIVE
	eor #1
	sta _MUSIC_ACTIVE
 
 	beq exit130
 	lda _CHANNELS
 	ora #3
 	sta _CHANNELS
 	lda #"/"
 	sta $bb80+38
 	jmp _56   // fix bug if pressed after a move
exit130
	lda _CHANNELS
	and #4
	sta _CHANNELS
	lda #"/"+128
	sta $bb80+38
	jmp _56   // fix bug if pressed after a move 

_157 // "P"
	jmp _menu_parameters	
	 

// kind of enum
tableswitch2
.word endSwitch
.word _56
.word _132
.word _137
.word _141
.word _150
.word _156
.word _169
.word _172
.word _173
.word _175
.word _180
.word _182
.word _186
.word _188
.word _130
.word _157 // P = 16
.word _142 // H = 17

convertswitch2
.dsb 56-0,0 		//0-55
.byt 1				//56
.dsb 130-57,0 		//57-129
.byt 15				//130
.byt 0				//131
.byt 2				//132
.dsb 137-133,0 		//133-136
.byt 3  			//137
.dsb 140-138,0 		//138-139
.byt 8  			//140= "<"
.byt 4  			//141
.byt 17				//142
.dsb 148-143,0		//143-147
.byt 14				//148 = ">"
.byt 0  			//149
.byt 5  			//150
.dsb 156-151,0		//151-155
.byt 6  			//156 = haut
.byt 16				//157 = P
.dsb 169-158,0		//158-168
.byt 7 				//169 = escape
.dsb 172-170,0		//170-171
.byt 8 				//172 = gauche
.byt 9 				//173 = del
.byt 11				//174 = "A" = bas
.byt 10 			//175 = return
.byt 0				//176
.byt 6  			//177 = "Q" = haut
.dsb 180-178,0 		//178-179
.byt 11 			//180 = bas
.byt 0				//181
.byt 12 			//182 = "S"
.dsb 186-183,0		//183-185
.byt 13 			//186 = "C"
.byt 0				//187
.byt 14 			//188 = droite
.byt 0,0,0			//189-191
.)


_randomA
.(
	//ldx index_random
	//lda #0
	ldx randtable//,x
	txa
	inc _randomA+1//index_random
	rts
.)


_searchrockfordA
.(
	lda #<_cells+80
	sta tmp
	lda #>_cells+80
	sta tmp+1

	ldx #1

loop1
	ldy #78

loop2
	lda (tmp),y
	cmp #$25
	beq exit
	dey
	dey
	bne loop2

	clc
	lda tmp
	adc #80
	sta tmp
	lda tmp+1
	adc #0
	sta tmp+1

	inx
	cpx #22
	bne loop1


exit
	tya
	lsr
	tay
	lda _rockford_to_xpos,y
	sta _current_xpos
	lda _rockford_to_ypos,x
	sta _current_ypos
		
	rts
.)

; void collectDiamond() 
; {
; 	_diamonds.collected++;
; 	render_diamondsCollected();
; 	soundpickeddiamond();
; 	//increaseScore(_diamonds.currentvalue);
;	score+n;
;	render_score

; 	if (!_diamonds.enough)
; 		if (_diamonds.collected>=_diamonds.needed)
; 		{
; 			_diamonds.enough=TRUE;
; 			_diamonds.currentvalue=_diamonds.extra;
; 			render_diamondsCurrentValue();
; 			poke(0xbb80+15,2);
; 			poke(0xbb80+7,6);
; 			poke(0xbb80+14,13);
; 			poke(0xbb80+20,9);
; 		}
; }

_collectDiamond
.(
	inc DIAMONDS+DIAMONDS_COLLECTED
	jsr _render_diamondsCollectedA
	jsr _soundPickedDiamondA
	
	clc
	lda _score
	adc DIAMONDS+DIAMONDS_CURRENTVALUE
	sta _score
	lda _score+1
	adc #0
	sta _score+1
	jsr _render_scoreA

	lda DIAMONDS+DIAMONDS_ENOUGH
	bne exit

	lda DIAMONDS+DIAMONDS_COLLECTED
	cmp DIAMONDS+DIAMONDS_NEEDED
	bmi exit

	lda #1
	sta DIAMONDS+DIAMONDS_ENOUGH
	lda DIAMONDS+DIAMONDS_EXTRA
	sta DIAMONDS+DIAMONDS_CURRENTVALUE
	jsr _render_diamondsCurrentValueA
	lda #2
	sta $bb80+15
	lda #6
	sta $bb80+7
	lda #13
	sta $bb80+14
	lda #9
	sta $bb80+20


exit
	rts
.)

_disablemusic
.(
	lda _MUSIC_ACTIVE
	beq exit

	lda #0
	sta _MUSIC_ACTIVE
	jsr _removeIrq
	lda #"/"+128
	sta $bb80+38
exit
	rts
.)


// N/D =Q
// N%D =R
_fmod // 16 % 8 = 8
  
.(
	 
QUOTIENT = tmp1
REMAINDER = tmp2
NUMERATOR = tmp3
DIVISOR = tmp4
 
	ldy #0
	sty REMAINDER
	sty QUOTIENT
	sty QUOTIENT+1
	lda (sp),y
	sta NUMERATOR
	ldy #2
	lda (sp),y
	beq DivisionByZeroError
	sta DIVISOR
	ldy #8
loop
	asl NUMERATOR
	rol REMAINDER

	// !(DIVISOR < REMAINDER)......... ou R>=D => R-D >= 0 => !(R-D<0) 
	lda DIVISOR
	clc
	sbc REMAINDER
	bcs skip  ; D>R

	lda REMAINDER
	sec
	sbc DIVISOR
	sta REMAINDER
	lda QUOTIENT
	ora table1,y
	sta QUOTIENT 
	lda QUOTIENT+1
	ora table2,y
	sta QUOTIENT+1
skip
	dey
	bne loop
	lda #0
	ldx REMAINDER
exit 
	rts

DivisionByZeroError
	rts 
 
table1
.byt 0,1,2,4,8,16,32,64,128,0,1,2,4,8,16,32,64,128
table2
.byt 0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1
.)



_animatesA
.(
		
			lda _inversecharset
			bne skipinv
			lda #255
			sta INVERSECS
			lda #0
			sta NORMALCS
			jmp skip0
skipinv
			lda #0
			sta INVERSECS
			lda #255
			sta NORMALCS
skip0
			lda _cycle8
			asl
			tax
			lda _SP_BUTTERFLY,x
			ldy #0
			sta (sp),y
			iny
			lda _SP_BUTTERFLY+1,x
			sta (sp),y
			iny
			lda #<($b400+81*8)
			sta (sp),y
			iny
			lda #>($b400+81*8)
			sta (sp),y
			iny
			lda NORMALCS
			sta (sp),y
			jsr _load_sprite_dataD

			lda _cycle8
			asl
			tax
			lda _SP_FIREFLY,x
			ldy #0
			sta (sp),y
			iny
			lda _SP_FIREFLY+1,x
			sta (sp),y
			iny
			lda #<($b400+63*8)
			sta (sp),y
			iny
			lda #>($b400+63*8)
			sta (sp),y
			iny
			lda INVERSECS
			sta (sp),y
			jsr _load_sprite_dataD


			lda _cycle8
			asl
			tax
			lda _SP_DIAMOND,x
			ldy #0
			sta (sp),y
			iny
			lda _SP_DIAMOND+1,x
			sta (sp),y
			iny
			lda #<($b400+75*8)
			sta (sp),y
			iny
			lda #>($b400+75*8)
			sta (sp),y
			iny
			lda NORMALCS
			sta (sp),y
			jsr _load_sprite_dataD

			lda MAGIC+MAGIC_ACTIVE
			beq skipmagic

			lda _cycle4
			asl
			tax
			lda _SP_MAGIC,x
			ldy #0
			sta (sp),y
			iny
			lda _SP_MAGIC+1,x
			sta (sp),y
			iny
			lda #<($b400+45*8)
			sta (sp),y
			iny
			lda #>($b400+45*8)
			sta (sp),y
			iny
			lda INVERSECS
			sta (sp),y
			jsr _load_sprite_dataD


skipmagic
			
			lda AMOEBA+AMOEBA_SIZE
			beq skipamo

			lda _cycle8
			asl
			tax
			lda _SP_AMOEBA,x
			ldy #0
			sta (sp),y
			iny
			lda _SP_AMOEBA+1,x
			sta (sp),y
			iny
			lda #<($b400+93*8)
			sta (sp),y
			iny
			lda #>($b400+93*8)
			sta (sp),y
			iny
			lda INVERSECS
			sta (sp),y
			jsr _load_sprite_dataD

skipamo

			lda GAME+GAME_FOUNDROCKFORD
			beq skipfound

			lda DIAMONDS+DIAMONDS_ENOUGH
			bne skipfound
skipenough
			lda _steelok
			bne rock
			inc _steelok
			lda #<_sprite_steelwall
			ldy #0
			sta (sp),y
			iny
			lda #>_sprite_steelwall
			sta (sp),y
			iny
			lda #<($b400+51*8)
			sta (sp),y
			iny
			lda #>($b400+51*8)
			sta (sp),y
			iny
			lda INVERSECS
			sta (sp),y
			jsr _load_sprite_dataD
			jmp rock
			
skipfound
			jsr _animateOutbox	// rockford not found = animate preoout box
rock
 			jsr _animateRockfordA

			lda _explosespace_cycle
			cmp #6
			beq skipspace
 			 
			asl
			tax
			lda _SP_EXPLOSE_TO_SPACE,x
			ldy #0
			sta (sp),y
			iny
			lda _SP_EXPLOSE_TO_SPACE+1,x
			sta (sp),y
			iny
			lda #<($b400+99*8)
			sta (sp),y
			iny
			lda #>($b400+99*8)
			sta (sp),y
			iny
			lda INVERSECS
			sta (sp),y
			jsr _load_sprite_dataD
			inc _explosespace_cycle
		 

skipspace
			

			lda _explosediamond_cycle
			cmp #6
			beq skipdiamond
 			 
			asl
			tax
			lda _SP_EXPLOSE_TO_DIAMOND,x
			ldy #0
			sta (sp),y
			iny
			lda _SP_EXPLOSE_TO_DIAMOND+1,x
			sta (sp),y
			iny
			lda #<($b400+105*8)
			sta (sp),y
			iny
			lda #>($b400+105*8)
			sta (sp),y
			iny
			lda INVERSECS
			sta (sp),y
			jsr _load_sprite_dataD
			inc _explosediamond_cycle
			 

skipdiamond
			
			inc _cycle8
			lda _cycle8
			and #7
			sta _cycle8
			
			and #3
			sta _cycle4

			and #1
			sta _cycle2



			rts
NORMALCS
.byt 0
INVERSECS
.byt 255

.)
			

_helpC
.(
			jsr _randomA 
			and #3
			bne nochanceon3
			lda IDLE+IDLE_BLINK
			eor #1
			sta IDLE+IDLE_BLINK
nochanceon3
			jsr _randomA
			and #15
			bne nochanceon15
			lda IDLE+IDLE_TAP
			eor #1
			sta IDLE+IDLE_TAP
nochanceon15
			rts
.)



_renderGame
.(	
	lda _render
	bne rendertext
	jsr _animatesA
	jmp _drawMapDirectA

rendertext
	
	lda _cycle2
	bne skip

	ldy #0
	lda #<$b400+("A"+$14)*8
	sta (sp),y
	iny
	lda #>$b400+("A"+$14)*8
	sta (sp),y
	lda #<_cs_diamond2
	iny
	sta (sp),y
	lda #>_cs_diamond2
	iny
	sta (sp),y
	lda #<(8)
	iny 
	sta (sp),y
	lda #>(8)
	iny
	sta (sp),y
	ldy #8
	jsr _memcpy

	ldy #0
	lda #<$b400+("A"+$16)*8
	sta (sp),y
	iny
	lda #>$b400+("A"+$16)*8
	sta (sp),y
	lda #<_cs_diamondfalling2
	iny
	sta (sp),y
	lda #>_cs_diamondfalling2
	iny
	sta (sp),y
	lda #<(8)
	iny 
	sta (sp),y
	lda #>(8)
	iny
	sta (sp),y
	ldy #8
	jsr _memcpy
	jmp ok

skip

	ldy #0
	lda #<$b400+("A"+$14)*8
	sta (sp),y
	iny
	lda #>$b400+("A"+$14)*8
	sta (sp),y
	lda #<_cs_diamond
	iny
	sta (sp),y
	lda #>_cs_diamond
	iny
	sta (sp),y
	lda #<(8)
	iny 
	sta (sp),y
	lda #>(8)
	iny
	sta (sp),y
	jsr _memcpy

	ldy #0
	lda #<$b400+("A"+$16)*8
	sta (sp),y
	iny
	lda #>$b400+("A"+$16)*8
	sta (sp),y
	lda #<_cs_diamondfalling
	iny
	sta (sp),y
	lda #>_cs_diamondfalling
	iny
	sta (sp),y
	lda #<(8)
	iny 
	sta (sp),y
	lda #>(8)
	iny
	sta (sp),y
	jsr _memcpy

ok
	inc _cycle2
	lda _cycle2
	and #1
	sta _cycle2

	jmp _render_level_asciiA
	 
.)