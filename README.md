# NotAnotherBoulderDashCloneOricAtmos
Boulder Dash clone for Oric Atmos

-----------------------------------------------

hi dear oric fans

here is a recreation of the boulder dash game for the oric atmos 48k

NOT ANOTHER BOULDER DASH CLONE !

story :
	the project was started on december 2015 as a demo first to test some 
	asm routines and stopped it on holyday end.
	from may to june i take some time to evolve the project
	converting algorythms from js to C in osdk then rewritting most of c routines  
	to asm ones for much much speed, so the game is a little hard now :)
	graphics converted from 16x16 sprites to 18x16 sprites
	with paint.net and some private c# tools 
	
	inspired from codeincomplete.com
	made with the great osdk 0.18
	intro music from midi file of original tune
	original game by Peter Lepia and Chris Gray
	licensed from FirstStarSoftware inc.

	the sound is still not complete and bit experimental
	but the game is fully tested and playable 

features:
	20 playable levels
	4 color graphics in textmode and altmode (paper,ink,inverse paper,inverse ink)
	hall of fame 
	you have 3 starting lives
	and you gain 1 life for each level won
  

instructions :
	arrows to move
	space to toggle grab
	shift/func/ctrl + arrow to grab (without toggle)
	I : inverse charset
	C : change colors
	T : text mode (40*22)
	G : graphic mode (13*13)
	S : toogle sound
	P : Parameters
	esc : restart level (loose 1 life)
	return : next level (no life lost) : cheat : hit fast to not loose life !
	del : previous level (no life lost) : cheat : hit fast to not loose life !

  /*TODO* CHEATS :
  
  0 : toggle "infinite lifes"
  1 : toggle "infinite time"
  2 : toggle "wall pass" (pass through walls)
  3 : toggle "god mode"  (monsters and explosions dont kill you)
  4 : toggle "explose" (key E) (explose all cells aroud you)
  
  *TODO*/
  
	display:

	diamonds needed value collected timer score
	10	 *	10    0         100   10000

...


	  grab            cave name		     frame#


todolist:
	graphics
	tape loader
	save scores  
	bdcff conversion : new levels !
	hires intro image
	pause !
	ingame cheat parameters : speed,fps,difficulty,lifes,time  
	better readme format !
  
  
bug reports & suggestions welcome

enjoy !

seb 


