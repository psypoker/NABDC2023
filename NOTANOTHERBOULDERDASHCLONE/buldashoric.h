// util macros
#define max(x,y)			(x>y?x:y)
#define min(x,y)			(x<y?x:y)

// CAVE DATAS 
#define CAVE_WIDTH	40
#define CAVE_HEIGHT 22
#define CAVE_SIZE	880
#define AMOEBA_MAX  200

// dests
#define BB8040		48040 
#define BB804023	48920
#define BB804024	48960
#define BB804027	49080
#define BB80402701	49081
#define BB80402728	49108
#define BB804011	48440
#define BB804012	48480
#define BB804013	48520
#define BB804014	48560
#define BB80402718	49098

char color = 1;
#define A_FWBLACK	 0
#define A_FWRED 	 1
#define A_FWGREEN	 2
#define A_FWYELLOW	 3
#define A_FWBLUE	 4
#define A_FWMAGENTA	 5
#define A_FWCYAN	 6
#define A_FWWHITE	 7
#define A_BGBLACK	16
#define A_BGRED 	17
#define A_BGGREEN	18
#define A_BGYELLOW	19
#define A_BGBLUE	20
#define A_BGMAGENTA	21
#define A_BGCYAN	22
#define A_BGWHITE	23
#define A_STD		 8
#define A_ALT		 9
#define A_STD2H 	10
#define A_ALT2H 	11
#define A_STDFL 	12
#define A_ALTFL 	13
#define A_STD2HFL	14
#define A_ALT2HFL	15
#define A_TEXT60	24
#define A_TEXT50	26
#define A_HIRES60	28
#define A_HIRES50	30

char RANDOM_COLOR[] = { 1,2,3,4,5,6,7,1,1,2,3,4,5,6,7,2,1,2,3,4,5,6,7,3,1,2,3,4,5,6,7,5 };

extern unsigned char DATA01[], DATA02[], DATA03[], DATA04[], DATA05[], DATA06[], DATA07[], DATA08[], DATA09[], DATA10[], DATA11[], DATA12[], DATA13[], DATA14[], DATA15[], DATA16[], DATA17[], DATA18[], DATA19[], DATA20[];
unsigned char* DT[] = { DATA01,DATA02,DATA03,DATA04,DATA05,DATA06,DATA07,DATA08,DATA09,DATA10,DATA11,DATA12,DATA13,DATA14,DATA15,DATA16,DATA17,DATA18,DATA19,DATA20 };
// OBJECTS ids
#define OBJECT_SPACE				0x00  
#define OBJECT_DIRT					0x01 
#define OBJECT_BRICKWALL			0x02  
#define OBJECT_MAGICWALL			0x03 
#define OBJECT_PREOUTBOX			0x04
#define OBJECT_OUTBOX				0x05
//6
#define OBJECT_STEELWALL			0x07 
#define OBJECT_FIREFLY_LEFT			0x08 
#define OBJECT_FIREFLY_UP			0x09 
#define OBJECT_FIREFLY_RIGHT		0x0a 
#define OBJECT_FIREFLY_DOWN			0x0b
#define OBJECT_FIREFLY1_STF			0x0c 
#define OBJECT_FIREFLY2_STF			0x0d 
#define OBJECT_FIREFLY3_STF			0x0e 
#define OBJECT_FIREFLY4_STF			0x0f

#define OBJECT_BOULDER				0x10  
#define OBJECT_BOULDER_STF			0x11  
#define OBJECT_BOULDERFALLING		0x12
#define OBJECT_BOULDERFALLING_STF	0x13
#define OBJECT_DIAMOND				0x14  
#define OBJECT_DIAMOND_STF			0x15  
#define OBJECT_DIAMONDFALLING		0x16
#define OBJECT_DIAMONDFALLING_STF	0x17
//18
//19
//1a
#define OBJECT_EXPLODETOSPACE0		0x1b
#define OBJECT_EXPLODETOSPACE1		0x1c
#define OBJECT_EXPLODETOSPACE2		0x1d
#define OBJECT_EXPLODETOSPACE3		0x1e
#define OBJECT_EXPLODETOSPACE4		0x1f
#define OBJECT_EXPLODETODIAMOND0	0x20
#define OBJECT_EXPLODETODIAMOND1	0x21
#define OBJECT_EXPLODETODIAMOND2	0x22
#define OBJECT_EXPLODETODIAMOND3	0x23
#define OBJECT_EXPLODETODIAMOND4	0x24

#define OBJECT_PREROCKFORD1			0x25
#define OBJECT_PREROCKFORD2			0x26
#define OBJECT_PREROCKFORD3			0x27
#define OBJECT_PREROCKFORD4			0x28

#define OBJECT_BUTTERFLY_LEFT		0x30 
#define OBJECT_BUTTERFLY_UP			0x31
#define OBJECT_BUTTERFLY_RIGHT		0x32
#define OBJECT_BUTTERFLY_DOWN		0x33
#define OBJECT_BUTTERFLY1_STF		0x34 
#define OBJECT_BUTTERFLY2_STF		0x35
#define OBJECT_BUTTERFLY3_STF		0x36
#define OBJECT_BUTTERFLY4_STF		0x37
#define OBJECT_ROCKFORD				0x38  
#define OBJECT_ROCKFORD_STF			0x39 
#define OBJECT_AMOEBA				0x3A 
#define OBJECT_AMOEBA_STF			0x3B

#define TERMINATOR 0xFF 

char* NAMES[] = { "INTRO",      "ROOMS",        "MAZE",       "BUTTERFLIES",
	"GUARDS",     "FIREFLY DENS", "AMOEBA",     "ENCHANTED WALL",
	"GREED",      "TRACKS",       "CROWD",      "WALLS",
	"APOCALYPSE", "ZIGZAG",       "FUNNEL",     "ENCHANTED BOXES",
	"INTERVAL ONE", "INTERVAL TWO",   "INTERVAL THREE", "INTERVAL FOUR",
};

char* DESCRIPTIONS[] = {
	"PICK UP JEWELS\nAND EXIT BEFORE TIME IS UP",
	"PICK UP JEWELS,\nBUT YOU MUST MOVE BOULDERS TO GET ALL JEWELS",
	"PICK UP JEWELS.\nYOU MUST GET EVERY JEWEL TO EXIT",
	"DROP BOULDERS ON BUTTERFLIES TO CREATEJEWELS",
	"THE JEWELS ARE THERE FOR GRABBING,\nBUT THEY ARE GUARDED BY THE DEADLY\nFIREFLIES",
	"EACH FIREFLY IS GUARDING A JEWEL",
	"SURROUND THE AMOEBA WITH BOULDERS.\nPICK UP JEWELS WHEN IT SUFFOCATES",
	"ACTIVATE THE ENCHANTED WALL AND CREATEAS MANY JEWELS AS YOU CAN",
	"YOU HAVE TO GET A LOT OF JEWELS HERE,\nLUCKY THERE ARE SO MANY",
	"GET THE JEWELS, AVOID THE FIREFLIES",
	"YOU MUST MOVE A LOT OF BOULDERS AROUNDIN SOME TIGHT SPACES",
	"DROP A BOULDER ON A FIREFLY AT THE\nRIGHT TIME TO BLAST THROUGH WALLS",
	"BRING THE BUTTERFLIES AND AMOEBA\nTOGETHER AND WATCH THE JEWELS FLY",
	"MAGICALLY TRANSFORM THE BUTTERFLIES\nINTO JEWELS,BUT DON'T WASTE\nANY BOULDERS",
	"THERE IS AN ENCHANTED WALL AT THE\nBOTTOM OF THE ROCK TUNNEL",
	"THE TOP OF EACH ROOM IS AN ENCHANTED\nWALL, BUT YOU'LL HAVE TO BLAST YOUR\nWAY INSIDE",
	"INTERVAL ONE",
	"INTERVAL TWO",
	"INTERVAL THREE",
	"INTERVAL FOUR"
};

#define TRUE  1U
#define FALSE 0U

unsigned char inversecharset = FALSE;


#define ROCKFORD_FRONT		0
//#define ROCKFORD_FRONT_1	0
//#define ROCKFORD_FRONT_2	0
//#define ROCKFORD_FRONT_3	0
//#define ROCKFORD_FRONT_4	0
//#define ROCKFORD_FRONT_5	0
//#define ROCKFORD_FRONT_6	0
//#define ROCKFORD_FRONT_7	0
//#define ROCKFORD_FRONT_8	0

#define ROCKFORD_TAP_1		8
#define ROCKFORD_TAP_2		9
#define ROCKFORD_TAP_3		10
#define ROCKFORD_TAP_4		11
#define ROCKFORD_TAP_5		12
#define ROCKFORD_TAP_6		13
#define ROCKFORD_TAP_7		14
#define ROCKFORD_TAP_8		15

#define ROCKFORD_BLINK_1	16 
#define ROCKFORD_BLINK_2	17
#define ROCKFORD_BLINK_3	18 
#define ROCKFORD_BLINK_4	19
#define ROCKFORD_BLINK_5	20 
#define ROCKFORD_BLINK_6	21
#define ROCKFORD_BLINK_7	22 
#define ROCKFORD_BLINK_8	23

#define ROCKFORD_BLINKTAP_1	24
#define ROCKFORD_BLINKTAP_2 25
#define ROCKFORD_BLINKTAP_3	26
#define ROCKFORD_BLINKTAP_4 27
#define ROCKFORD_BLINKTAP_5	28
#define ROCKFORD_BLINKTAP_6 29
#define ROCKFORD_BLINKTAP_7	30
#define ROCKFORD_BLINKTAP_8 31

#define ROCKFORD_LEFT_1		32
#define ROCKFORD_LEFT_2		33
#define ROCKFORD_LEFT_3		34
#define ROCKFORD_LEFT_4		35
#define ROCKFORD_LEFT_5		36
#define ROCKFORD_LEFT_6		37
#define ROCKFORD_LEFT_7		38
#define ROCKFORD_LEFT_8		39

#define ROCKFORD_RIGHT_1	40
#define ROCKFORD_RIGHT_2	41
#define ROCKFORD_RIGHT_3	42
#define ROCKFORD_RIGHT_4	43
#define ROCKFORD_RIGHT_5	44
#define ROCKFORD_RIGHT_6	45
#define ROCKFORD_RIGHT_7	46
#define ROCKFORD_RIGHT_8	47



// adresses 6 character standard set (0xb400)

const unsigned int P_DIRT = 0xb400 + 33 * 8;
const unsigned int P_BRICK = 0xb400 + 39 * 8;
const unsigned int P_MAGIC = 0xb400 + 45 * 8;
const unsigned int P_PREOUTBOX = 0xb400 + 51 * 8;
const unsigned int P_STEEL = 0xb400 + 57 * 8;
const unsigned int P_FIREFLY = 0xb400 + 63 * 8;
const unsigned int P_BOULDER = 0xb400 + 69 * 8;
const unsigned int P_DIAMOND = 0xb400 + 75 * 8;
const unsigned int P_BUTTERFLY = 0xb400 + 81 * 8;
const unsigned int P_ROCKFORD = 0xb400 + 87 * 8;
const unsigned int P_AMOEBA = 0xb400 + 93 * 8;
const unsigned int P_EXPLOSE_TO_SPACE = 0xb400 + 99 * 8;
const unsigned int P_EXPLOSE_TO_DIAMOND = 0xb400 + 105 * 8;
const unsigned int P_SPACE = 0xb400 + 111 * 8;


extern char readkeyA();
#define RENDER_SPRITE   0
#define RENDER_ASCII 	1

#define clrscr(c) memset((void*)0xbb80,c,1120)

extern void aWait(unsigned char t);
extern void drawMapDirectA();
#define render_level()		drawMapDirectA()
extern void render_level_asciiA();
#define render_level_ascii() render_level_asciiA()
extern void play0000();


#define animate_diamond()				load_sprite_dataD(SP_DIAMOND	[cycle8]		,P_DIAMOND			,inversecharset?255:0)
#define animate_rockford()				load_sprite_dataD(SP_ROCKFORD	[rockford_cycle],P_ROCKFORD			,inversecharset?255:0)
#define animate_magic()					load_sprite_dataD(SP_MAGIC		[cycle4]		,P_MAGIC			,inversecharset?0:255)
#define animate_amoeba()				load_sprite_dataD(SP_AMOEBA		[cycle8]		,P_AMOEBA			,inversecharset?0:255)
#define animate_firefly()				load_sprite_dataD(SP_FIREFLY	[cycle8]		,P_FIREFLY			,inversecharset?0:255)
#define animate_butterfly()				load_sprite_dataD(SP_BUTTERFLY	[cycle8]		,P_BUTTERFLY		,inversecharset?255:0)
#define animate_explose_to_space()		load_sprite_dataD(SP_EXPLOSE_TO_SPACE[explosespace_cycle]	  ,P_EXPLOSE_TO_SPACE	,inversecharset?0:255)
#define animate_explose_to_diamond()	load_sprite_dataD(SP_EXPLOSE_TO_DIAMOND[explosediamond_cycle] ,P_EXPLOSE_TO_DIAMOND	,inversecharset?0:255)

// asm datas
extern unsigned char sprite_rockford[];
extern unsigned char sprite_rockford_blink_1[], sprite_rockford_blink_2[];
extern unsigned char sprite_rockford_tap_1[], sprite_rockford_tap_2[];
extern unsigned char sprite_rockford_blinktap_1[], sprite_rockford_blinktap_2[];
extern unsigned char sprite_rockford_run_left_1[], sprite_rockford_run_left_2[], sprite_rockford_run_left_3[], sprite_rockford_run_left_4[];
extern unsigned char sprite_rockford_run_left_5[], sprite_rockford_run_left_6[], sprite_rockford_run_left_7[], sprite_rockford_run_left_8[];
extern unsigned char sprite_rockford_run_right_1[], sprite_rockford_run_right_2[], sprite_rockford_run_right_3[], sprite_rockford_run_right_4[];
extern unsigned char sprite_rockford_run_right_5[], sprite_rockford_run_right_6[], sprite_rockford_run_right_7[], sprite_rockford_run_right_8[];
extern unsigned char sprite_space[], sprite_dirt[], sprite_boulder[], sprite_preoutbox[];
extern unsigned char sprite_brickwall[], sprite_steelwall[];
extern unsigned char sprite_magicwall_1[], sprite_magicwall_2[], sprite_magicwall_3[], sprite_magicwall_4[];
extern unsigned char sprite_firefly_1[], sprite_firefly_2[], sprite_firefly_3[], sprite_firefly_4[];
extern unsigned char sprite_butterfly_1[], sprite_butterfly_2[], sprite_butterfly_3[], sprite_butterfly_4[], sprite_butterfly_5[], sprite_butterfly_6[], sprite_butterfly_7[], sprite_butterfly_8[];
extern unsigned char sprite_amoeba_1[], sprite_amoeba_2[], sprite_amoeba_3[], sprite_amoeba_4[], sprite_amoeba_5[], sprite_amoeba_6[], sprite_amoeba_7[], sprite_amoeba_8[];
extern unsigned char sprite_diamond_1[], sprite_diamond_2[], sprite_diamond_3[], sprite_diamond_4[], sprite_diamond_5[], sprite_diamond_6[], sprite_diamond_7[], sprite_diamond_8[];
extern unsigned char sprite_explose_to_space_0[], sprite_explose_to_space_1[], sprite_explose_to_space_2[], sprite_explose_to_space_3[], sprite_explose_to_space_4[], sprite_explose_to_space_5[];
extern unsigned char sprite_explose_to_diamond_1[], sprite_explose_to_diamond_2[], sprite_explose_to_diamond_3[], sprite_explose_to_diamond_4[], sprite_explose_to_diamond_5[], sprite_explose_to_diamond_6[];
extern unsigned char musictrack1[], musictrack2[];
extern unsigned char sprite_01[];
extern unsigned char cover0[];
// sprite pointer tables 
unsigned char* SP_ROCKFORD[] = { sprite_rockford,sprite_rockford,sprite_rockford,sprite_rockford,sprite_rockford,sprite_rockford,sprite_rockford,sprite_rockford,
								sprite_rockford_tap_1,sprite_rockford_tap_2,sprite_rockford_tap_1,sprite_rockford_tap_2,sprite_rockford_tap_1,sprite_rockford_tap_2,sprite_rockford_tap_1,sprite_rockford_tap_2,
								sprite_rockford_blink_1,sprite_rockford_blink_2,sprite_rockford_blink_1,sprite_rockford_blink_2,sprite_rockford_blink_1,sprite_rockford_blink_2,sprite_rockford_blink_1,sprite_rockford_blink_2,
								sprite_rockford_blinktap_1,sprite_rockford_blinktap_2,sprite_rockford_blinktap_1,sprite_rockford_blinktap_2,sprite_rockford_blinktap_1,sprite_rockford_blinktap_2,sprite_rockford_blinktap_1,sprite_rockford_blinktap_2,
								sprite_rockford_run_left_1,sprite_rockford_run_left_2,sprite_rockford_run_left_3,sprite_rockford_run_left_4,sprite_rockford_run_left_5,sprite_rockford_run_left_6,sprite_rockford_run_left_7,sprite_rockford_run_left_8,
								sprite_rockford_run_right_1,sprite_rockford_run_right_2,sprite_rockford_run_right_3,sprite_rockford_run_right_4,sprite_rockford_run_right_5,sprite_rockford_run_right_6,sprite_rockford_run_right_7,sprite_rockford_run_right_8 };
unsigned char* SP_DIAMOND[] = { sprite_diamond_1,sprite_diamond_2,sprite_diamond_3,sprite_diamond_4,sprite_diamond_5,sprite_diamond_6,sprite_diamond_7,sprite_diamond_8 };
unsigned char* SP_MAGIC[4] = { sprite_magicwall_1,sprite_magicwall_2,sprite_magicwall_3,sprite_magicwall_4 };
unsigned char* SP_AMOEBA[] = { sprite_amoeba_1,sprite_amoeba_2,sprite_amoeba_3,sprite_amoeba_4,sprite_amoeba_5,sprite_amoeba_6,sprite_amoeba_7,sprite_amoeba_8 };
unsigned char* SP_BUTTERFLY[8] = { sprite_butterfly_1,sprite_butterfly_2,sprite_butterfly_3,sprite_butterfly_4,sprite_butterfly_5,sprite_butterfly_6,sprite_butterfly_7,sprite_butterfly_8 };
unsigned char* SP_FIREFLY[8] = { sprite_firefly_1,sprite_firefly_1,sprite_firefly_2,sprite_firefly_2,sprite_firefly_3,sprite_firefly_3,sprite_firefly_4,sprite_firefly_4 };
unsigned char* SP_EXPLOSE_TO_DIAMOND[] = { sprite_explose_to_diamond_1,sprite_explose_to_diamond_2,sprite_explose_to_diamond_3,sprite_explose_to_diamond_4,sprite_explose_to_diamond_5,sprite_explose_to_diamond_6, };
unsigned char* SP_EXPLOSE_TO_SPACE[] = { sprite_explose_to_space_0,sprite_explose_to_space_1,sprite_explose_to_space_2,sprite_explose_to_space_3,sprite_explose_to_space_4,sprite_explose_to_space_5 };



extern unsigned char rockford_to_xpos[], rockford_to_ypos[];

extern void flashA();
#define flash() flashA()

extern void inverseVideoA();
#define inverseVideo() inverseVideoA()
// data "kind"
#define KIND_OBJECT			0 
#define KIND_LINE			1 
#define KIND_FILLED_RECT	2 
#define KIND_RECT			3

// le compilo multplie par 2 (sizeof (cell))
// cells[22][40] offsets
#define OFFDIR_UP			-40
#define OFFDIR_UPRIGHT		-39
#define OFFDIR_RIGHT		  1
#define OFFDIR_DOWNRIGHT	 41
#define OFFDIR_DOWN			40
#define OFFDIR_DOWN2		80
#define OFFDIR_DOWNLEFT		39
#define OFFDIR_LEFT			-1
#define OFFDIR_UPLEFT		-41
#define OFFDIR_NONE			0

#define DIR_UP			0
#define DIR_UPRIGHT		1
#define DIR_RIGHT		2
#define DIR_DOWNRIGHT	3
#define DIR_DOWN		4
#define DIR_DOWNLEFT	5
#define DIR_LEFT		6
#define DIR_UPLEFT		7
#define DIR_NONE		8

//int OFFDIR2[] ={ -80, 2,  80, -2, }; // 0xffb0,0x0002,0x0050,0xfffe
//unsigned char RANDOM_DIR2[] = { 0, 4, 6, 2 };

unsigned char RANDOM_DIR[] = { DIR_UP, DIR_DOWN, DIR_LEFT, DIR_RIGHT };

char OFFDIR[] = { OFFDIR_UP, OFFDIR_UPRIGHT, OFFDIR_RIGHT, OFFDIR_DOWNRIGHT, OFFDIR_DOWN, OFFDIR_DOWNLEFT, OFFDIR_LEFT, OFFDIR_UPLEFT, OFFDIR_NONE };
unsigned char DIR[] = { DIR_UP   , DIR_UPRIGHT   , DIR_RIGHT   , DIR_DOWNRIGHT   , DIR_DOWN   , DIR_DOWNLEFT   , DIR_LEFT   , DIR_UPLEFT   , DIR_NONE };



extern unsigned char cs_diamond[], cs_diamondfalling[], cs_diamond2[], cs_diamondfalling2[], cs_diamond3[], cs_diamond4[];
extern unsigned char cs_diamondscore[];

// table des codes object <-> sprite
extern unsigned char table[];
// table des codes object <-> propriétés object  (rounded,explodable,consumable...)
extern unsigned char table_mask[];
#define mask_rounded		0x04
#define mask_explodable		0x02
#define mask_consumable		0x01

// asm functions
extern void bdrandomize();
extern void bdrandom1();
//extern void clear_map();
//extern void load_sprite_dataA(unsigned int src,unsigned int dst);
//extern void load_sprite_dataB(unsigned int src,unsigned int dst,unsigned int msk);
extern void load_sprite_dataD(unsigned char* src, unsigned int dst, unsigned int msk);

extern void load_sprite_dataE(unsigned char* src, unsigned int dst, unsigned int msk);





// data structures

typedef struct Cave
{
	char* name;
	char* description;
	unsigned char width;
	unsigned char height;

	unsigned char cavenumber;
	unsigned char magicWallMillingTime;
	unsigned char amoebaSlowGrowthTime;
	unsigned char initialDiamondValue;

	unsigned char extraDiamondValue;
	unsigned char randomSeed;
	unsigned char diamondsNeeded;
	unsigned char caveTime;
	unsigned char color1;
	unsigned char color2;
	unsigned char randomObjects[4];
	unsigned char randomObjectProb[4];
	unsigned char amoebaMaxSize; // = 200 hard coded for a 40x22 cave (based on c64 version)
} Cave;

typedef struct Diamonds
{
	unsigned char collected;
	unsigned char needed;
	unsigned char value;
	unsigned char extra;
	unsigned char currentvalue;
	unsigned char enough;
} Diamonds;

struct Diamonds _diamonds;

typedef struct Amoeba
{
	char slow;
	unsigned char size;
	unsigned char enclosed;
	unsigned char dead;
} Amoeba;

struct Amoeba _amoeba;

typedef struct Magic
{
	unsigned char active;
	int time;
} Magic
;
struct Magic _magic;

typedef struct Idle
{
	unsigned char blink;
	unsigned char tap;
} Idle;

struct Idle _idle;




struct Cell* pdownleft, * pdownright, * pdown, * pleft, * pright, * pup;


typedef struct Game
{
	unsigned int frame;
	unsigned char birth;
	unsigned char timer;
	char index;
	unsigned char fps;
	unsigned char fps4;
	unsigned char fpsmask;
	unsigned char framestep;
	unsigned char frameff;
	unsigned int flash;
	unsigned char won;
	//unsigned char width;	// ==40
	//unsigned char height; // ==22
	unsigned int foundRockford;
	struct Amoeba* amoeba;
	struct Magic* magic;
	struct Diamonds* diamonds;
	struct Idle* idle;
	struct Cave* cave;		// ptr to thecave
	unsigned char temp;
} Game;


typedef struct Cell
{
	unsigned char code;
	unsigned char frame;
} Cell;

typedef struct Moving
{
	unsigned char grab;
	unsigned char dir;
	int diroffset;

} Moving;

#define moving_startUp(m)		m.dir=DIR_UP	;m.diroffset=OFFDIR_UP		; rockford_cycle=ROCKFORD_LEFT_1+cycle8;
#define moving_startDown(m)		m.dir=DIR_DOWN  ;m.diroffset=OFFDIR_DOWN	; rockford_cycle=ROCKFORD_RIGHT_1+cycle8;
#define moving_startLeft(m)		m.dir=DIR_LEFT	;m.diroffset=OFFDIR_LEFT	; rockford_cycle=ROCKFORD_LEFT_1+cycle8;
#define moving_startRight(m)	m.dir=DIR_RIGHT	;m.diroffset=OFFDIR_RIGHT	; rockford_cycle=ROCKFORD_RIGHT_1+cycle8;

#define moving_toggleGrab(m)	m.grab=!m.grab 

#define whereo(m) (m.up ? DIR_UP : (m.down ? DIR_DOWN : (m.left ? DIR_LEFT : (m.right ? DIR_RIGHT : m.dir))))

#define moving_stop(m)			m.dir = DIR_NONE;m.diroffset=OFFDIR_NONE	; rockford_cycle=ROCKFORD_FRONT

//#define moving_stopUp(m)		m.dir = DIR_NONE;m.diroffset=OFFDIR_NONE
//#define moving_stopDown(m)		m.dir = DIR_NONE;m.diroffset=OFFDIR_NONE
//#define moving_stopLeft(m)		m.dir = DIR_NONE;m.diroffset=OFFDIR_NONE
//#define moving_stopRight(m)		m.dir = DIR_NONE;m.diroffset=OFFDIR_NONE



//typedef struct Direction
//{
//	char dX;
//	char dY;
//	char offset;	// precalculate !
//};

/* Cell macros **********************************************************************/

//#define isEmpty(x)			(x->code==OBJECT_SPACE)
#define isEmpty(x)			(!x->code)

#define isRounded(x)		((table_mask[x->code] & mask_rounded))

#define isDirt(x)			(x->code==OBJECT_DIRT)

#define isBoulder(x)		(x->code==OBJECT_BOULDER)
#define isRockford(x)		(x->code==OBJECT_ROCKFORD)
#define isDiamond(x)		(x->code==OBJECT_DIAMOND) 
#define isAmoeba(x)			(x->code==OBJECT_AMOEBA) 
#define isMagic(x)			(x->code==OBJECT_MAGICWALL) 
#define isOutbox(x)			(x->code==OBJECT_OUTBOX) 

#define isEmptyOrDirt(x)		(!(x->code&0xfe))
//#define isRockfordOrAmoeba(x)	(x->code>OBJECT_BUTTERFLY4_STF)
#define isRockfordOrAmoeba(x)	(x->code==0x38 || x->code==0x3a)

#define isButterfly(x)		(x->code>=OBJECT_BUTTERFLY_LEFT && x->code<=OBJECT_BUTTERFLY_DOWN)
#define isExplodable(x)		(table_mask[x->code] & mask_explodable)
#define isConsumable(x)		(table_mask[x->code] & mask_consumable)

#define isFallingBoulder(x)	(x->code==OBJECT_BOULDERFALLING)
#define isFallingDiamond(x)	(x->code==OBJECT_DIAMONDFALLING)



const char* STRING_GAMEOVER = "GAME OVER";
const char* STRING_YOUWIN = "YOU WIN";
const char* STRING_TRYAGAIN = "TRY AGAIN";
const char* STRING_TIMEISUP = "OUT OF TIME";
const char* STRING_NABC = "NOT ANOTHER BOULDER DASH CLONE !";
//                       12345678901234567890123456789012
extern unsigned char randomA();
extern void render_boulderdash_title();

extern void patchcycling();



extern void animateRockfordA();
#define animateRockford() animateRockfordA()

//#define display_boulderdashoric() display_message(STRING_BOULDERDASHORIC)

// 6	FIREFLIES[DIR_LEFT]  = OBJECT_FIREFLY1;
// 0	FIREFLIES[DIR_UP]    = OBJECT_FIREFLY2;
// 2	FIREFLIES[DIR_RIGHT] = OBJECT_FIREFLY3;
// 4	FIREFLIES[DIR_DOWN]  = OBJECT_FIREFLY4;
//unsigned char FIREFLIES[]=
//{	
//	OBJECT_FIREFLY2,
//	0,
//	OBJECT_FIREFLY3,
//	0,
//	OBJECT_FIREFLY4,
//	0,
//	OBJECT_FIREFLY1,
//	0
//};

//	6	BUTTERFLIES[DIR_LEFT]  = OBJECT.BUTTERFLY1;
//	0	BUTTERFLIES[DIR_UP]    = OBJECT.BUTTERFLY2;
//	2	BUTTERFLIES[DIR_RIGHT] = OBJECT.BUTTERFLY3;
//	4	BUTTERFLIES[DIR_DOWN]  = OBJECT.BUTTERFLY4;
//
//unsigned char BUTTERFLIES[]=
//{
//	OBJECT_BUTTERFLY2,
//	0,
//	OBJECT_BUTTERFLY3,
//	0,
//	OBJECT_BUTTERFLY4,
//	0,
//	OBJECT_BUTTERFLY1,
//	0
//};

unsigned char PREROCKFORDS[] =
{
	OBJECT_PREROCKFORD1,
	OBJECT_PREROCKFORD2,
	OBJECT_PREROCKFORD3,
	OBJECT_PREROCKFORD4,
	OBJECT_ROCKFORD
};

unsigned char EXPLODETOSPACE[] =
{
	OBJECT_EXPLODETOSPACE0,
	OBJECT_EXPLODETOSPACE1,
	OBJECT_EXPLODETOSPACE2,
	OBJECT_EXPLODETOSPACE3,
	OBJECT_EXPLODETOSPACE4,
	OBJECT_SPACE
};

//unsigned char EXPLODETODIAMOND[] =
//{
//	OBJECT_EXPLODETODIAMOND0,
//	OBJECT_EXPLODETODIAMOND1,
//	OBJECT_EXPLODETODIAMOND2,
//	OBJECT_EXPLODETODIAMOND3,
//	OBJECT_EXPLODETODIAMOND4,
//	OBJECT_DIAMOND
//};
extern unsigned char EXPLODETODIAMOND[];


#define rotateLeft(dir)		((dir-2) + (dir < 2 ? 8 : 0))
#define rotateRight(dir)	((dir+2) - (dir > 5 ? 8 : 0)) 
#define horizontal(dir)		((dir == DIR_LEFT) || (dir == DIR_RIGHT))
#define vertical(dir)		((dir == DIR_DOWN) || (dir == DIR_UP))

// asm functions 2

#define increaseScore(n) score+=n;render_score()

extern unsigned char decreaseTimerA(unsigned char n);
//#define decreaseTimer(n) decreaseTimerA(n)

extern void autoDecreaseTimerA();
//#define autoDecreaseTimer() autoDecreaseTimerA()

extern void render_timerA();
extern void render_scoreA();
extern void render_diamondsNeededA();
extern void render_diamondsCurrentValueA();
extern void render_diamondsCollectedA();
//extern void render_diamondsExtraA();
extern void render_frameA();

#define render_frame() render_frameA()
#define render_diamondsNeeded() render_diamondsNeededA()
#define render_diamondsCurrentValue() render_diamondsCurrentValueA()
#define render_diamondsCollected() render_diamondsCollectedA()

#define render_score() render_scoreA()
#define render_timer() render_timerA()



extern void setCellA(struct Cell* c, unsigned char o);
//#define setCell(c,o) setCellA(c,o)
#define setCell(c,o)  c->code=o;c->frame=game.frame

extern void clearCellA(struct Cell* c);
//#define clearCell(c) clearCellA(c)
//#define clearCell(c)  c->code=0;c->frame=game.frame
#define clearCell(c) c->code=OBJECT_SPACE


//#define updateExplodeToSpace(p,n)	setCell(p, EXPLODETOSPACE[n])
//#define updateExplodeToDiamond(p,n)	setCell(p, EXPLODETODIAMOND[n])

//extern void updatePreRockfordA(struct Cell *p,unsigned char n);
//#define updatePreRockford(p,n) updatePreRockfordA(p,n) 

//extern unsigned char isEmptyA(struct Cell c);
//#define isEmpty(x) isEmptyA(x)

extern void moveCellA(struct Cell* c1, struct Cell* c2, unsigned char object);
//#define moveCell(c1,c2,object) moveCellA(c1,c2,object)
#define moveCell(c1,c2,o) c2->code=o;c1->code=OBJECT_SPACE;c2->frame=c1->frame=game.frame

//#define updatePreOutbox(x) if (_diamonds.enough) setCell(x,OBJECT_OUTBOX)
#define updatePreOutbox(x) if (_diamonds.enough) x->code=OBJECT_OUTBOX
// 1 chance / 4 ==> oneChanceOn(3)
// 1 chance / 16 ==>oneChanceOn(15) ..etc...

#define oneChanceOn(mask) ((rand() & mask)==0)
#define randomInt(mask) (rand() & mask)


extern unsigned char data_previewcharset[];
extern unsigned char boulderfontA[], boulderfont0[], cs_rockfordlife[], cs_musicnote[], cs_woofer[];
extern unsigned char boulderfont_symbol1[], boulderfont_symbol2[], boulderfont_symbol3[], boulderfont_symbol4[];

#define loadcharset1(c,src,len) memcpy((void*)(0xb400+(c)*8),(void*)(src),len)
#define loadcharset2(c,src,len) memcpy((void*)(0xb800+(c)*8),(void*)(src),len)
//////#define loadcharset3(c,src,len) memcpy((void*)(0x9800+(c)*8),(void*)(src),len)


extern unsigned char unbuff[1120];

int musicindex = 0;

unsigned char converted1[] = {
	0x65, 0x01, 0x1C, 0x01, 0xEE, 0x00, 0xB2, 0x00, 0x3E, 0x01, 0x0C, 0x01,
	0xEE, 0x00, 0x9F, 0x00, 0xE1, 0x00, 0xC8, 0x00, 0xB2, 0x00, 0x96, 0x00,
	0xC8, 0x00, 0x6A, 0x00, 0xBD, 0x00, 0x77, 0x00, 0x65, 0x01, 0xB2, 0x00,
	0xDD, 0x01, 0x3E, 0x01, 0x91, 0x01, 0x9F, 0x00, 0x3E, 0x01, 0x91, 0x01,
	0x65, 0x01, 0xB2, 0x00, 0xDD, 0x01, 0x3E, 0x01, 0xE1, 0x00, 0x59, 0x00,
	0xB2, 0x00, 0xE1, 0x00, 0x91, 0x01, 0xC8, 0x00, 0x18, 0x02, 0x65, 0x01,
	0xFD, 0x00, 0x64, 0x00, 0xC8, 0x00, 0xFD, 0x00, 0xDD, 0x01, 0xBD, 0x00,
	0xA9, 0x01, 0xB2, 0x00, 0x0C, 0x01, 0x0C, 0x01, 0x86, 0x00, 0x0C, 0x01,
	0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00,
	0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00,
	0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00,
	0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00,
	0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00, 0xC8, 0x00, 0xC8, 0x00,
	0xC8, 0x00, 0xC8, 0x00, 0xB2, 0x00, 0x59, 0x00, 0xB2, 0x00, 0x64, 0x00,
	0xB2, 0x00, 0x6A, 0x00, 0xB2, 0x00, 0x77, 0x00, 0xC8, 0x00, 0x64, 0x00,
	0xC8, 0x00, 0x64, 0x00, 0xC8, 0x00, 0x86, 0x00, 0xC8, 0x00, 0x64, 0x00,
	0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00,
	0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00, 0xB2, 0x00,
	0xC8, 0x00, 0xC8, 0x00, 0xC8, 0x00, 0xC8, 0x00, 0x8E, 0x00, 0xB2, 0x00,
	0xEE, 0x00, 0x1C, 0x01, 0x9F, 0x00, 0xC8, 0x00, 0x0C, 0x01, 0x91, 0x01,
	0x8E, 0x00, 0xB2, 0x00, 0xEE, 0x00, 0x1C, 0x01, 0x9F, 0x00, 0xC8, 0x00,
	0x0C, 0x01, 0x91, 0x01
};

unsigned char converted2[] = {
	0xCB, 0x02, 0xDD, 0x01, 0x65, 0x01, 0x2C, 0x01, 0x23, 0x03, 0xA9, 0x01,
	0x91, 0x01, 0x0C, 0x01, 0x85, 0x03, 0x85, 0x03, 0xC2, 0x01, 0x85, 0x03,
	0x91, 0x01, 0x86, 0x00, 0x7B, 0x01, 0x96, 0x00, 0xCB, 0x02, 0xCB, 0x02,
	0xCB, 0x02, 0xCB, 0x02, 0x23, 0x03, 0x23, 0x03, 0x23, 0x03, 0x23, 0x03,
	0xCB, 0x02, 0xCB, 0x02, 0xCB, 0x02, 0xCB, 0x02, 0xC2, 0x01, 0xC2, 0x01,
	0xC2, 0x01, 0xC2, 0x01, 0x23, 0x03, 0x23, 0x03, 0x23, 0x03, 0x23, 0x03,
	0xFA, 0x01, 0xFA, 0x01, 0xFA, 0x01, 0xFA, 0x01, 0xBB, 0x03, 0xEE, 0x00,
	0xBB, 0x03, 0xEE, 0x00, 0x30, 0x04, 0x30, 0x04, 0xCB, 0x02, 0xCB, 0x02,
	0xCB, 0x02, 0xCB, 0x02, 0xCB, 0x02, 0xCB, 0x02, 0x65, 0x01, 0x65, 0x01,
	0xCB, 0x02, 0xCB, 0x02, 0x23, 0x03, 0x23, 0x03, 0x23, 0x03, 0x23, 0x03,
	0x91, 0x01, 0x91, 0x01, 0x23, 0x03, 0x23, 0x03, 0xCB, 0x02, 0x8E, 0x00,
	0xCB, 0x02, 0x86, 0x00, 0x65, 0x01, 0x8E, 0x00, 0xCB, 0x02, 0x86, 0x00,
	0x23, 0x03, 0x8E, 0x00, 0x23, 0x03, 0x86, 0x00, 0x91, 0x01, 0x9F, 0x00,
	0x23, 0x03, 0x96, 0x00, 0xCB, 0x02, 0xCB, 0x02, 0xCB, 0x02, 0x77, 0x00,
	0x65, 0x01, 0x65, 0x01, 0xCB, 0x02, 0x96, 0x00, 0x23, 0x03, 0x23, 0x03,
	0x23, 0x03, 0x23, 0x03, 0x91, 0x01, 0x91, 0x01, 0x23, 0x03, 0x23, 0x03,
	0xCB, 0x02, 0x8E, 0x00, 0xCB, 0x02, 0x86, 0x00, 0x65, 0x01, 0x8E, 0x00,
	0xCB, 0x02, 0x86, 0x00, 0x23, 0x03, 0x8E, 0x00, 0x23, 0x03, 0x86, 0x00,
	0x91, 0x01, 0x9F, 0x00, 0x23, 0x03, 0x96, 0x00, 0xB2, 0x00, 0xEE, 0x00,
	0x1C, 0x01, 0x65, 0x01, 0xC8, 0x00, 0x0C, 0x01, 0x3E, 0x01, 0x23, 0x03,
	0x77, 0x00, 0x8E, 0x00, 0xB2, 0x00, 0xEE, 0x00, 0x0C, 0x01, 0x3E, 0x01,
	0x91, 0x01, 0x23, 0x03
};

unsigned char CHANNELS = 7;
unsigned int PERIOD = 1;
unsigned char NOIZE = 0;
unsigned char ENVEL = 1;
unsigned int ENVLEN = 10;
extern char title_color[];
int z = 0xd0;
unsigned char SOUND_ACTIVE = TRUE;
unsigned char MUSIC_ACTIVE = TRUE;

//extern int scanf(const char *format,...);

extern void addchain(void  irqhandler());
extern void addIrq();
extern void removeIrq();
extern void uncoverA();
extern void* memset(void* buffer, int c, int count);
extern void cyclingcolors();

extern void display_hof_frame();

extern void playchannels();
extern void play_musicB();

// PARAMETERS

int difficulty = 0;//0-4
int speed = 255;///1-255
int wait1 = 1;///255-1

int lifes;

#define DEFAULT_TEMPO 4
#define DEFAULT_BEAT 7
#define DEFAULT_MUSICLEVEL 7
#define DEFAULT_FPS 15
#define DEFAULT_306 0x2000


int beat = 0;
int tempo = DEFAULT_TEMPO;
int tempovalue = DEFAULT_TEMPO;
int tempobase = DEFAULT_TEMPO;
int beatmax = DEFAULT_BEAT;
int musiclevel = DEFAULT_MUSICLEVEL;
unsigned int reg306 = DEFAULT_306;

unsigned char steelok = FALSE;

// CHEATS

unsigned char infinite_time = TRUE;
unsigned char infinite_lifes = TRUE;
unsigned char god_mode = FALSE;
unsigned char wall_pass = FALSE;

extern void aWaitKey(unsigned char n);
extern void nextGame();
extern void prevGame();
extern void newGame();
extern void clores();

extern void ask_yes_or_no();
extern void choose_nextcolor();
extern void choose_samecolor();

extern unsigned char fmod(unsigned int x, unsigned char y);


unsigned char AMOEBA_SOUND_ENABLED = FALSE;
unsigned char MAGIC_SOUND_ENABLED = FALSE;

extern void soundrandom3();
extern unsigned char VOLUM;