VDU		=	$f77c
STOUT   =   $f865


 

/*

_VSync 
.(
 	lda $300
_xvsync_wait
	lda $30D
	and #%00010000 // test du bit cb1 du registre d'indicateur d'IRQ
	beq _xvsync_wait
	rts
.)  
*/

_aWait
.(
	ldy #0
	lda (sp),y
	tay
loop
	ldx #0
lx
	nop
	nop
	
	dex
	bne lx
	dey
	bne loop
exit
	rts
.)

_aWaitKey
.(
	ldy #0
	lda (sp),y
	tay
loop
	ldx #0
lx
	nop
	nop
	nop
	nop
	nop
	nop
	lda $209
	cmp #56
	bne exit
	lda $208
	cmp #56
	bne exit
	dex
	bne lx
	dey
	bne loop
exit
	rts
.)
_FLUSHIN
.(
	ldx $208
	cpx #56
	bne _FLUSHIN
	rts
.)
 
_GETCHAR
.(
	jsr _FLUSHIN
loop
	ldx $208
	cpx #56
	beq loop
	rts
.)

_clrscr
.(
	ldy #0
	lda (sp),y
	sta loopx+3

	lda #$80
	sta loopy+1
	lda #$bb
	sta loopy+2

<<<<<<< HEAD
	ldx #14 ; lines
loopx
	ldy #79 ; columns 
=======
	ldx #28 ; lines
loopx
	ldy #39 ; columns 
>>>>>>> 50c3183eb8423bb279bb49bde3aece84a875250d
	lda #" " ; char
loopy
	sta $bb80,y
	dey
	bpl loopy

	clc
	lda loopy+1
<<<<<<< HEAD
	adc #80
=======
	adc #40
>>>>>>> 50c3183eb8423bb279bb49bde3aece84a875250d
	sta loopy+1
	bcc skip
	inc loopy+2
skip
	dex
	bne loopx

	rts
.)

_render_boulderdash_title
.(
SOURCE		=	__source__+1
DESTINATION	=	__destination__+1

	lda #<_STRING_BOULDERDASH_TITLE
	sta SOURCE
	lda #>_STRING_BOULDERDASH_TITLE
	sta SOURCE+1

	lda #<$bb80
	sta DESTINATION
	lda #>$bb80
	sta DESTINATION+1

	ldy #0
	lda #" "
	sta (sp),y
	jsr _clrscr

	ldx #28
loopx
	ldy #00
loopy
__source__
	lda $5555,y
	//beq skip_incsource
 	cmp #10	//   \n  ?
	beq skip_incsource
	cmp #" "
	beq skip_space
  	cmp #"*"
  	bne skip11p
 
skip11p
skip_print
__destination__
	sta $DDDD,y
skip_space
	iny
	cpy #40
	bne loopy
	beq skip555

skip_incsource
	iny
skip555
	clc
	tya
	adc SOURCE
	sta SOURCE
	lda SOURCE+1
	adc #0
	sta SOURCE+1

skip_nextrow
	clc
	 
	lda DESTINATION
	adc #40
	
	sta DESTINATION
	lda DESTINATION+1
	adc #0
	sta DESTINATION+1

	dex
	bne loopx

	rts
.)
 


 
_render_level_asciiA
.(
SAVEX	= reg2

CELL0	= __cell__+1
DEST0	= __dest__+1

	lda #<_cells
	sta CELL0
	lda #>_cells
	sta CELL0+1

	lda #<$bb80+80
	sta DEST0
	lda #>$bb80+80
	sta DEST0+1

	ldx #11
	stx SAVEX
	
loopx
	ldy #79
loopy
	ldx tablemul2,y
__cell__
	lda $CCCC,x
    clc
	adc #"A"
__dest__
 	sta $DDDD,y
	dey
	bpl loopy

//	clc
	lda CELL0
	adc #160
	sta CELL0
	lda CELL0+1
	adc #0
	sta CELL0+1
	
//	clc
	lda DEST0
	adc #80
	sta DEST0
	lda DEST0+1
	adc #0
	sta DEST0+1

skp2

	dec SAVEX
	bne loopx


	rts
.)
// eor 255 on charset !

_flashA
.( 
	ldy #0 
loopy
	lda $b400+8*32,y
	eor 255
	sta $b400+8*32,y
	dey
	bne loopy

loop2
	lda $b400+8*32+256,y
	eor 255
	sta $b400+8*32+256,y

	dey
	bne loop2

loop3
	lda $b400+8*32+512,y
	eor 255
	sta $b400+8*32+512,y
	dey
	bne loop3
 
	rts

.)

_inverseVideoA
.(

	lda _render
	bne _inverseVideoB

	lda #<$bb80
	sta loopy+1
	sta loopy+6
	lda #>$bb80
	sta loopy+2
	sta loopy+7

	ldx #28
loopx
	ldy #0
loopy
	lda $bb80,y
	eor #128
	sta $bb80,y

  	iny
	cpy #40
	bne loopy

	lda loopy+1
	adc #40
	sta loopy+1
	sta loopy+6

	lda loopy+2
	adc #0
	sta loopy+2
	sta loopy+7

	dex
	bne loopx
	 
	rts
.)

_inverseVideoB
.(
	jsr _zap
	lda #<$bb80+80
	sta loopy+1
	sta loopy+6
	lda #>$bb80+80
	sta loopy+2
	sta loopy+7

	ldx #22
loopx
	ldy #0
loopy
	lda $bb80,y
	eor #128
	sta $bb80,y

  	iny
	cpy #40
	bne loopy

	lda loopy+1
	adc #40
	sta loopy+1
	sta loopy+6

	lda loopy+2
	adc #0
	sta loopy+2
	sta loopy+7

	dex
	bne loopx
	 
	rts
.)


// sprite layout 3*2
// params : src,dst,eor msk
 
// table iterdest
_iterdest
.byt 0,8,16
.byt 1,9,17
.byt 2,10,18
.byt 3,11,19
.byt 4,12,20
.byt 5,13,21
.byt 6,14,22
.byt 7,15,23
.byt 24,32,40
.byt 25,33,41
.byt 26,34,42
.byt 27,35,43
.byt 28,36,44
.byt 29,37,45
.byt 30,38,46
.byt 31,39,47


_load_sprite_dataD
.(
rtmp = $80

SPRITE		= rtmp
DEST_CH		= rtmp+2
MASK_EOR	= rtmp+4 

 	ldy #5
loady
	lda (sp),y
	sta SPRITE,y
	dey
	 
	bpl loady
 
	ldy #47
loop2
	tya
	pha
	tax

	lda (SPRITE),y
	eor MASK_EOR
	
	ldy _iterdest,x
 
	sta (DEST_CH),y
 
	pla
	tay
	dey
	bpl loop2

 
	rts
.)

_load_sprite_dataE
.(
rtmp = $30

SPRITE		= rtmp
DEST_CH		= rtmp+2
MASK_EOR	= rtmp+4 

 	ldy #5
loady
	lda (sp),y
	sta SPRITE,y
	dey
	 
	bpl loady
 
	ldy #47
loop2
	tya
	pha
	tax

	lda (SPRITE),y
	eor MASK_EOR
	
	ldy _iterdest,x
 
	sta (DEST_CH),y
 
	pla
	tay
	dey
	bpl loop2

 
	rts
.)

_bdrandomize
.(
 
 
	; temp1 = (xseeds[0] & 0x01) * 0x80
	lda #0
	sta tmp1+1
	lda _xseeds
	and #1
	lsr
	ror
	sta tmp1

	; temp2 = (xseeds[1] >> 1) & 0x7f
	lda _xseeds+1
	lsr
	and #$7f
	sta tmp2

	; res   = xseeds[1] +  (xseeds[1] & 0x01) *0x80 ;
	lda _xseeds+1
	and #1
	// 0/1 * 128
	lsr
	ror
	//clc
	adc _xseeds+1
	sta reg1
	lda #0
	adc #0
	sta reg1+1

	// carry = res>0xff
	lsr

	lda #0
	sta reg1+1
	lda reg1
	adc #$13
	sta reg1
	lda reg1+1
	adc #0
	sta reg1+1
	
	//carry ?
	lsr

	;	xseeds[1] = res & 0xFF;
	lda reg1
	sta _xseeds+1

	;	res   = xseeds[0] + carry + temp1;
	lda _xseeds
	adc tmp1
	sta reg1
	lda reg1+1
	adc #0
	sta reg1+1

	// carry ?
	lsr 
	lda #0
	sta reg1+1
	lda reg1
	adc tmp2
	sta reg1
	
	;xseeds[0] = res & 0xFF;
	sta _xseeds

	rts





.)



_bdrandom1
.(
 
			LDA _xseeds+0
            ROR
            ROR
            AND #$80
            STA $c1
        
            LDA _xseeds+1
            ROR
            AND #$7F
            STA $c2
     
			LDA _xseeds+1
            ROR
            ROR
            AND #$80
            CLC
            ADC _xseeds+1
     
			ADC #$13
			STA _xseeds+1
           
		    LDA _xseeds+0
            ADC $c1
    
			ADC $c2
            STA _xseeds+0
            RTS
        
.)
 
_patchDrawMapDirectA
.(
	ldy #0
	lda (sp),y
	sta _drawMapDirectA+$33
	iny
	lda (sp),y
	sta _drawMapDirectA+$37
	rts
.)

_drawMapDirectA
.(
	
PMAP = __pmap__+1
DEST = reg7 
 
__X  = reg5
__Y  = reg6
 
	// unsigned char *pmap= (unsigned char*)map + current_xpos + current_ypos*40;
	lda #<_cells
	sta PMAP
	lda #>_cells
	sta PMAP+1

	lda _current_xpos
	asl
	clc
	adc PMAP
	sta PMAP
	lda PMAP+1
	adc #0
	sta PMAP+1

//	clc
	ldy _current_ypos
	lda table_mult_80_lo,y
	adc PMAP
	sta PMAP
	lda table_mult_80_hi,y
	adc PMAP+1
	sta PMAP+1

	// 	dest = (unsigned int)0xbb81+40;
 
	lda #<$bb81+40
	sta DEST
	lda #>$bb81+40
	sta DEST+1
  
//	for (j=0;j<13;j++,cell+=27) ****************************
			
	ldx #0		// x always equal to 0 !!!!!!!!!!!!!!!!!!!
	stx __Y
loop1
//		for (i=0;i<13;i++,cell++) 
		ldx #0
		stx __X
loop2
__pmap__
					ldx $ABCD
			 		lda _table,x	////			c= cell->code;
 					clc

					ldy #0
					sta (DEST),y	////// a=c7

					iny
	 				adc #1
					sta (DEST),y

 					iny
					adc #1
 					sta (DEST),y
					
					ldy #40
 					adc #1
					sta (DEST),y

					iny
					adc #1
					sta (DEST),y

					iny
 					adc #1
					sta (DEST),y
 

					// dest+=3;
		 	//		clc
					lda DEST
					adc #3
					sta DEST
					lda DEST+1
					adc #0
					sta DEST+1
				
					 
skip15
					tay //sta __C7 == y 

		 //			clc
					lda PMAP
					adc #2
					sta PMAP
					lda PMAP+1
					adc #0
					sta PMAP+1
 
 
skip3
 
// end for ********************************************************************************

	// x_pos++
	inc __X
	// condition for *************************************************************************
	// x_pos<13  ???
	lda __X
	cmp #13
	bne loop2
	 
			clc
			lda DEST
			adc #41
			sta DEST
			lda DEST+1
			adc #0
			sta DEST+1// pmap+=27;

	//	clc
		lda PMAP
		adc #54
		sta PMAP
		lda PMAP+1
		adc #0
		sta PMAP+1
	 
skip13	



skip9
	 
	 
//  end for ******************************************************************************************
//  y_pos++
	inc __Y
	 
	 
//  condition for ************************************************************************************
//  y_pos<13

	lda __Y
	cmp #13
	beq exit
	jmp loop1

	 
	// }
exit

	rts
 

.)
_index_chain
.byt 0

_addchain
.(
	sei
	
	ldx _index_chain
	lda #$20		   // JSR
	sta _dochain,x
	inx
	ldy #0
	lda (sp),y 			// lo
	sta _dochain,x
	inx
	iny
	lda (sp),y 			// hi
	sta _dochain,x
	inx
	lda #$60
	sta _dochain,x 		// RTS
	lda _index_chain
	clc
	adc #3
	sta _index_chain

	cli
	rts



.)
_dochain
.(
	jsr $AAAA
	jsr $BBBB
	jsr $CCCC
	jsr $DDDD
	jsr $EEEE
	jsr $FFFF
exit
	rts
.)


_addIrq
.(
 
        sei

	    lda #<_handler
		sta $24b

		lda #>_handler
		sta $24c
 
		lda #$4c // jmp
		sta $24a

		cli 

        rts 


_handler 
	
	php
	pha
	lda busy 
	bne isbusy
	lda #1
	sta busy
	txa
	pha
	tya
	pha
	
_handler_patch
	jsr _dochain
	
	pla
	tay
	pla
	tax
	lda #0
	sta busy
isbusy
	pla
	plp

	rti


busy
.byt 00
.)

_removeIrq
.(
	sei

	lda #0
	sta _AMOEBA_SOUND_ENABLED
	sta _MAGIC_SOUND_ENABLED

	lda #$40		// RTI
	sta $24a

	lda #0
	sta _index_chain

	cli
	jmp _play0000
	 
.)





_cyclingcolors
.(
		 
		
	inc counter
	bne nochange

	inc counter2
	lda counter2
	and #1
	asl
	tax
	lda tablecycle,x
	sta __patch__+1
	lda tablecycle+1,x
	sta __patch__+2

nochange
	
__patch__
	jmp _cyclingcolors1 ; or 2


counter
.byt 0
counter2
.byt 0
tablecycle
.word _cyclingcolors1
.word _cyclingcolors2

.) 

 

 
 

_cyclingcolors1
.(
	lda #<($a002+(17*8-1)*40 )
	sta __patch__+1
	lda #>($a002+(17*8-1)*40 )
	sta __patch__+2

	ldx #17*8 
loop
	sec
	txa
	sbc CYCLE_INDEX
	and #127
	tay

	lda _raster,y
__patch__
	sta $A002

//	lda a002mul40_lo,x
	sec
	lda __patch__+1
	sbc #40
	sta __patch__+1 
//	lda a002mul40_hi,x
	lda __patch__+2
	sbc #0
	sta __patch__+2

skip
	dex
//	cpx #7
	bne loop

	dec CYCLE_INDEX

 
exit	
	 
	rts
.)  

_cyclingcolors2
.(
	lda #<($a002+(17*8-1)*40 )
	sta __patch__+1
	lda #>($a002+(17*8-1)*40 )
	sta __patch__+2

	ldx #17*8 
loop
	sec
	txa
	sbc CYCLE_INDEX
	and #127
	tay

	lda _raster,y
__patch__
	sta $A002
	 

//	lda a002mul40_lo,x
	sec
	lda __patch__+1
	sbc #40
	sta __patch__+1 
//	lda a002mul40_hi,x
	lda __patch__+2
	sbc #0
	sta __patch__+2
	
	dex
	//cpx #7
	bne loop

	inc CYCLE_INDEX

 	
exit	
	 

	rts
.)  
 
CYCLE_INDEX
.byt 0
_raster
.byt 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
.byt 1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3
.byt 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
.byt 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
.byt 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
.byt 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4 
.byt 5,4,5,4,5,4,5,4,5,4,5,4,5,4,5,4
.byt 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
.byt 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
.byt 1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3
.byt 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
.byt 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
.byt 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
.byt 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4 
.byt 5,4,5,4,5,4,5,4,5,4,5,4,5,4,5,4
.byt 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5


_tablemul40_lo
.byt $00,$28,$50,$78,$a0,$c8,$f0,$18,$40,$68,$90,$b8,$e0,$08,$30,$58,$80,$a8,$d0,$f8,$20,$48,$70,$98,$c0,$e8,$10,$38;
_tablemul40_hi
.byt $00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$03,$04,$04;



_uncoverA
.(
	
	lda #0
	sta counter
loop
 
	lda counter
	and #7
	bne skip
 
	jsr _sounduncover

//???	lda covidx
	inc covidx
	lda covidx
	and #7
	asl
	asl
	asl

//	clc
	adc #<_cover0
	sta tmp
	lda #>_cover0
	adc #0
	sta tmp+1
	ldy #7
loop1
	lda (tmp),y
	eor #255
	sta $b400+8*"z",y
	dey
	bpl loop1


	lda counter
	and #23
	bne skip
	jsr _animatesA


skip
 
	ldy #26

loop2
  
	clc
	lda _tablemul40_lo,y
	adc #<$bb80+1
	sta tmp+2
	lda _tablemul40_hi,y
	adc #>$bb80+1
	sta tmp+3

	clc
	lda _tablemul40_lo,y
	adc #<_unbuff+1 
	sta tmp+4
	lda _tablemul40_hi,y
	adc #>_unbuff+1 
	sta tmp+5

	sty tmp+6

	jsr _randomA
    and #127
    tax
 	ldy mod39,x

	lda (tmp+4),y
	sta (tmp+2),y

	ldy #16
wait
	dey
	bne wait

	lda $208
	cmp #56
	bne exit

	ldy tmp+6
	dey
	bne loop2


	dec counter
	bne loop
exit
	rts


counter
.byt 0


covidx
.byt 0

.)


_display_hof_frame
.(	
	lda #<$bb80
	sta tmp
	lda #>$bb80
	sta tmp+1

	ldy #0
loop1
	lda string1,y
	beq skip1
	sta $bb80+0*40+4 ,y
	lda #"*"
	sta $bb80+16*40+4,y
	iny
	bne loop1
skip1
	lda #"+" 
	sta $bb80+16*40+3,y

	ldx #15
loop2
	ldy #4+40
	lda #"*"
	sta (tmp),y
	iny
	lda #"+"
	sta (tmp),y

	ldy #35+40
	lda #"*"
	sta (tmp),y
	iny
	lda #"+"
	sta (tmp),y

	clc
	lda tmp
	adc #40
	sta tmp
	lda tmp+1
	adc #0
	sta tmp+1

	dex
	bne loop2
	rts
string1
.byt "*********+HALL OF FAME *********+",0

.)

_colorfxA
.(
	jsr _randomA
	and #7
	sta $bb80+18*40+1
	jsr _randomA
	and #7
	sta $bb80+19*40+1
	rts
.)


_helpaddr
.dsb 2

_drawhelp
.(


	lda _helpaddr
	sta tmp
	lda _helpaddr+1
	sta tmp+1

	ldy #0
	lda (sp),y
	sta tmp+2
	sta (tmp),y
	iny
	inc tmp+2
	lda tmp+2
	sta (tmp),y
	iny
	inc tmp+2
	lda tmp+2
	sta (tmp),y

	lda #9
	iny
	sta (tmp),y

	ldy #2
	lda (sp),y
	sta tmp+4
	iny
	lda (sp),y
	sta tmp+5

	clc
	lda tmp
	adc #5
	sta tmp
	lda tmp+1
	adc #0
	sta tmp+1

	ldy #0
loop
	lda (tmp+4),y
	beq skip
	sta (tmp),y
	iny
	bne loop

skip
	ldy #35
	inc tmp+2
	lda tmp+2
	sta (tmp),y
	iny
	inc tmp+2
	lda tmp+2
	sta (tmp),y
	iny
	inc tmp+2
	lda tmp+2
	sta (tmp),y

	clc
	lda _helpaddr
	adc #80
	sta _helpaddr
	lda _helpaddr+1
	adc #0
	sta _helpaddr+1

	rts
.)

_title_color
.byt 1,1,3,2,2,6,5,4

_clores 
.(
MAXI	=	8*17
	
	lda #<$a002
	sta tmp
	lda #>$a002
	sta tmp+1

	ldx #0
loop
	txa
	and #7
	tay
	lda _title_color,y
	ldy #0
	sta (tmp),y

	iny
	lda #26 
	sta (tmp),y
	
	clc
	lda tmp
	adc #40
	sta tmp
	lda tmp+1
	adc #0
	sta tmp+1

	inx
	cpx #MAXI
	bne loop

	lda #<$bb81
	sta tmp
	lda #>$bb81
	sta tmp+1

	lda #MAXI
	lsr
	lsr
	lsr
	tax
loop2
	lda #31 
	ldy #0
	sta (tmp),y

	clc
	lda tmp
	adc #40
	sta tmp
	lda tmp+1
	adc #0
	sta tmp+1

	dex
	bne loop2

	rts
.)

_YES
.byt "YES",0
_NO
.byt "NO",0


_ask_yes_or_no
.(
	ldy #0
	lda $208
	cmp #134
	beq _134
	cmp #136
	bne _ask_yes_or_no
_136
	ldx _NO,y
	beq exit
	jsr VDU
	iny
	bne _136
	 
_134
	ldx _YES,y
	beq exit
	jsr VDU
	iny
	bne _134
	 
exit
	sta _c
	rts 

.)

_choose_nextcolor 

	inc _color
_choose_samecolor
.(	
	lda _color
	cmp #8
	bmi skip
	lda #1
	sta _color
skip
	lda _render
	cmp #1
	beq exit

	lda #<$bb80+40
	sta tmp
	lda #>$bb80+40
	sta tmp+1
	
	ldy #0

	ldx #26
	
loop
	lda _color
	sta (tmp),y

	clc
	lda tmp
	adc #40
	sta tmp
	lda tmp+1
	adc #0
	sta tmp+1

	dex
	bne loop

exit	
	rts
.)

_render_instructions
.(
 

    ldy #0
loop4
    lda string_parameters,y
    beq skip11
    sta $bb80+40*17+9,y
    iny
    bne loop4
skip11
    lda #5
    sta $bb80+40*17    
 
    ldy #0
loop_insts
    lda string_instructions,y
    beq _keys
    sta $bb80+40*1+9,y
    iny
    bne loop_insts



_keys
    lda #<($bb80+40*2)
    sta tmp
    lda #>($bb80+40*2)
    sta tmp+1


    ldx #0
    ldy #2
loop_keys
    lda _screen_instructions,x

    beq skip2

    cmp #9
    bne skip9

   
 
    ldy #19
    lda #":"
    sta (tmp),y
    iny
    iny
    inx
    bne loop_keys


skip9
    cmp #10
    bne skip10

    clc
    lda tmp
    adc #40
    sta tmp
    lda tmp+1
    adc #0
    sta tmp+1
   
    ldy #2
    inx
    bne loop_keys


skip10
    sta (tmp),y
    iny
    inx
    bne loop_keys

skip2
    

    lda #18
    sta _ligne
    lda #4
    sta _max
    lda #1
    sta _mul
    lda #0
    sta _off


       



    lda _difficulty
    ldy #0
    sta (sp),y

    lda #0
    iny
    sta (sp),y

    lda #<string_difficulty
    iny
    sta (sp),y

    lda #>string_difficulty
    iny
    sta (sp),y

    ldy #4 
    jsr _saisiemagique

    stx _difficulty



    lda #15
    sta _max
    lda #0
    sta _off

    lda _musiclevel
    ldy #0
    sta (sp),y

    lda #0
    iny
    sta (sp),y

    lda #<string_musiclevel
    iny
    sta (sp),y

    lda #>string_musiclevel
    iny
    sta (sp),y

    ldy #4 
    jsr _saisiemagique

    stx _musiclevel


    lda #16
    sta _mul
    lda #15
    sta _off

    lda _speed
    ldy #0
    sta (sp),y

    lda #0
    iny
    sta (sp),y

    lda #<string_speed
    iny
    sta (sp),y

    lda #>string_speed
    iny
    sta (sp),y

    ldy #4 
    jsr _saisiemagique

    stx _speed


    lda #4
    sta _mul
    lda #16
    sta _off

    lda GAME+GAME_FPS
    ldy #0
    sta (sp),y

    lda #0
    iny
    sta (sp),y

    lda #<string_fps
    iny
    sta (sp),y

    lda #>string_fps
    iny
    sta (sp),y

    ldy #4 
    jsr _saisiemagique

    stx GAME+GAME_FPS


    lda #<($800)
    sta _mul
    lda #>($800)
    sta _mul+1

    lda #<($800)
    sta _off
    lda #>($800)
    sta _off+1

    lda _reg306
    ldy #0
    sta (sp),y

    lda _reg306+1
    iny
    sta (sp),y

    lda #<string_reg306
    iny
    sta (sp),y

    lda #>string_reg306
    iny
    sta (sp),y

    ldy #4 
    jsr _saisiemagique

    stx _reg306
    sta _reg306+1


    lda #1
    sta _mul
    sta _off
    lda #0
    sta _mul+1
    sta _off+1
    lda _tempobase
    ldy #0
    sta (sp),y

    lda #0
    iny
    sta (sp),y

    lda #<string_tempo
    iny
    sta (sp),y

    lda #>string_tempo
    iny
    sta (sp),y

    ldy #4 
    jsr _saisiemagique

    stx _tempobase
    stx _tempovalue
    stx _tempo
    lda #0
    sta _beat

    lda #15
    sta _max
    lda #0
    sta _off
    lda _beatmax
    ldy #0
    sta (sp),y

    lda #0
    iny
    sta (sp),y

    lda #<string_beatmax
    iny
    sta (sp),y

    lda #>string_beatmax
    iny
    sta (sp),y

    ldy #4 
    jsr _saisiemagique

    stx _beatmax
 

    rts  

 


.)





_autoDecreaseTimer
.(
	lda _infinite_time
	bne exit
 
	lda GAME+GAME_BIRTH 
	cmp GAME+GAME_FRAME 
	lda #0 
	sbc GAME+GAME_FRAME+1 
	bcc skip0
	jmp exit 
skip0 
 

	lda GAME+GAME_TIMER 
	sta tmp0 
	lda #0 
	sta tmp0+1 

	lda tmp0 
	.( 
	bne skip 
	dec tmp0+1 
skip 
	.)		
	dec tmp0 

	lda tmp0 
	sta GAME+GAME_TIMER 

	jmp _render_timerA 

exit
	rts 
.)
