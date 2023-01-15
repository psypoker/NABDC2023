/*************
_midi2periodA
.(
	ldy #0
	lda (sp),y

	tax
	lda $fc6b,x
	sta peri
	lda $fc5e,x
	sta peri+1 

	ldy #2
	lda (sp),y
	beq fini
	tax
loop
	lsr peri+1
	ror peri
	dex
	bmi loop

fini
	lda peri
	ldx peri+1
	rts

peri
.word 0
.)
*****************/

 
 
_MUSIC = $fc18
PARAMS = $2e0
_SOUND = $fb40
_PLAY  = $fbd0
 
_playenvel   // play(channels,noize,envel,0)
.(
    lda #0
    sta PARAMS+2
    sta PARAMS+4
    sta PARAMS+6 
    sta PARAMS+7

    lda _CHANNELS
    sta PARAMS+1
    lda _NOIZE
    sta PARAMS+3
    lda _ENVEL
    sta PARAMS+5
    lda _ENVLEN
    sta PARAMS+6
    lda _ENVLEN+1
    sta PARAMS+7
    
    lda #0
    sta _ENVLEN
    sta _ENVLEN+1
    sta _ENVEL
    jmp _PLAY


.)


_play_musicB
.(
    dec _tempo
    beq skip2
    rts
skip2
    lda _tempovalue
    sta _tempo

    lda _beat
    asl
    tax
    lda _switchtab3,xs
    sta __p__+1
    lda _switchtab3+1,x
    sta __p__+2

__p__
    jmp $bbbb
     
period1
.word 0 
period2
.word 0


_switchtab3
.word _step0 
.word _mall
.word _m1
.word _m1

.word _mall
.word _mall
.word _m2
.word _m2

.word _m1
.word _mall
.word _m1
.word _m1

.word _mall
.word _mall
.word _mmute
.word _mmute

_step0
.( 
	lda #1
    sta PARAMS+1
   
    lda _musicindex
    asl
    tay
    lda _converted1,y
    sta period1
    sta PARAMS+3
    lda _converted2,y
    sta period2
    iny
    lda _converted1,y
    sta period1+1
    sta PARAMS+4
    lda _converted2,y
    sta period2+1
    lda _musiclevel
    sta PARAMS+5

    jsr _SOUND

 	lda #2
    sta PARAMS+1
    lda #0
    sta PARAMS
    sta PARAMS+2
    sta PARAMS+6
  
    lda period2
 	sta PARAMS+3
    lda period2+1
    sta PARAMS+4
    lda _musiclevel
    sta PARAMS+5

brik
    jsr _SOUND

.)
.)
_playchannels
.(   
    // 4* + 2 + 1

    lda _CHANNELS
    ora #1
    sta _CHANNELS
    jsr _playenvel


    inc _musicindex
    lda _musicindex
    and #127
    sta _musicindex

    lda _beat
    cmp _beatmax
    bne skip3
    lda #0
    sta _beat
    rts
   

skip3
    inc _beat
    rts

 

.)

_mmute
_step1 // 4+0 (mute)
.(

    lda _CHANNELS
    and #4
    sta _CHANNELS
    jsr _playenvel

    jmp _nextstep
.)

_m1
_step2  // 4 +1 (channel 1)
.(

    lda _CHANNELS
    and #4
    ora #1
    sta _CHANNELS
    jsr _playenvel

    jmp _nextstep
.)

_m2
_step3  // 4+2 (channel 2)
.(

    lda _CHANNELS
    and #4
    ora #2
    sta _CHANNELS
    jsr _playenvel

    jmp _nextstep
.)

_mall
_step4 // all (unmute)
.(

    lda _CHANNELS
    ora #3
    sta _CHANNELS
    jsr _playenvel
 
    jmp _nextstep
.)

/*
_step5
.(
    jmp _nextstep
.)

_step6
.(
    jmp _nextstep
.)

_step7
.(
    jmp _nextstep
.)
*/

_nextstep
.(
    lda _beat
    cmp _beatmax
    bne skip3
    lda #0
    sta _beat
    rts

skip3
    inc _beat

    rts
     
.)
 


_play0000
.(
    lda #0

    sta PARAMS+1
	sta PARAMS+2
    sta PARAMS+3
	sta PARAMS+4
    sta PARAMS+5
	sta PARAMS+6
    sta PARAMS+7
	sta PARAMS+8
    jmp _PLAY
.)


_playfx
.(
    lda #0
    sta PARAMS+2
   
    sta PARAMS+6
    lda #3
    sta PARAMS+1
    lda _PERIOD
    sta PARAMS+3
    lda _PERIOD+1
    sta PARAMS+4
    lda _VOLUM
    sta PARAMS+5
    jsr _SOUND

    lda #0
    sta PARAMS+2
    sta PARAMS+4
    sta PARAMS+6
    lda _CHANNELS
    ora #4
    sta _CHANNELS
    sta PARAMS+1
    lda _NOIZE
    sta PARAMS+3
    lda _ENVEL
    sta PARAMS+5
    lda _ENVLEN
    sta PARAMS+7
    lda _ENVLEN+1
    sta PARAMS+8
    jmp _PLAY
.)

_VOLUM
.byt 0


_soundrandom3
.(
    lda AMOEBA+AMOEBA_SIZE
    beq exit
    jsr _randomA
    and #127
    ora #128
    sta PARAMS+3
    lda #1
    sta PARAMS+4
    lda #0
    sta PARAMS+2
    sta PARAMS+6
    lda #3
    sta PARAMS+1
 
    inc cycle32
    lda cycle32
    and #31
    tax 

    lda triangle32,x
     
    sta PARAMS+5
    jsr _SOUND
    lda #0
    sta PARAMS+2
    sta PARAMS+4
    sta PARAMS+6
    lda _CHANNELS
    and #4
    sta _CHANNELS
    sta PARAMS+1
    lda #0
    sta PARAMS+3
    lda #0
    sta PARAMS+5
    lda #0
    sta PARAMS+7
    lda #0
    sta PARAMS+8
    jmp _PLAY
exit
    rts


.)

_soundrandom3magic
.(
    lda MAGIC+MAGIC_ACTIVE
    beq exit
    lda #0 
    sta PARAMS+4
    jsr _randomA
    and #31
    ora #192
    sta PARAMS+3
    sta PARAMS+5
    lda #0
    sta PARAMS+2
    sta PARAMS+6
    lda #3
    sta PARAMS+1
 
    inc cycle32
    inc cycle32
    lda cycle32
    and #31
    tax 

    lda triangle32,x
    
    sta PARAMS+5
    jsr _SOUND
    lda #0
    sta PARAMS+2
    sta PARAMS+4
    sta PARAMS+6
    lda _CHANNELS
    and #4
    sta _CHANNELS
    sta PARAMS+1
    lda #0
    sta PARAMS+3
    lda #0
    sta PARAMS+5
    lda #0
    sta PARAMS+7
    lda #0
    sta PARAMS+8
    jmp _PLAY
exit
    rts



.)
cycle32
.byt 0
triangle32
.byt 1,1,1,2, 2,3,4,5, 6,7,8,9, 10,11,12,13, 14,15,14,13, 12,11,10,9, 8,7,6,5, 4,3,2,2  
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_soundAmoebaA
.(
    lda _SOUND_ACTIVE
    beq exit

    lda _AMOEBA_SOUND_ENABLED
    bne exit

    lda _MUSIC_ACTIVE
    beq skip

    jsr _disablemusic
skip
    
    jsr _enable_sound_amoeba

    jsr _randomA
    sta _PERIOD
    lda #1
    sta _PERIOD+1
    lda #4
    sta _CHANNELS
    lda #0
    sta _NOIZE
    lda #0
    sta _ENVEL
    sta _ENVLEN
    sta _ENVLEN+1
    lda #0
    sta _VOLUM
//  lda #<(500)
 //   sta _ENVLEN
 //   lda #>(500)
 //   sta _ENVLEN+1
  
    jmp _playfx
 
exit
    rts
.)

_soundMagicA
.(
    lda _SOUND_ACTIVE
    beq exit

    lda _MAGIC_SOUND_ENABLED
    bne exit

    lda _MUSIC_ACTIVE
    beq skip

    jsr _disablemusic
skip
    
    jsr _enable_sound_magic

    jsr _randomA
    and #$3f
    ora #$40
    sta _PERIOD
    lda #01
    sta _PERIOD+1
    lda #4
    sta _CHANNELS
    lda #0
    sta _NOIZE
    lda #0
    sta _ENVEL
    sta _ENVLEN
    sta _ENVLEN+1
    lda #0
    sta _VOLUM
//    lda #<(100)
 //   sta _ENVLEN
 //   lda #>(100)
//    sta _ENVLEN+1
    jmp _playfx

exit
    rts
.)

//void soundpickeddiamond()
//{
//  if (!SOUND_ACTIVE) return;
//  PERIOD=196;
//  NOIZE=0;    ENVEL=1;    ENVLEN=70;
//  playfx();
//}

_soundPickedDiamondA
.(
    lda _SOUND_ACTIVE
    beq exit
    
    lda #98
    sta _PERIOD
    lda #0
    sta _PERIOD+1
    lda #4
    sta _CHANNELS
    lda #0
    sta _NOIZE
    lda #1
    sta _ENVEL
    lda #<(30)
    sta _ENVLEN
    lda #>(30)
    sta _ENVLEN+1
    jmp _playfx

exit
    rts
.)

//void soundboulder()
//{
//  if (!SOUND_ACTIVE) return;
//  PERIOD=870;
//  NOIZE=4;ENVEL=1;ENVLEN=60;
//  playfx();
//}
_soundboulder
_soundBoulderA
.(
    lda _SOUND_ACTIVE
    beq exit
    
    lda #<(870)
    sta _PERIOD
    lda #>(870)
    sta _PERIOD+1
    lda #4
    sta _CHANNELS
    lda #4
    sta _NOIZE
    lda #1
    sta _ENVEL
    lda #<(30)
    sta _ENVLEN
    lda #>(30)
    sta _ENVLEN+1
    jmp _playfx

exit
    rts
.)

//void soundmoving()
//{
//  if (!SOUND_ACTIVE) return;
//  PERIOD=24;
//  NOIZE=4;ENVEL=1;ENVLEN=20;
//  playfx();
//}
 
_soundMovingA
.(
    lda _SOUND_ACTIVE
    beq exit
    
    lda #<(24)
    sta _PERIOD
    lda #>(24)
    sta _PERIOD+1
    lda #4
    sta _CHANNELS
    lda #4
    sta _NOIZE
    lda #1
    sta _ENVEL
    lda #<(5)
    sta _ENVLEN
    lda #>(5)
    sta _ENVLEN+1
    jmp _playfx

exit
    rts
.)
//void soundmovingempty()
//{
//  if (!SOUND_ACTIVE) return;
//  PERIOD=75;
//  NOIZE=4;ENVEL=1;ENVLEN=20;
//  playfx();
//}
 
_soundMovingEmptyA
.(
    lda _SOUND_ACTIVE
    beq exit
    
    lda #<(75)
    sta _PERIOD
    lda #>(75)
    sta _PERIOD+1
    lda #4
    sta _CHANNELS
    lda #4
    sta _NOIZE
    lda #1
    sta _ENVEL
    lda #<(5)
    sta _ENVLEN
    lda #>(5)
    sta _ENVLEN+1
    jmp _playfx

exit
    rts
.)

//void soundexplosion()
//{
//  if (!SOUND_ACTIVE) return;
//  PERIOD=400;
//  NOIZE=4;ENVEL=1;ENVLEN=300;
//  playfx();
//}

_soundExplosionA
.(
    lda _SOUND_ACTIVE
    beq exit
    
    lda #<(400)
    sta _PERIOD
    lda #>(400)
    sta _PERIOD+1
    lda #4
    sta _CHANNELS
    lda #4
    sta _NOIZE
    lda #1
    sta _ENVEL
    lda #<(400)
    sta _ENVLEN
    lda #>(400)
    sta _ENVLEN+1
    jmp _playfx

exit
    rts
.)

//void sounduncover()
//{
//  if (!SOUND_ACTIVE) return;
//  PERIOD=18+(randomA()&23);
//  NOIZE=0;ENVEL=1;ENVLEN=15;CHANNELS=4;
//  playfx();
//}

_sounduncover
.(
    lda _SOUND_ACTIVE
    beq exit
    
    jsr _randomA
    and #23
    clc
    adc #18
    sta _PERIOD
    lda #0
    sta _PERIOD+1
    lda #4
    sta _CHANNELS
    lda #0
    sta _NOIZE
    lda #1
    sta _ENVEL
    lda #<(10)
    sta _ENVLEN
    lda #>(10)
    sta _ENVLEN+1
    jmp _playfx

exit
    rts
.)

 
_playsounds
.(
    lda _MUSIC_ACTIVE
    beq skip1
    lda _CHANNELS
    ora #3
    sta _CHANNELS
skip1
    lda $24a
    cmp #$40
    bne skip2
      lda _MUSIC_ACTIVE
      beq skip3
          jsr _intromusic
skip2
    lda _MUSIC_ACTIVE
    bne skip3
	lda _AMOEBA_SOUND_ENABLED
	bne skip3
	lda _MAGIC_SOUND_ENABLED
	bne skip3
        jsr _removeIrq
        lda _CHANNELS
        and #4
        sta _CHANNELS

        lda #0
        sta _ENVLEN
        sta _ENVEL
        jsr _playfx

skip3
    lda MAGIC+MAGIC_ACTIVE
    beq skipmagic
        jsr _soundMagicA
skipmagic
    lda AMOEBA+AMOEBA_SIZE
    beq exit
      //  lda #0
      //  sta _AMOEBA_SOUND_ENABLED
        jsr _soundAmoebaA
exit
    rts
.)