//.dsb 256-(*&255) 

lastTIMER
.word 0
currentTIMER
.word 0
ellapsedTIMER
.word 0

QUOT2
.byt 1
RMDR2
.byt 1

 

#define CTIMER  $276

_cint
.(
#define _QUINT1 $d92c

	jsr _QUINT1
	lda $d3
	ldx $d4
	rts
.)

_cdbl
.(
#define _GIVAYF $d499

	
	ldy #1
	lda (sp),y
	sta tmp
	dey
	lda (sp),y
	tay
	lda tmp
	
	jmp _GIVAYF

.)

_curset1
.(
	lda #0
	sta $2e0
	sta $2e2
	sta $2e4
	sta $2e6
	ldy #0
	lda (sp),y
	sta $2e1
	ldy #5
	lda (sp),y
	sta $2e3
	ldy #10
	lda (sp),y
	lda #1
	sta $2e5
	jsr $f0c8
	lda $2e0
	rts

.)

_curmov1
.(
	lda #0
	sta $2e0
	sta $2e2
	sta $2e4
	sta $2e6
	ldy #0
	lda (sp),y
	sta $2e1
	ldy #5
	lda (sp),y
	sta $2e3
	ldy #10
	lda (sp),y
	lda #3
	sta $2e5
	jsr $f0c8
	lda $2e0
	rts

.)
_drawto1
.(
	lda #0
	sta $2e0
	sta $2e2
	sta $2e4
	sta $2e6
	ldy #0
	sec
	lda (sp),y
	sbc $219
	sta $2e1
	lda#0
	sbc #0
	sta $2e2
	ldy #5
	sec
	lda (sp),y
	sbc $21a
	sta $2e3
	lda #0
	sbc #0
	sta $2e4
	ldy #10
	lda (sp),y
	lda #1
	sta $2e5
	jsr $f110
	lda $2e0
	rts

.)
_chrono_restart
.(
	sei
	lda CTIMER
	sta lastTIMER
	lda CTIMER+1
	sta lastTIMER+1
	cli
	rts
.)

_chrono_ellapsed
.(
	sei
	sec
	lda lastTIMER
	sbc CTIMER
	sta ellapsedTIMER

	lda lastTIMER+1
	sbc CTIMER+1
	sta ellapsedTIMER+1

	ldx ellapsedTIMER
	lda ellapsedTIMER+1
	cli
	rts
.)

_chrono_out
.(
	

.)
_chrono_ellapsed_out
.(
	sei
	sec
	lda lastTIMER
	sbc CTIMER
	sta ellapsedTIMER

	lda lastTIMER+1
	sbc CTIMER+1
	sta ellapsedTIMER+1

	ldy #0
	lda ellapsedTIMER
	sta (sp),y
	ldy #1
	lda ellapsedTIMER+1
	sta (sp),y
	lda #100
	ldy #2
	sta (sp),y

	jsr _div
 
	sta QUOT2
	stx RMDR2
	
	lda QUOT2
	jsr  _itoa2
	 
	ldx #"."
	jsr $f77C

	lda RMDR2
	cmp #10
	bpl supo

	ldx #"0"
	jsr $f77c

supo
	jsr  _itoa2
	
	ldx #" "
	jsr $f77C

	ldx ellapsedTIMER
	lda ellapsedTIMER+1

	cli
	rts
.)


op22
	.byt $0,$0

bufconv2
	.dsb 8



_itoa2
.(
	sta op22
	ldy #0
	sty op22+1
	sty bufconv2
	bpl itoaloop2
 	lda #$2D	; minus sign
 	sta bufconv2
	 
itoaloop2
	jsr _udiv10
	pha
	iny
	lda op22
	ora op22+1
	bne itoaloop2
	
	ldx #0
	lda bufconv2
	beq poploop2
	inx

poploop2
	pla
	clc
	adc #$30
	sta bufconv2,x
	inx
	dey
	bne poploop2
	lda #0
	sta bufconv2,x
	lda #<bufconv2
	ldy #>bufconv2

	ldy #0
loop_vdu
	lda bufconv2,y
	cmp #0
	beq fin_vdu

    tax
	
	jsr $f77c
	
	iny
	jmp loop_vdu
	
fin_vdu
;	ldx #" "
;	jsr $f77c

	rts


.)



; udiv10 op2= op2 / 10 and A= tmp2 % 10

_udiv10
.(
	lda #0
	ldx #16
	clc
udiv10lp2
	rol op22
	rol op22+1
	rol 
	cmp #10
	bcc contdiv2
	sbc #10
	
contdiv2
	dex
	bne udiv10lp2
	rol op22
	rol op22+1
    rts
.)
 

_itoh
.(
	 
	pha
	ldx #"$"
	jsr $f77c

	pla
_itoh2
	pha


	lsr
	lsr
	lsr
	lsr
 	
	tay
	lda hexa,y

	tax
	jsr $f77c

	pla
	and #15

	tay
	lda hexa,y

	jmp $F7E4
	tax
	jsr $f77c
 
	
	rts
 
.) 

_itoh3
.(
	pha


	lsr
	lsr
	lsr
	lsr
 
	tay
	lda hexa,y
	 
 
	ldy #0
	sta (tmp),y

	pla
	and #15

	tay
	lda hexa,y
	 
	ldy #1
	sta (tmp),y
 
	
	rts
.)

hexa
.byte 48,49,50,51,52,53,54,55,56,57,65,66,67,68,69,70, 72,73,74,75 
 

;F7E4 48 PHA PRINT ACCUMULATOR ON SCREEN.
;F7E5 AC 69 02 LDY $0269
;F7E8 91 12 STA ($12),Y
;F7EA 2C 6A 02 BIT $026A
;F7ED 50 0B BVC $F7FA Double height flag is clear.
;F7EF AD 69 02 LDA $0269
;F7F2 18 CLC In double height mode the
;F7F3 69 28 ADC #$28 char is printed on the line
;F7F5 A8 TAY below in the same column.
;F7F6 68 PLA
;F7F7 48 PHA
;F7F8 91 12 STA ($12),Y Put A on screen.
;Page 110
;F7FA A9 09 LDA #$09 Move cursor forward by 1
;F7FC 20 02 F6 JSR $F602 column.
;F7FF 68 PLA
;F800 60 RTS
 