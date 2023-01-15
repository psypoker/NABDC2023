 

 
//GIVAYF  = $d499
//FOUT	= $e0d5


_seekzero2
.(
	sty op2
	sta op2+1
	jsr itoa
 	ldy #1
loop1
	lda bufconv,y
	beq skip1
	iny 
	bne loop1
skip1
	rts
.)

_newGame
.(	
	lda #0
	sta _score
	sta _score+1
	sta _lifes+1
	sta _difficulty
	lda #3
	sta _lifes
	lda $276
	sta _randomA+1
	jsr _randomA
	and #15
	sta GAME+GAME_INDEX
	jmp _resetGame
.)

_prevGame
.(
	dec GAME+GAME_INDEX
	lda GAME+GAME_INDEX
	cmp #$ff
	bne skip
	lda #19
	sta GAME+GAME_INDEX
skip
	jmp _resetGame
.)

_nextGame
.(
	inc GAME+GAME_INDEX
	lda GAME+GAME_INDEX
	cmp #20
	bmi skip
	lda #0
	sta GAME+GAME_INDEX
skip
	jmp _resetGame
.)

















_render_frameA
.(
 	ldy GAME+GAME_FRAME
	lda GAME+GAME_FRAME+1
	jsr _seekzero2

	dey		// y = indexof 0
	ldx #5
loop1
	lda bufconv,y
	sta $bb80+34+27*40,x
	dex
	dey
	bpl loop1

	rts
.)
 

_render_scoreA
.(
 	ldy _score
	lda _score+1
	jsr _seekzero2

	dey		// y = indexof 0
	ldx #5
loop1
	lda bufconv,y
	sta $bb80+31,x
	dex
	dey
	bpl loop1
 
	rts
.)


 

_render_diamondsNeededA
.(
  	ldy DIAMONDS+DIAMONDS_NEEDED
	lda #0
	jsr _seekzero2

	dey		// y = indexof 0
	ldx #3
loop1
	lda bufconv,y
	sta $bb80+7-3,x
	dex		// x=1;y=1
	dey		// y=0
	bpl loop1
 
	rts
.)

_render_diamondsCurrentValueA
.(
  	ldy DIAMONDS+DIAMONDS_CURRENTVALUE
	lda #0
	jsr _seekzero2

	dey		// y = indexof 0
	ldx #3
loop1
	lda bufconv,y
	sta $bb80+12-3,x
	dex		// x=1;y=1
	dey		// y=0
	bpl loop1
 
	rts
.)
 

_render_diamondsCollectedA
.(
  	ldy DIAMONDS+DIAMONDS_COLLECTED
	lda #0
	jsr _seekzero2

	dey		// y = indexof 0
	ldx #3
loop2
	lda bufconv,y
	 
	sta $bb80+18-3,x
	dex
	dey
	bpl loop2

	rts
.)

_render_timerA
.(
 	ldy GAME+GAME_TIMER
	lda #0
 	jsr _seekzero2

	dey		// y = indexof 0
	ldx #3
loop1
	lda bufconv,y
	sta $bb80+26-3,x
	dex
	dey
	bpl loop1
 
	cpx #1
	bmi exit
	lda #"0"
	sta $bb80+26-3,x
exit
 	rts
.)
 
 


 
