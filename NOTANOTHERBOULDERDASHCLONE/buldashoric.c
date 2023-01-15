
//#include <lib.h>
//#include <stdio.h>
#include "buldashoric.h"

// globals

// cycles 
unsigned int rockford_cycle;	// 20

unsigned char render;
unsigned char rockfordX, rockfordY;

unsigned char cycle2;
unsigned char cycle4;
unsigned char cycle8;


unsigned char explosespace_cycle, explosediamond_cycle;

int i, j;
unsigned int score;


extern unsigned int hiscores[];
extern char* hinames[];
//
struct Cell* cell_rockford_p2;

unsigned int index_music;
//
struct Cell* cell_rockford;


// randomizer seeds
unsigned char xseeds[2];

// offsets x,y


// position map x,y
int current_xpos, current_ypos;

unsigned char* cavedata;

unsigned char objectfalling, objectfrom, objectto;
unsigned char dir, o_Ldir, o_Rdir;

int OFF_NEWDIR, OFF_DIR;

struct Cell cells[CAVE_HEIGHT][CAVE_WIDTH];
struct Cell* p;
//struct Cave thecave;
struct Game game;
struct Moving moving;

const char ldx[8] = { 0,  1, 1, 1, 0, -1, -1, -1 };
const char ldy[8] = { -1, -1, 0, 1, 1,  1,  0, -1 };

// todo optimize decode cave, struct cave, affichage cave en texte
char buf[40];

void printNumber(char x, char y, char* format, int number)
{
	gotoxy(x, y);
	printf(format, number);
}

void cursor_off()
{
	gotoxy(0, 0);
	poke(0x26a, 10);
}

void printAt(char x, char y, char* s)
{
	gotoxy(x, y);
	printf(s);
}

void drawLine(unsigned char anObject, unsigned char x, unsigned char y, unsigned char aLength, unsigned char aDirection)
{
	int counter;
	int counter1;
	int counter2;
	for (counter = 0; counter < aLength; counter++) {
		cells[y][x].code = anObject;
		x += ldx[aDirection];
		y += ldy[aDirection];
	}
}

void drawFilledRect(unsigned char object, unsigned char x, unsigned char y, unsigned char w, unsigned char h, unsigned char fillObject)
{
	int counter1;
	int counter2;
	for (counter1 = 0; counter1 < w; counter1++) {
		for (counter2 = 0; counter2 < h; counter2++) {
			if ((counter2 == 0) || (counter2 == h - 1) || (counter1 == 0) || (counter1 == w - 1)) {
				cells[y + counter2][x + counter1].code = object;
			}
			else {
				cells[y + counter2][x + counter1].code = fillObject;
			}
		}
		cells[y][x + counter1].code = object;
		cells[y + h - 1][x + counter1].code = object;
	}
}

void drawRect(unsigned char object, unsigned char x, unsigned char y, unsigned char w, unsigned char h)
{
	int counter1;
	int counter2;
	for (counter1 = 0; counter1 < w; counter1++) {
		cells[y][x + counter1].code = object;
		cells[y + h - 1][x + counter1].code = object;
	}
	for (counter1 = 0; counter1 < h; counter1++) {
		cells[y + counter1][x].code = object;
		cells[y + counter1][x + w - 1].code = object;
	}
}

void printcenter(unsigned char y, int color, unsigned char c2, const char* s, unsigned char iflag)
{
	unsigned char x = 19 - strlen(s) / 2;
	unsigned char* dest = (unsigned char*)(0xbb80 + y * 40 + x);

	*dest++ = color;
	while (*s)
	{
		*dest++ = (*s++) + iflag;
	}

	*dest = c2;
}

void loadcs1()
{
	loadcharset1('*', cs_diamondscore, 16);
	loadcharset1('0', boulderfont0, 43 * 8);
	loadcharset1('a', boulderfont0 + 17 * 8, 26 * 8);

	loadcharset1('!', boulderfont_symbol1, 8);
	loadcharset1(',', boulderfont_symbol2, 8);
	loadcharset1('.', boulderfont_symbol3, 8);
}

void loadcs2()
{
	loadcharset2('0', boulderfont0, 43 * 8);
	//loadcharset2('a',boulderfont0+17*8,26*8);
	loadcharset2('!', boulderfont_symbol1, 8);
	loadcharset2(',', boulderfont_symbol2, 8);
	loadcharset2('.', boulderfont_symbol3, 8);
	loadcharset2('\'', boulderfont_symbol4, 8);
	loadcharset2('=', cs_rockfordlife, 8);
	loadcharset2('/', cs_musicnote, 8);
	loadcharset2(';', cs_woofer, 8);
}

//void FLUSHIN()
//{
//	while (peek(0x208)!=56)
//	{
//
//	}
//}
extern void FLUSHIN();
extern unsigned char GETCHAR();
//unsigned char GETCHAR()
//{
//	char c=0;
//	FLUSHIN();
//	while ((c=peek(0x208))==56);
//	return c;
//}


extern void colorfxA();

void intro_music(unsigned char cycle, int temp, unsigned char oper, unsigned char colorfx)
{
	FLUSHIN();
	removeIrq();
	CHANNELS = 3; ENVEL = 0; ENVLEN = 0; NOIZE = 0;
	tempovalue = tempo = temp;

	beat = 0;
	poke((unsigned int)playchannels + 11, oper);
	if (MUSIC_ACTIVE)
		addchain(play_musicB);
	if (cycle)
		addchain(cyclingcolors);
	if (colorfx)
		addchain(colorfxA);
	if (MUSIC_ACTIVE || cycle || colorfx)
		addIrq();

}



void render_lifes()
{
	int n, k;
	if (lifes > 3)
		n = 4;
	else
		n = lifes;

	for (k = 0; k < 4; k++)
		poke(0xbb81 + k, 32);
	for (k = 0; k < n; k++)
		poke(0xbb81 + 3 - k, '=');
	if (lifes > 4)
		poke(0xbb81, '=' + 128);

}

extern void sprintf(char buf[], const char* format, ...);

void init_stats()
{


	//	loadcharset2(' ',Font_6x8_FuturaFull,512);
	loadcharset2('*', cs_diamondscore, 16);
	//loadcharset2('0',boulderfont0,80);
	//loadcharset2('A',boulderfontA,26*8);
	//loadcharset2('!',boulderfont_symbol1,8);
	//loadcharset2(',',boulderfont_symbol2,8);
	//loadcharset2('.',boulderfont_symbol3,8);
	//clear_line0();

	poke(0xbb80, A_ALT);
	//					 0000000000111111111122222222223333333333
	//                   0123456789012345678901234567890123456789  
	//gotoxy(1,0) ; printf("     00 *+00    00     000    000000 /;");
	printAt(1, 0, "     00 *+00    00     000    000000 /;");

	poke(0xbb80 + 27 * 40 + 1, 0);
	poke(0xbb80 + 37, 2);


	if (SOUND_ACTIVE)
		poke(0xbb80 + 39, ';');
	else
		poke(0xbb80 + 39, ';' + 128);

	if (MUSIC_ACTIVE)
		poke(0xbb80 + 38, '/');
	else
		poke(0xbb80 + 38, '/' + 128);

	//NAMES[game.index]
	memset(buf, 0, 40);

	sprintf(buf, "%c%d%c%s%c%d%c", 2, game.index, 3, NAMES[game.index], 2, difficulty, 0);
	printcenter(27, 3, 1, buf, 0);

	//gotoxy(2,27);
	//printf("GRAB");
	poke(0xbb80 + 27 * 40 + 2, 'G');
	poke(0xbb80 + 27 * 40 + 3, 'R');
	poke(0xbb80 + 27 * 40 + 4, 'A');
	poke(0xbb80 + 27 * 40 + 5, 'B');

	poke(0xbb80 + 4, A_FWYELLOW);
	poke(0xbb80 + 7, A_FWWHITE);
	poke(0xbb80 + 15, A_FWYELLOW);
	poke(0xbb80 + 12, A_FWWHITE);

	poke(BB804027, A_ALT);

	//FRAME#
	poke(0xbb80 + 40 * 27 + 34, A_FWGREEN);
	poke(0xbb80 + 22, 7);

	render_score();
	render_diamondsNeeded();
	render_diamondsCollected();
	render_diamondsCurrentValue();
	render_frame();
	render_timer();
	render_lifes();
}

extern void aWaitKey(unsigned char n);

void intro_level()
{
	unsigned int dest = 0xbb80;

	loadcs2();

	for (j = 0; j < 2; j++)
	{
		poke(dest++, A_FWBLUE);
		poke(dest, A_ALT2H);
		dest += 39;

		/*	gotoxy(2,j);printf("CAVE %d ",cavedata[0] );
		printcenter(j,A_FWCYAN+j,A_FWWHITE,NAMES[game.index]);*/
	}

	dest = BB804024;
	for (j = 24; j < 27; j++)
	{
		poke(dest++, A_FWMAGENTA);
		poke(dest, A_ALT);
		dest += 39;
	}


	poke(BB80402701, A_ALT);
	//                   01234567890123456789012345678901234567890

	//gotoxy(2,24);printf(DESCRIPTIONS[game.index]);
	printAt(2, 24, DESCRIPTIONS[game.index]);
	init_stats();

	FLUSHIN();
	//for (i=0;i<16;i++)
	//{
	//	if (peek(0x208)!=56)
	//		break;
	//	aWait(32);
	//}
	aWaitKey(0);
}





// RENDER ///////////////////////////////////////////////////////////////////////////////// 

// 0 : cave number
// 1 : magicwallmillingtime
// 1 : amoebaslowgrowthtime
// 2 : initialdiamondvalue
// 3 : extradiamondvalue
// 4-8 : randomseed (+difficulty)
// 9-d : diamondsneeded 
// e-12: time
//thecave.color1 13];
//thecave.color2 14];
//thecave.randomObjects[0]=cavedata[0x18];
//thecave.randomObjects[1]=cavedata[0x19];
//thecave.randomObjects[2]=cavedata[0x1a];
//thecave.randomObjects[3]=cavedata[0x1b];
//thecave.randomObjectProb[0]=cavedata[0x1c];
//thecave.randomObjectProb[1]=cavedata[0x1d];
//thecave.randomObjectProb[2]=cavedata[0x1e];
//thecave.randomObjectProb[3]=cavedata[0x1f];
//thecave.amoebaMaxSize=200;


//TODO:finish&test !!!!!!!!!!!!!!!!!
//extern void decodeCaveA();
//#define decodeCave() decodeCaveA()

void decodeCave()
{
	int j;
	//int n;
	unsigned char kind;
	unsigned char object;
	struct Cell* cell = (struct Cell*) cells;
	unsigned char* pcd, * pcd2;

	//	clrscr();
	pcd = cavedata = DT[game.index];

	//thecave.name=NAMES[game.index];
	//thecave.description=DESCRIPTIONS[game.index];
	//thecave.width=40;
	//thecave.height=22;
	//thecave.cavenumber=cavedata[0];
	//	thecave.magicWallMillingTime=cavedata[1];
	//	thecave.amoebaSlowGrowthTime=cavedata[1];// same as magicWallMillingTime
	//	thecave.initialDiamondValue=cavedata[2];
	//	thecave.extraDiamondValue=cavedata[3];
	//thecave.randomSeed=cavedata[4];// at other difficulty levels: cave[0x05], cave[0x06], cave[0x07], cave[0x08]],
	//thecave.diamondsNeeded=cavedata[9];// at other difficulty levels: cave[0x0A], cave[0x0B], cave[0x0C], cave[0x0D]],
	//thecave.caveTime=cave[0x0E], // at other difficulty levels: cave[0x0F], cave[0x10], cave[0x11], cave[0x12]],
	//thecave.color1=cavedata[0x13];
	//thecave.color2=cavedata[0x14];
	//thecave.randomObjects[0]=cavedata[0x18];
	//thecave.randomObjects[1]=cavedata[0x19];
	//thecave.randomObjects[2]=cavedata[0x1a];
	//thecave.randomObjects[3]=cavedata[0x1b];
	//thecave.randomObjectProb[0]=cavedata[0x1c];
	//thecave.randomObjectProb[1]=cavedata[0x1d];
	//thecave.randomObjectProb[2]=cavedata[0x1e];
	//thecave.randomObjectProb[3]=cavedata[0x1f];
	//thecave.amoebaMaxSize=200;
	// 20---xxx fixed objects
	//


	xseeds[0] = 0;
	pcd = cavedata + 4 + difficulty;
	xseeds[1] = *pcd;//cavedata[4+difficulty];

	//// clear_map();

	for (cell += 40, j = 40; j < CAVE_SIZE - 40; j++, cell++)
	{
		object = OBJECT_DIRT;

		bdrandom1();

		pcd = cavedata + 0x1c + 3;
		pcd2 = cavedata + 0x18 + 3;


		if (*xseeds < *pcd)
		{
			object = *pcd2;
		}
		else
		{
			pcd--;
			pcd2--;
			if (*xseeds < *pcd)
			{
				object = *pcd2;
			}
			else
			{
				pcd--;
				pcd2--;
				if (*xseeds < *pcd)
				{
					object = *pcd2;
				}
				else
				{
					pcd--;
					pcd2--;
					if (*xseeds < *pcd)
					{
						object = *pcd2;
					}
				}
			}
		}


		cell->code = object;
		cell->frame = 0;

	}

	drawRect(OBJECT_STEELWALL, 0, 0, CAVE_WIDTH, CAVE_HEIGHT);

	pcd = cavedata + 0x20;

	while (*pcd != TERMINATOR) {
		object = (*pcd & 0x3F);       //  low 6 bits
		kind = (*pcd & 0xC0) >> 6;  // high 2 bits
		;
		pcd++;
		i = *pcd++;
		j = *pcd++ - 2; //   top 2 lines are for displaying scores

		switch (kind) {
		case KIND_OBJECT:
			if (i > CAVE_WIDTH || j > CAVE_HEIGHT || i < 0 || j < 0)
			{
				ping();
				printf("error");
				getchar();
				break;
			}
			else
			{
				printf("ok");
				cells[j][i].code = object;
			}
			break;
		case KIND_LINE:
			drawLine(object, i, j, *pcd++, *pcd++);
			break;
		case KIND_FILLED_RECT:
			drawFilledRect(object, i, j, *pcd++, *pcd++, *pcd++);
			break;
		case KIND_RECT:
			drawRect(object, i, j, *pcd++, *pcd++);
			break;
		default:
			break;
		}

	}


}

/*	xoff=0
ABC GHI ... MNO STU
DEF JKL ... PQR VWX
xoff=1
.	BC GHI ... MNO STU .
.	EF JKL ... PQR VWX .
xoff=2
..	C GHI ... MNO STU ..
..	F JKL ... PQR VWX ..
*/
// cycled !
//void initSpritePointerTables()
//{
//	int i,j;
//
//
//	//for (i=0,j=0;i<8;i++,j+=48)
//	//{
//	//	// 0 -> 7 = sprite_rockford
//	//	SP_ROCKFORD[0+i]=(unsigned int)sprite_rockford;
//
//	//	// 8 -> 15 = sprite_rockford_tap_1+j
//	//	SP_ROCKFORD[8+i]=(unsigned int)sprite_rockford_tap_1+(j % 96);
//
//	//	// 16 -> 23= sprite_rockford_blink_1+j
//	//	SP_ROCKFORD[16+i]=(unsigned int)sprite_rockford_blink_1+(j % 96);
//
//	//	// 24 -> 31
//	//	SP_ROCKFORD[24+i]=(unsigned int)sprite_rockford_blinktap_1+(j % 96);
//	//}
//
//
//
//	for (i=0,j=0;i<8;i++,j+=48)
//	{
//		//SP_ROCKFORD[32+i]=(unsigned int)sprite_rockford_run_left_1+j;
//	//	SP_ROCKFORD[40+i]=(unsigned int)sprite_rockford_run_right_1+j;
//
//		SP_DIAMOND[i]=	(unsigned int)sprite_diamond_1+j;
//		SP_AMOEBA[i] =	(unsigned int)sprite_amoeba_1+j;
//		SP_BUTTERFLY[i]=(unsigned int)sprite_butterfly_1+j;
//	}
//
//	for (i=0,j=0;i<4;i++,j+=48)
//	{
//		SP_FIREFLY[2*i]=SP_FIREFLY[2*i+1]=	(unsigned int)sprite_firefly_1+j; 
//		SP_MAGIC[i]=j+(unsigned int)sprite_magicwall_1;
//	}
//
//	for (i=0,j=0;i<6;i++,j+=48)
//	{
//		SP_EXPLOSE_TO_DIAMOND[i]=(unsigned int)sprite_explose_to_diamond_1+j;
//		SP_EXPLOSE_TO_SPACE[i]=(unsigned int)sprite_explose_to_space_0+j;
//		//	SP_EXPLOSE_TO_SPACE[i]=(unsigned int)sprite_01+j;
//	}
//
//}


//void choose_nextcolor()
//{
//	color++;
//	if (color>7) color = 1;
//	
//	if (render!=RENDER_ASCII)
//	{
//		for (i=1;i<27;i++) {
//			poke(0xbb80+i*40,color);
//		}
//	}
//
//}

void init_render()
{
	int val0, val255;

	cycle2 = cycle4 = cycle8 = 0;
	explosespace_cycle = explosediamond_cycle = 6;

	// 0xb400 -> 0xb6ff		= 768

	val255 = inversecharset ? 0 : 255;
	val0 = inversecharset ? 255 : 0;
	load_sprite_dataD(sprite_dirt, P_DIRT, val0);
	load_sprite_dataD(sprite_brickwall, P_BRICK, val255);
	load_sprite_dataD(sprite_boulder, P_BOULDER, val0);
	load_sprite_dataD(sprite_steelwall, P_STEEL, val255);
	load_sprite_dataD(sprite_brickwall, P_MAGIC, val255);;
	load_sprite_dataD(sprite_steelwall, P_PREOUTBOX, val255);
	load_sprite_dataD(sprite_space, P_SPACE, val0);
	load_sprite_dataD(sprite_rockford, P_ROCKFORD, val0);
	load_sprite_dataD(sprite_butterfly_1, P_BUTTERFLY, val0);
	load_sprite_dataD(sprite_firefly_1, P_FIREFLY, val0);
	load_sprite_dataD(sprite_amoeba_1, P_AMOEBA, val0);
	load_sprite_dataD(sprite_explose_to_space_0, P_EXPLOSE_TO_SPACE, val255);
	load_sprite_dataD(sprite_explose_to_diamond_1, P_EXPLOSE_TO_DIAMOND, val0);

	clrscr(32);

}


extern void disablemusic();

//{
//	if (MUSIC_ACTIVE)
//	{
//		MUSIC_ACTIVE=FALSE;
//		removeIrq();
//		poke(0xbb80+38,'/'+128);
//	}	
//}

extern void playfx();
//void playfx()
//{
//	CHANNELS|=4;
//	play(CHANNELS,NOIZE,ENVEL,ENVLEN);
//}

//void sounduncover()
//{
//	if (!SOUND_ACTIVE) return;
//	PERIOD=18+(randomA()&23);
//	NOIZE=0;ENVEL=1;ENVLEN=15;CHANNELS=4;
//	playfx();
//}

extern void soundMovingA();
#define soundmoving() soundMovingA()

//void soundmoving()
//{
//	if (!SOUND_ACTIVE) return;
//	PERIOD=24;
//	NOIZE=4;ENVEL=1;ENVLEN=20;
//	playfx();
//}

extern void soundMovingEmptyA();
#define soundmovingempty() soundMovingEmptyA()

//void soundmovingempty()
//{
//	if (!SOUND_ACTIVE) return;
//	PERIOD=75;
//	NOIZE=4;ENVEL=1;ENVLEN=20;
//	playfx();
//}

extern void soundBoulderA();
#define soundboulder()  soundBoulderA()

//void soundboulder()
//{
//	if (!SOUND_ACTIVE) return;
//	PERIOD=870;
//	NOIZE=4;ENVEL=1;ENVLEN=60;
//	playfx();
//}

//void soundcrack()
//{
//	if (!SOUND_ACTIVE) return;
//	PERIOD=170;
//	NOIZE=0;ENVEL=1;ENVLEN=1000;
//	playfx();
//}

extern void soundExplosionA();
#define soundexplosion() soundExplosionA()

//void soundexplosion()
//{
//	if (!SOUND_ACTIVE) return;
//	PERIOD=400;
//	NOIZE=4;ENVEL=1;ENVLEN=300;
//	playfx();
//}

unsigned int freq2period(unsigned int f)
{
	// P = 1000000/(16 * F) => P = 62500/f
	return 62500 / f;
}

void soundbonuspoints()
{
	unsigned int f, period;
	int x;
	z--;

	NOIZE = 0; ENVEL = 1; ENVLEN = 15;

	for (x = 32; x > 0; x--)
	{
		f = 1 + (z - x) << 2;
		PERIOD = freq2period(f);
		playfx();
		//sound(3,period,0);
		//play(CHANNELS,0,1,75);
	}
}


extern void soundAmoebaA();
#define soundamoeba() soundAmoebaA()
//
//void soundamoeba()
//{
//	if (!SOUND_ACTIVE) return;
//	disablemusic();
//	PERIOD= 256+randomA();
//	CHANNELS=4;NOIZE=0;ENVEL=1;ENVLEN=100;
//	playfx();
//}
extern void soundMagicA();
#define soundmagic() soundMagicA()
//void soundmagic()
//{
//	if (!SOUND_ACTIVE) return;
//	disablemusic();
//	PERIOD= 0x40+(randomA()&0x3f);
//	CHANNELS=4;NOIZE=0;ENVEL=1;ENVLEN=100;
//	playfx();
//}

void sounddiamond()
{
	unsigned int freq;
	if (!SOUND_ACTIVE) return;
	freq = randomA();
	freq |= 0x86;
	freq &= 0xfe;
	freq <<= 8;
	freq |= randomA();
	PERIOD = freq2period(freq);
	NOIZE = 0;	ENVEL = 1;	ENVLEN = 60;
	playfx();
}

extern void soundPickedDiamondA();
#define soundpickeddiamond() soundPickedDiamondA()
//void soundpickeddiamond()
//{
//	if (!SOUND_ACTIVE) return;
//	PERIOD=196;
//	NOIZE=0;	ENVEL=1;	ENVLEN=70;
//	playfx();
//}

// recursive !!!

void explodeCell(struct Cell* p2)
{
	unsigned char dir;
	struct Cell* p2dir;
	unsigned char explosion;

	soundexplosion();

	if (game.won)
	{
		setCell(p2, OBJECT_EXPLODETOSPACE0);
		game.won = FALSE;
		return;
	}

	//if (isButterfly(p2))
	//	explosion= OBJECT_EXPLODETODIAMOND0;
	//else
	//	explosion= OBJECT_EXPLODETOSPACE0;

	explosion = isButterfly(p2) ? OBJECT_EXPLODETODIAMOND0 : OBJECT_EXPLODETOSPACE0;

	setCell(p2, explosion);

	for (dir = 0; dir < 8; dir++)
	{
		// for each of the 8 directions

		p2dir = p2 + OFFDIR[dir];

		if (isExplodable(p2dir))
		{
			explodeCell(p2dir);
		}
		else if (isConsumable(p2dir))
		{
			setCell(p2dir, explosion);
		}
	}
}

extern void collectDiamond();

//void collectDiamond() 
//{
//	_diamonds.collected++;
//	render_diamondsCollected();
//	soundpickeddiamond();
//	increaseScore(_diamonds.currentvalue);
//
//	if (!_diamonds.enough)
//		if (_diamonds.collected>=_diamonds.needed)
//		{
//			_diamonds.enough=TRUE;
//			_diamonds.currentvalue=_diamonds.extra;
//			render_diamondsCurrentValue();
//			poke(0xbb80+15,2);
//			poke(0xbb80+7,6);
//			poke(0xbb80+14,13);
//			poke(0xbb80+20,9);
//		}
//}

extern void pushCellRockfordA();
#define pushCellRockford() pushCellRockfordA()



//void apushCellRockford() 
//{  
//	struct Cell *p3 = cell_rockford_p2+moving.diroffset;
//	
//	if (isEmpty(p3))
//	{
//		if (oneChanceOn(3)) 
//		{
//			moveCell(cell_rockford_p2,p3,OBJECT_BOULDER);
//
//		 	SOUND_MOVING();
//
//			if (!moving.grab)
//			{
//				//cell_rockford_p2->code=OBJECT_ROCKFORD;
//				//cell_rockford_p2->frame=game.frame;
//				//clearCell(cell_rockford);
//				moveCell(cell_rockford,cell_rockford_p2,OBJECT_ROCKFORD);	
//				///cell_rockford=cell_rockford_p2;
//			}
//		}
//	}
//}
extern void searchrockfordA();
//
//void searchrockford()
//{
//	int x,y;
//	Cell *c= &cells[1][1];
//	
//	for (y=1;y<22;y++)
//	{
//		 
//		for (x=1;x<39;x++)
//		{
//			if ((*c++).code==OBJECT_PREROCKFORD1)
//			{
//				current_xpos=rockford_to_xpos[x];
//				current_ypos=rockford_to_ypos[y];
//				return;
//			}
//		}
//		c+=2;
//	}
//}

extern void patchDrawMapDirectA(unsigned int addr);

void uncover()
{
	/*int x,y,c;*/
	//unsigned int offset ;
	removeIrq();
	patchDrawMapDirectA((unsigned int)unbuff + 41);
	//poke ((unsigned int)drawMapDirectA+0x33,  (address & 0xff)   );
	//poke ((unsigned int)drawMapDirectA+0x37, (( address & 0xff00)>>8));

	//searchrockford();
	searchrockfordA();
	//cls();
	//printf("x=%d, y=%d\n",current_xpos,current_ypos);
	//ping();
	//GETCHAR();

	//searchrockfordA();
	//printf("x=%d, y=%d\n",current_xpos,current_ypos);
	//ping();
	//GETCHAR();

	drawMapDirectA();

	//poke ((unsigned int)drawMapDirectA+0x33,0xa9);
	//poke ((unsigned int)drawMapDirectA+0x37,0xbb);

	patchDrawMapDirectA(0xbba9);

	//for (i=1;i<40;i++)
	//	for (j=1;j<27;j++)
	//	{
	//		poke(0xbb80+i+j*40,'v'+128);
	//	}
	//for (i=1;i<27;i++)
	//	memset((void *)(0xbb81+i*40),32,39);

	loadcharset1('z', cover0, 8);
	memset((void*)(0xbb80 + 40), 'z' + 128, 26 * 40);

	choose_nextcolor();

	uncoverA();


	/*	for (i=0;i<160;i++)
	{
	sounduncover();
	loadcharset1(' ',cover0+(i%8)*8,8);
	if (i%4==0)
	{
	animates();
	}

	for (y=1;y<27;y++)
	{
	x=randomA()%39+1;
	offset=x+y*40;
	poke(0xbb80+offset,unbuff[offset]);
	}
	} */
	//loadcharset1(' ',sprite_space,8);
}

void resetGame()
{
	unsigned char* cell = (unsigned char*)cells;
	z = 0xd0;

	doke(0x306, reg306);

	play0000();
	//  gotoxy(0,0);  

	steelok = FALSE;

	current_xpos = 0;
	current_ypos = 0;
	moving.dir = DIR_NONE;
	moving.grab = FALSE;

	rockford_cycle = ROCKFORD_FRONT;

	//////game.index  =  n;						   

	decodeCave();

	game.amoeba = &_amoeba;
	game.idle = &_idle;
	game.magic = &_magic;
	game.diamonds = &_diamonds;

	clrscr(32);
	MAGIC_SOUND_ENABLED = AMOEBA_SOUND_ENABLED = FALSE;


	cavedata[0] = game.index + 1;

	//game.width    = 40;					 
	//game.height   = 22;					  

	game.frame = 0;
	game.foundRockford = 0;

	game.fps4 = 1 * game.fps;

	game.birth = game.fps;

	game.timer = cavedata[0x0e + difficulty];

	_idle.blink = _idle.tap = game.flash = game.won = FALSE;

	_diamonds.collected = 0;

	_diamonds.needed = cavedata[9];
	_diamonds.currentvalue = _diamonds.value = cavedata[2];
	_diamonds.extra = cavedata[3];
	_diamonds.enough = FALSE;
	//game.amoeba.max=200;

	_amoeba.slow = cavedata[1];

	_magic.time = _amoeba.slow;
	_magic.time *= game.fps;

	_magic.active = FALSE;

	//	   0000000000111111111122222222223333333333
	//	     0123456789012345678901234567890123456789

	_amoeba.dead = FALSE;

	loadcharset1('A', data_previewcharset, 512);

	render_level_ascii();

	intro_level();

	init_render();

	init_stats();

	if (render == RENDER_ASCII)
	{
		memset((void*)(0xbb80 + 40), 32, 26 * 40);
		loadcharset1('A', data_previewcharset, 512);
	}
	else
	{
		uncover();
	}
	CHANNELS &= 3; NOIZE = 0; ENVEL = 0; ENVLEN = 0;
}

//void newGame()
//{
//	score=0;
//	lifes=3;
//
//	//srand(peek(0x274));
//	poke((unsigned int)randomA+1,peek(0x274));
//	game.index  = randomA()&15;
//	resetGame();
//}

//void prevGame()
//{
//	game.index--;
//
//	if (game.index<0)
//		game.index=19;
//	resetGame();
//}

//void nextGame()
//{
//	game.index++;
//	if (game.index>19)
//		game.index=0;
//	resetGame();
//}

//void autoDecreaseTimer()
//{
//	if (game.frame > game.birth)
//	{
//		game.timer--;
//		render_timer(); 
//	}
//
//}

extern void autoDecreaseTimer();





// void clores();

//{
//	const int maxi=8*17;
//	unsigned char *dest=(unsigned char*)0xa002; 
//
//	for (i=0;i<maxi;i++)
//	{
//		*dest++=title_color[i%8];    
//		*dest=26 ;	// text
//		dest+=39;
//	}
//
//	dest=(unsigned char*)0xBB81;
//	for (i=0;i<maxi/8;i++)
//	{
//		*dest=31;   // hires 
//		dest+=40;
//	}
//
//}

int ligne; int  max; int mul; int off;

int saisiemagique(int  val, char* s)
{
	unsigned char c;
	int addr;
	int li40;
	val -= off;
	val /= mul;
	//gotoxy(2,ligne);printf(s);
	//gotoxy(15,ligne);printf(":");
	//gotoxy(17,ligne);

	printAt(2, ligne, s);
	printAt(15, ligne, ":");

	li40 = ligne * 40;

	for (i = 0; i < max; i++)
		printAt(17 + i, ligne, "*");

	printAt(17 + max, ligne, "*+");




	while (1)
	{
		addr = 0xbb80;
		addr += ligne * 40;
		addr += val + 17;

		poke(addr, peek(addr) | 128);


		printNumber(34, ligne, "%d   ", val * mul + off);

		c = peek(0x208);
		switch (c)
		{
		case 172:// left
			val--;
			if (val < 0) val = 0;
			poke(addr, peek(addr) & 127);
			soundmovingempty();
			break;
		case 188: //right
			val++;
			if (val > max) val = max;
			poke(addr, peek(addr) & 127);
			soundmoving();
			break;
		case 175: // return
			printNumber(34, ligne, "%d   ", val * mul + off);
			soundmoving();
			ligne++;
			FLUSHIN();
			aWait(30);
			return val * mul + off;

		default:
			break;
		}

		aWait(30);

	}

}
extern void render_instructions();
unsigned char c;
extern void resetDefParams();

void menu_parameters()
{
	unsigned  char* s; int fps;
	removeIrq();

	doke(0x306, 0x2000);

	while (1)
	{
		clrscr(9);
		loadcs2();
		ink(3);
		//	for (i=0;i<28;i++) poke(0xbb80+i*40,9);
		printcenter(0, 6, 5, STRING_NABC, 0);
		/*	printcenter(1,4,1," ***+INSTRUCTIONS ***+",0);

		gotoxy(2,2);
		printf("ARROWS QA<>     : MOVE\nSPACE           : TOGGLE GRAB\nFUNC SHIFT CTRL : GRAB\n");
		printf("ESCAPE          : RESTART LEVEL\nENTER           : NEXT LEVEL\nDEL             : PREVIOUS LEVEL\n");
		printf("P               : PARAMETERS\nS               : TOGGLE SOUND\nM               : TOGGLE MUSIC\nC               : CHANGE COLOR\n");
		printf("I               : INVERSE MODE\nG               : GRAPHIC MODE\nT               : TEXT MODE\n");
		printf("H               : HELP\nP               : PAUSE");

		printcenter(17,4,6," ***+PARAMETERS ***+",0);

		*/
		render_instructions();
		/*
		ligne=18;max=4;mul=1;off=0;
		difficulty=			saisiemagique(difficulty,"DIFFICULTY");

		max=15;off=0;
		musiclevel=			saisiemagique(musiclevel,"MUSIC LEVEL");
		mul=16;off=15;
		speed=				saisiemagique(speed,     "SPEED");
		mul=4;off=16;
		game.fps=			saisiemagique(game.fps,  "FPS");
		mul=0x800;off=0x1800;
		reg306=				saisiemagique(reg306,    "*+306");
		mul=1;off=1;
		tempobase=			saisiemagique(tempobase, "TEMPO");
		tempo=tempovalue=tempobase;
		beat=0;max=15;off=0;
		beatmax=			saisiemagique(beatmax,   "BEATMAX");
		if (beatmax==0) beatmax=1;
		*/
		printf("\nIS THIS CORRECT ? ");
		/*	while(1)
		{

		if (c==134){ printf("YES");break;}
		if (c==136){ printf("NO");break;}
		}	*/
		ask_yes_or_no();
		soundmoving();

		if (c == 134) break;

		FLUSHIN();
		printf("\nRESET TO DEFAULTS ? ");

		/*	while(1)
		{
		c=peek(0x208);
		if (c==134){ printf("YES");break;}
		if (c==136){ printf("NO");break;}
		}	*/
		ask_yes_or_no();
		soundmoving();
		if (c == 134)
		{
			soundmovingempty();
			resetDefParams();
			/*	beat=0;
			game.fps=DEFAULT_FPS;
			speed=255;
			reg306=0x4000;
			difficulty=0;
			musiclevel=8;
			tempo=  tempovalue=   tempobase=DEFAULT_TEMPO;
			beatmax=DEFAULT_BEAT;
			musiclevel=DEFAULT_MUSICLEVEL;*/
		}
		aWait(0);
	}



	wait1 = 255 / speed; //(1-15);

	doke(0x306, reg306);

	resetGame();
}



//
//void play_music()
//{
//	unsigned char note1,note2,oct1,oct2;
//	unsigned int period;
//	
//	if (!SOUND_ACTIVE) return;
//	
//	tempo--;
//
//	if (tempo!=0) return;
//
//	tempo=tempovalue;
//
//	switch (etape)
//	{
//	case 0:
//		note1=*(musictrack1+musicindex);
//		oct1=note1/12-1;
//		note1%=12;
//
//		note2=*(musictrack2+musicindex);
//	
//		oct2=note2/12-2;
//
//		note2%=12;
//		note2++;
//		note1++;
//
//		music(1,oct1,note1,8);
//		music(2,oct2,note2,8);
//
//		play(7,0,0,0);
//		
//		if (etape==etapemax) etape=0;
//		else
//			etape++;
//	
//		
//		if (musicindex==127)
//			musicindex=0;
//		else
//			musicindex++;
//
//		break;
//	case 1:
//		play(5,0,0,0);
//		if (etape==etapemax) etape=0;
//		else
//			etape++;
//		break;
//
//	case 2:
//		play(7,0,0,0);
//		if (etape==etapemax) etape=0;
//		else
//			etape++;
//	case 3:
//		play(4,0,0,0);
//		etape=0;
//		break;
//	
//	
//
//
//
//	}
//	
//}


void display_message(const char* msg, int waittime, unsigned char waitkey)
{
	unsigned char len = strlen(msg);
	unsigned char c;
	unsigned char x;

	removeIrq();

	c = peek(BB804011);

	if (c > 7) c = 7;

	len = strlen(msg);

	x = 18 - len / 2;

	for (i = 0; i < 4 + len; i++)
	{
		poke(BB804011 + x + i, 16);
		poke(BB804014 + x + i, 16);
	}

	poke(BB804012 + x, A_ALT2HFL); printcenter(12, A_FWRED + 0, c + 0, msg, 0);
	poke(BB804013 + x, A_ALT2HFL); printcenter(13, A_FWMAGENTA + 0, c + 0, msg, 0);

	x = 21 + len / 2;

	poke(BB804012 + x, A_STD + 0);
	poke(BB804013 + x, A_STD + 0);

	x++;

	poke(BB804011 + x, c);
	poke(BB804012 + x, c);
	poke(BB804013 + x, c);
	poke(BB804014 + x, c);

	if (waittime)
		aWaitKey(waittime);


	if (waitkey)
		GETCHAR();
}




void runOutTimer()
{
	unsigned char amount = min(3, game.timer);

	increaseScore(amount * (1 + difficulty));

	game.timer -= amount;

	soundbonuspoints();

	render_timer();

	if (game.timer == 0)
	{
		lifes++;
		render_lifes();

		display_message(STRING_YOUWIN, 128, FALSE);

		if (game.index == 19)
		{
			if (difficulty < 5) difficulty++;
		}

		nextGame();

	}

}

extern void beginFrameA();
#define beginFrame() beginFrameA()

//void beginFramea()
//{
//	game.frame++;
//	render_frame();
//
//	game.frameff = game.frame & 0xff;
//	game.framestep=game.frame & game.fpsmask;
//
//	_amoeba.size = 0;
//	_amoeba.enclosed = TRUE;
//
//	if (oneChanceOn(3))  _idle.blink =!_idle.blink;
//	if (oneChanceOn(15)) _idle.tap	 =!_idle.tap;
//
//}



int iscore;
void insertscorehof()
{
	iscore = 8;
	for (i = 6; i >= 0; i--)
	{
		if (score <= hiscores[i])
		{
			break;
		}
	}

	if (i != 6)
	{
		for (j = 6; j > i + 1; j--)
		{
			hiscores[j] = hiscores[j - 1];
			memcpy(hinames[j], hinames[j - 1], 3);
		}

		hiscores[i + 1] = score;
		hinames[i + 1][0] = hinames[i + 1][1] = hinames[i + 1][2] = '.';
		iscore = i + 1;
	}
}


void hallOfFame()
{
	char c;
	char* ps;
	unsigned int dest;


	doke(0x306, reg306 * 2);

	insertscorehof();

	//paper(0);


	loadcharset1('0', boulderfont0, 43 * 8);
	loadcharset1('.', boulderfont_symbol2, 8);
	loadcharset1('!', boulderfont_symbol1, 8);
	//loadcharset1('*',cs_diamondscore,16);

	clrscr(9);

	/*for (i=0;i<28;i++)
	poke(0xbb80+i*40,9);*/

	clores();

	display_hof_frame();

	//printcenter(0,32,0," *********+HALL OF FAME *********+",0);

	/*for (i=1;i<16;i++) {
	dest = 0xbb80+i*40+4;
	poke(dest++ ,'*');poke(dest ,'+');
	dest+=30;
	poke(dest++,'*');poke(dest ,'+');
	}*/

	//printcenter(16,32,0," ********************************+",0);

	printcenter(18, 10, 5, STRING_NABC, 0);
	printcenter(19, 10, 6, STRING_NABC, 0);

	//printcenter(19,2,6,STRING_NABC,0);

	intro_music(1, tempobase >> 1, 0xEE, 1);

	for (i = 0; i < 7; i++)
	{
		j = 2 + i * 2;
		memset(buf, 0, 40);

		sprintf(buf, "%d", i + 1);
		printAt(12, j, buf);

		printAt(18, j, hinames[i]);
		//	gotoxy(18, j);
		//	printf("%s", hinames[i]);
		//	gotoxy(26, j);
		//	printf("%d", hiscores[i]);

		sprintf(buf, "%d", hiscores[i]);
		printAt(26, j, buf);
		aWait(30);
	}


	if (iscore < 7)
	{
		ps = hinames[iscore];

		dest = 0xbb80 + 18;
		iscore <<= 1;

		iscore += 2;
		iscore *= 40;

		dest += iscore;

		for (i = 0; i < 3;)
		{

			c = readkeyA();

			poke(dest, ' ' + 128);

			if ((c == '.') || (c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9'))
			{
				*ps = c;
				ps++;
				i++;
				soundmovingempty();
				poke(dest, c);
				while (1)
				{
					c = readkeyA();
					if (c == 0)
					{
						soundmoving();
						dest++;
						break;
					}
				}
			}
			else
			{
				poke(dest, ' ');
			}

		}
	}

	poke(0xbb80 + 18 * 40, 1);
	poke(0xbb80 + 19 * 40, 2);

	GETCHAR();

	removeIrq();


}


void disable_sound_magic();
void disable_sound_amoeba();

unsigned int choice;

void looseLevel()
{

	for (i = 0; i < 8; i++)
	{
		flash();
		aWait(30);
	}

	if (!infinite_lifes)
		lifes--;

	render_lifes();

	disable_sound_amoeba();
	disable_sound_magic();

	if (lifes > 0)
	{
		if (choice)
		{
			display_message(STRING_TIMEISUP, 128, FALSE);
		}
		else
		{
			display_message(STRING_TRYAGAIN, 128, FALSE);
		}
		resetGame();
	}
	else
	{
		display_message(STRING_GAMEOVER, 128, FALSE);
		hallOfFame();
		newGame();
	}
}

void soundrunningoutoftime()
{
	PERIOD = freq2period(0x2700 - (game.timer << 8));
	CHANNELS = 4; NOIZE = 0; ENVEL = 1; ENVLEN = 200;
	playfx();
}

extern void endFrame();


//#define endFrame() endFrameA()


/*void endFrame()
{
endFrameA();
if (_amoeba.dead==0)
{
if  (_amoeba.enclosed)
{
_amoeba.dead = OBJECT_DIAMOND;
play(CHANNELS&3,NOIZE&3,0,0);
}
else
if (_amoeba.size > AMOEBA_MAX)
{
_amoeba.dead = OBJECT_BOULDER;
play(CHANNELS&3,NOIZE&3,0,0);
}
else
if (_amoeba.slow > 0)
_amoeba.slow--;
}


if (_magic.active)
{
if (_magic.time==0)
{
_magic.active=FALSE;
load_sprite_dataD(sprite_brickwall		,P_MAGIC				,255 );
}
else
{
_magic.time--;
}
}



//skipmag
if (!game.flash && _diamonds.enough)
{
game.flash = game.frame + 1; // flash for 1 frame
}

if (game.frame <= game.flash)
{
//inverseVideo();
flash();
}


if (game.won)
{
runOutTimer();
}
else
if (game.frame - game.foundRockford > game.fps4)
{
looseLevel(0);
}
else if (game.timer==0)
{
looseLevel(1);
}
else  ///// MODULO INT16 % INT8
if (game.frame%game.fps==0) // @frame#7/8
{
autoDecreaseTimer();
//if (game.frame > game.birth) game.timer--; render_timer()

if (game.timer==10)
{
poke(0xbb80+27,9);
poke(0xbb80+28,7);
poke(0xbb80+22,13);
poke(0xbb80+23,1);
}
else
if (game.timer<10)
{
soundrunningoutoftime();
}
}

}
*/

//void animateDiamond()
//{
//	load_sprite_dataE(SP_DIAMOND	[cycle8]		,P_DIAMOND				,inversecharset?255:0);
//}

void animateOutbox()
{

	if (!_diamonds.enough && game.foundRockford) return;


	if (cycle2) // si fps pair !
		load_sprite_dataD(sprite_steelwall, P_PREOUTBOX, 255);
	else
		load_sprite_dataD(sprite_preoutbox, P_PREOUTBOX, 255);
}

//const unsigned char conditions[] = 
//{
//	ROCKFORD_FRONT,ROCKFORD_FRONT,ROCKFORD_FRONT,ROCKFORD_FRONT,ROCKFORD_FRONT,ROCKFORD_FRONT,ROCKFORD_FRONT,ROCKFORD_FRONT,
//	ROCKFORD_TAP_1,ROCKFORD_TAP_2,ROCKFORD_TAP_3,ROCKFORD_TAP_4,ROCKFORD_TAP_5,ROCKFORD_TAP_6,ROCKFORD_TAP_7,ROCKFORD_TAP_8,
//	ROCKFORD_BLINK_1,ROCKFORD_BLINK_2,ROCKFORD_BLINK_3,ROCKFORD_BLINK_4,ROCKFORD_BLINK_5,ROCKFORD_BLINK_6,ROCKFORD_BLINK_7,ROCKFORD_BLINK_8,
//	ROCKFORD_BLINKTAP_1,ROCKFORD_BLINKTAP_2,ROCKFORD_BLINKTAP_3,ROCKFORD_BLINKTAP_4,ROCKFORD_BLINKTAP_5,ROCKFORD_BLINKTAP_6,ROCKFORD_BLINKTAP_7,ROCKFORD_BLINKTAP_8
//};

//const unsigned char conditions[] = 
//{
//	ROCKFORD_FRONT,0,0,0,0,0,0,0,
//	ROCKFORD_TAP_1,9,8,9,8,9,8,9,
//	ROCKFORD_BLINK_1,17,16,17,16,17,16,17,
//	ROCKFORD_BLINKTAP_1,25,24,24,24,25,24,25
//};





//void animateRockford()
//{
//	unsigned char condition;
//	//unsigned char lastcycle =rockford_cycle;
//
//	// BLINK	TAP		CONDITION
//	// 0		0		0<<3=	0		=front
//	// 0		1		1<<3=	8		=tap
//	// 1		0		2<<3=	16		=blink
//	// 1		1		3<<3=	24		=blink+tap
//
//	if (rockford_cycle==ROCKFORD_FRONT)
//	{
//		condition = ((_idle.blink<<1) | (_idle.tap))<<3;
//		lprintf("condition=%d\r",condition);
//
//		rockford_cycle=conditions[condition]+cycle8;
//	}
//	
//	animate_rockford();
//
//}
#define updatePreRockford(p,o) if (game.frame>=game.birth) setCell(p,o)

void updateRockford()
{
	game.foundRockford = game.frame;

	cell_rockford = p;

	if (!game.won)

		// do nothing  
		if (game.timer == 0)
		{
			explodeCell(cell_rockford);
		}
		else
		{
			if (moving.dir != DIR_NONE)
			{
				cell_rockford_p2 = cell_rockford + moving.diroffset;

				if (moving.grab)
				{
					if (isDirt(cell_rockford_p2))
					{
						clearCell(cell_rockford_p2);
					}
					else if (isDiamond(cell_rockford_p2) || isFallingDiamond(cell_rockford_p2))
					{
						clearCell(cell_rockford_p2);
						collectDiamond();
					}
					else if (horizontal(moving.dir) && isBoulder(cell_rockford_p2))
					{
						pushCellRockford();
					}
				}
				else if (isEmptyOrDirt(cell_rockford_p2))
				{
					if (cell_rockford_p2->code == OBJECT_SPACE)
						soundmovingempty();
					else
						soundmoving();
					moveCell(cell_rockford, cell_rockford_p2, OBJECT_ROCKFORD);

				}
				else if (isDiamond(cell_rockford_p2))
				{
					moveCell(cell_rockford, cell_rockford_p2, OBJECT_ROCKFORD);
					collectDiamond();
				}
				else if (horizontal(moving.dir) && isBoulder(cell_rockford_p2))
				{
					pushCellRockford();
				}
				else if (isOutbox(cell_rockford_p2))
				{
					moveCell(cell_rockford, cell_rockford_p2, OBJECT_ROCKFORD);
					game.won = TRUE;
				}
			}
		}
}

//void doMagic(struct Cell *p)
//{
//	struct Cell *p2;
//
//	if (game.magic.time > 0) 
//	{
//		game.magic.active = TRUE;
//
//		clearCell(p);
//
//		p2= p +  OFFDIR_DOWN2;
//		if (isEmpty(p2))
//		{
//			setCell(p2, objectto);
//		}
//	}
//}

extern void updateBoulderOrDiamondA();
#define updateBoulderOrDiamond() updateBoulderOrDiamondA()

/*	void updateBoulderOrDiamond()
{
pdown = p + OFFDIR_DOWN;
if (isEmpty(pdown))
{
setCell(p, objectfalling);
}
else
{

if (isRounded(pdown))
{
pleft = p+OFFDIR_LEFT;
if (isEmpty(pleft))
{
pdownleft = p+OFFDIR_DOWNLEFT;
if (isEmpty(pdownleft))
{
moveCell(p,pleft,objectfalling);
}
}
else
{
pright= p+OFFDIR_RIGHT;
if (isEmpty(pright))
{
pdownright = p+OFFDIR_DOWNRIGHT;
if (isEmpty(pdownright))
{
moveCell(p,pright,objectfalling);
}
}
}
}
}
}
*/

#define updateBoulderOrDiamondFalling() updateBoulderOrDiamondFallingB()
extern void updateBoulderOrDiamondFallingB();

//// updateBoulderOrDiamondFalling()
//{
//	updateBoulderOrDiamondFallingB();
/*	pdown = p + OFFDIR_DOWN;
if (isEmpty(pdown))
{
moveCell(p,pdown,p->code);
}
else
{
if (isExplodable(pdown))
{
explodeCell(pdown);
}
else
{
if (isMagic(pdown))
{
doMagic(p);
}
else
{

if (isRounded(pdown))
{
pleft=p+OFFDIR_LEFT;
if (isEmpty(pleft))
{
pdownleft=p+OFFDIR_DOWNLEFT;
if (isEmpty(pdownleft))
{
moveCell(p, pleft , p->code);
return;
}
}
else
{
pright=p+OFFDIR_RIGHT;
if (isEmpty(pright))
{
pdownright=p+OFFDIR_DOWNRIGHT;
if (isEmpty(pdownright))
{
moveCell(p, pright, p->code);
return;
}
}
}
}

setCell(p, objectfrom);


}
}
}*/
///}

//p=cell;
//	OFF_DIR=OFFDIR_LEFT			;OFF_NEWDIR = OFFDIR_DOWN;
//												;o_Ldir=OBJECT_FIREFLY4	 ;o_Rdir=OBJECT_FIREFLY2 = fireflies[dirRleft]

//TODO: BUG!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
extern void updateFireflyOrButterflyA();

#define updateFireflyOrButterfly() updateFireflyOrButterflyA()  
//
//void updateFireflyOrButterflyOK() 
//{
// 	struct Cell *p2,*p3;
//
//	pup		= p+OFFDIR_UP;
//	if (isRockfordOrAmoeba(pup))
//	{	  
//		explodeCell(p);
//	}
//	else 
//	{
//		pdown	= p+OFFDIR_DOWN;
//		if (isRockfordOrAmoeba(pdown))
//		{
//			 
//			explodeCell(p);
//		}
//		else 
//		{
//			pleft	= p+OFFDIR_LEFT;
//			if (isRockfordOrAmoeba(pleft))
//			{
//				explodeCell(p);
//			}
//			else
//			{
//				pright	= p+OFFDIR_RIGHT;
//				if (isRockfordOrAmoeba(pright))
//				{
//					
//					explodeCell(p);
//				}
//				else 
//				{	
//					p2 = p+OFF_NEWDIR;
//					if (isEmpty(p2))
//					{
//						moveCell(p,p2,o_Ldir); 
//					}
//					else 
//					{
//						p3 = p+OFF_DIR;
//						if (isEmpty(p3))
//						{
//							moveCell(p,p3, p->code);
//						}
//						else
//						{
//							setCell(p, o_Rdir); 
//						}
//					}
//				}
//			}
//		}
//	}
//}


extern void updateAmoebaA();
#define updateAmoeba() updateAmoebaA()

//void updateAmoebaa() 
//{
//	struct Cell *p2;
//	unsigned char grow;
//	unsigned char dir;
//
//	if (game.amoeba.dead) 
//	{
//		setCell(p, game.amoeba.dead);
//	}
//	else 
//	{
//		game.amoeba.size++;
//
//		pup		= p+OFFDIR_UP;
//
//		if (isEmptyOrDirt(pup))
//		{
//			game.amoeba.enclosed = FALSE;
//		}
//		else
//		{
//			pdown	= p+OFFDIR_DOWN;
//
//			if (isEmptyOrDirt(pdown))
//			{
//				game.amoeba.enclosed = FALSE;
//			}
//			else
//			{
//				pright	= p+OFFDIR_RIGHT;
//
//				if (isEmptyOrDirt(pright))
//				{
//					game.amoeba.enclosed = FALSE;
//				}
//				else
//				{
//					pleft	= p+OFFDIR_LEFT;
//
//					if (isEmptyOrDirt(pleft)) 
//					{
//						game.amoeba.enclosed = FALSE;
//					}
//				}
//			}
//		}
//
//		if (game.frame >= game.birth) 
//		{
//			if (game.amoeba.slow)
//				grow = oneChanceOn(31);
//			else
//				grow = oneChanceOn(3);
//
//
//			if (grow)
//			{
//				dir  = RANDOM_DIR[randomInt(3)];
//
//				p2   = p+OFFDIR[dir];
//
//				if (isEmptyOrDirt(p2))
//				{
//					setCell(p2, OBJECT_AMOEBA);
//				}
//			}
//		}
//	}
//}

extern void gameUpdateA();
#define gameUpdate() gameUpdateA()

//void gameUpdateok()
//{
//	struct Cell *cell =(struct Cell *) cells+40;
//	int x,y;
//
//	beginFrame();
//
//	for (y=1;y<21;y++)
//		for (x=0;x<40;x++,cell++)
//			if	(cell->frame != (game.frameff)) // scan only one time each cell 
//			{
//				p=cell;
//				switch (cell->code)
//				{
//				case OBJECT_AMOEBA:
//					updateAmoeba();
//					break;  
//
//				case OBJECT_BOULDER:          
//					objectfalling=OBJECT_BOULDERFALLING;
//					updateBoulderOrDiamond();
//					break;
//
//				case OBJECT_DIAMOND:    
//					objectfalling=OBJECT_DIAMONDFALLING;
//					updateBoulderOrDiamond();
//					break;
//
//				case OBJECT_BOULDERFALLING: 	
//					objectto=OBJECT_DIAMOND;objectfrom=OBJECT_BOULDER; 
//					updateBoulderOrDiamondFalling();  
//					break;
//
//				case OBJECT_DIAMONDFALLING:   
//					objectto=OBJECT_BOULDER;objectfrom=OBJECT_DIAMOND; 
//					updateBoulderOrDiamondFalling();  
//					break;
//
//				case OBJECT_ROCKFORD:  
//					current_xpos=rockford_to_xpos[x];
//					current_ypos=rockford_to_ypos[y];
//					updateRockford();
//					break;
//
//				case OBJECT_FIREFLY_LEFT:
//					OFF_DIR=OFFDIR_LEFT				;OFF_NEWDIR = OFFDIR_DOWN;
//					o_Ldir=OBJECT_FIREFLY_DOWN		;o_Rdir=OBJECT_FIREFLY_UP;
//					updateFireflyOrButterfly();	 
//					break;
//
//				case OBJECT_FIREFLY_UP:      
//					OFF_DIR=OFFDIR_UP				;OFF_NEWDIR = OFFDIR_LEFT;
//					o_Ldir=OBJECT_FIREFLY_LEFT		;o_Rdir=OBJECT_FIREFLY_RIGHT;
//					updateFireflyOrButterfly();
//					break;
//
//				case OBJECT_FIREFLY_RIGHT:
//					OFF_DIR=OFFDIR_RIGHT			;OFF_NEWDIR = OFFDIR_UP;
//					o_Ldir=OBJECT_FIREFLY_UP		;o_Rdir=OBJECT_FIREFLY_DOWN;
//					updateFireflyOrButterfly();
//					break;
//
//				case OBJECT_FIREFLY_DOWN:
//					OFF_DIR=OFFDIR_DOWN				;OFF_NEWDIR = OFFDIR_RIGHT;
//					o_Ldir=OBJECT_FIREFLY_RIGHT		;o_Rdir=OBJECT_FIREFLY_LEFT;
//					updateFireflyOrButterfly();
//					break;
//
//				case OBJECT_BUTTERFLY_LEFT:        
//					OFF_DIR=OFFDIR_LEFT				;OFF_NEWDIR = OFFDIR_UP;
//					o_Ldir=OBJECT_BUTTERFLY_UP		;o_Rdir=OBJECT_BUTTERFLY_DOWN;
//					updateFireflyOrButterfly();	 
//					break;
//
//				case OBJECT_BUTTERFLY_UP:      
//					OFF_DIR=OFFDIR_UP				;OFF_NEWDIR = OFFDIR_RIGHT;
//					o_Ldir=OBJECT_BUTTERFLY_RIGHT	;o_Rdir=OBJECT_BUTTERFLY_LEFT;
//					updateFireflyOrButterfly();
//					break;
//
//				case OBJECT_BUTTERFLY_RIGHT:     
//					OFF_DIR=OFFDIR_RIGHT			;OFF_NEWDIR = OFFDIR_DOWN;
//					o_Ldir=OBJECT_BUTTERFLY_DOWN	;o_Rdir=OBJECT_BUTTERFLY_UP;
//					updateFireflyOrButterfly();
//					break;
//
//				case OBJECT_BUTTERFLY_DOWN:       
//					OFF_DIR=OFFDIR_DOWN				;OFF_NEWDIR = OFFDIR_LEFT;
//					o_Ldir=OBJECT_BUTTERFLY_LEFT	;o_Rdir=OBJECT_BUTTERFLY_RIGHT;
//					updateFireflyOrButterfly();
//					break;
//
//				case OBJECT_PREOUTBOX: 
//					updatePreOutbox(cell); 	
//					break;	
//
//				case OBJECT_EXPLODETOSPACE0:	
//					if (explosespace_cycle==6) 	explosespace_cycle=1;
//					setCell(cell,OBJECT_EXPLODETOSPACE1);    
//					break;
//
//				case OBJECT_EXPLODETOSPACE1:    setCell(cell,OBJECT_EXPLODETOSPACE2);    break;
//				case OBJECT_EXPLODETOSPACE2:    setCell(cell,OBJECT_EXPLODETOSPACE3);    break;
//				case OBJECT_EXPLODETOSPACE3:    setCell(cell,OBJECT_EXPLODETOSPACE4);    break;
//				case OBJECT_EXPLODETOSPACE4:    clearCell(cell)						;	 break;//->code=0;//setCell(cell,OBJECT_SPACE);				 
//
//				case OBJECT_EXPLODETODIAMOND0:  
//					if (explosediamond_cycle==6) explosediamond_cycle=1;
//					setCell(cell,OBJECT_EXPLODETODIAMOND1);  
//					break;
//
//				case OBJECT_EXPLODETODIAMOND1:  setCell(cell,OBJECT_EXPLODETODIAMOND2);  break;
//				case OBJECT_EXPLODETODIAMOND2:  setCell(cell,OBJECT_EXPLODETODIAMOND3);  break;
//				case OBJECT_EXPLODETODIAMOND3:  setCell(cell,OBJECT_EXPLODETODIAMOND4);  break;
//				case OBJECT_EXPLODETODIAMOND4:  setCell(cell,OBJECT_DIAMOND);	         break;
//
//				case OBJECT_PREROCKFORD1: 
//					current_xpos=rockford_to_xpos[x];
//					current_ypos=rockford_to_ypos[y];
//					updatePreRockford(cell, OBJECT_PREROCKFORD2);
//					break;
//
//				case OBJECT_PREROCKFORD2: setCell(cell, OBJECT_PREROCKFORD3);   break;
//				case OBJECT_PREROCKFORD3: setCell(cell, OBJECT_PREROCKFORD4);   break;
//				case OBJECT_PREROCKFORD4: setCell(cell, OBJECT_ROCKFORD);       break;
//
//				default:break;
//				}
//			}
//
//			endFrame();
//}



unsigned char spacegrab = FALSE;

extern void handleKeyA();
#define handleKey() handleKeyA()


//void okhandleKey()
//{	 
//	if (peek(0x209)!=56)
//	{
//		moving.grab=TRUE;
//		poke (BB80402718,5);
//	}
//	else
//	{
//		moving.grab=spacegrab;
//		poke (BB80402718,spacegrab);
//	}
//	switch (peek(0x208))
//	{
//	case 132: 
//		moving_toggleGrab(moving);
//		poke (BB80402718,moving.grab);
//		spacegrab=moving.grab;
//		break;
//	case 180://down
//		moving_startDown(moving);
//		break;
//	case 156://up
//		moving_startUp(moving);
//		break;
//	case 172://left
//		moving_startLeft(moving);
//		break;
//	case 188://right
//		moving_startRight(moving);
//		break;
//	case 169://escape
//		resetGame( );
//		break;
//	case 175://return
//		nextGame();
//		break;
//	case 173://del
//		prevGame();
//		break;			
//	case 56:
//		moving_stop(moving);
//		break;
//	case 141:
//		inversecharset=!inversecharset;
//		flash();
//		break;
//	case 186:
//		choose_nextcolor();
//		break;
//	case 137: 
//		render=RENDER_ASCII;
//		clrscr();
//		init_stats();
//		loadcharset1('A',data_previewcharset,64*8);
//		break;
//	case 150:
//		render=RENDER_SPRITE;
//		clrscr();
//		init_render();
//		init_stats();
//		break;
//	case 182:
//		SOUND_ACTIVE=!SOUND_ACTIVE;
//		break;
//	}
//}

//int midi2period(int note,int octave)
//{
//	return (peek(0xfc5e+note)*256+peek(0xfc6b+note))>>octave;
//}
//extern int midi2periodA(int note,int octave);
//#define midi2period midi2periodA
//void midi2sound()
//{
//	int note,octave;
//	int freq;
//	int period;
//	
//		for (i=0;i<128;i++)
//		{
//			note=		1+musictrack1[i]%12;
//			octave=		musictrack1[i]/12-2;
//			
//			period=midi2period(note,octave);
//			poke(converted1+i*2,period&255);
//			poke(converted1+i*2+1,(period>>8)&255);
//
//			note=		1+musictrack2[i]%12;
//			octave=		musictrack2[i]/12-2;
//			
//			period=midi2period(note,octave);
//			poke(converted2+i*2,period&255);
//			poke(converted2+i*2+1,(period>>8)&255);
//		}
//
//}

extern void animatesA();
#define animates() animatesA()

/*
void animates()
{


animate_butterfly();
animate_firefly();
animate_diamond();
if (_magic.active)
{
animate_magic();
}
if (_amoeba.size)
{
animate_amoeba();
}
if (game.foundRockford)
{
if (_diamonds.enough)
{
animateOutbox();
}
else
{//////////////////////test
load_sprite_dataD(sprite_steelwall,P_PREOUTBOX,inversecharset?0:255);
}
animateRockford();
}
else
{
animateOutbox();
}

if (explosespace_cycle!=6)
{
animate_explose_to_space();
explosespace_cycle++;
}

if (explosediamond_cycle!=6)
{
animate_explose_to_diamond();
explosediamond_cycle++;
}

cycle2++;
cycle2&=1;

cycle4++;
cycle4&=0x03;

cycle8++;
cycle8&=0x07;
}*/

extern void playsounds();
extern void soundrandom3();
extern void soundrandom3magic();

void enable_sound_magic()
{
	if (MAGIC_SOUND_ENABLED) return;

	MAGIC_SOUND_ENABLED = TRUE;
	removeIrq();
	addchain(soundrandom3magic);
	addIrq();
}

void disable_sound_magic()
{
	if (!MAGIC_SOUND_ENABLED) return;
	removeIrq();
	MAGIC_SOUND_ENABLED = FALSE;
}


void enable_sound_amoeba()
{
	if (AMOEBA_SOUND_ENABLED) return;

	AMOEBA_SOUND_ENABLED = TRUE;
	removeIrq();
	addchain(soundrandom3);
	addIrq();
}

void disable_sound_amoeba()
{
	if (!AMOEBA_SOUND_ENABLED) return;
	removeIrq();
	AMOEBA_SOUND_ENABLED = FALSE;
}

void intromusic()
{
	intro_music(0, tempobase, 0xEE, 0);
}

extern void playsounds();
extern void renderGame();

void gameLoop()
{
	newGame();

	render = RENDER_SPRITE;

	init_stats();

	intromusic();

	

	while (TRUE)
	{
		cursor_off();

		/*
		if (MUSIC_ACTIVE)
		CHANNELS|=3;


		if (peek(0x24a)==0x40)
		{
		if (MUSIC_ACTIVE)
		{
		intromusic();
		}
		}
		else
		{
		if (!MUSIC_ACTIVE)
		{
		removeIrq();
		CHANNELS&=4;
		play(CHANNELS,NOIZE,0,0);
		}
		}

		if (_magic.active)
		{
		soundmagic();
		}

		if (_amoeba.size)
		{
		soundamoeba();
		}
		*/

		//if (render==RENDER_SPRITE)
		//{
		//	animates();
		//	render_level();
		//}
		//else
		//{
		//	if (cycle2++)
		//	{
		//		//todo merge
		//		loadcharset1('A'+OBJECT_DIAMOND,cs_diamond2,8);
		//		loadcharset1('A'+OBJECT_DIAMONDFALLING,cs_diamondfalling2,8);  
		//	}
		//	else
		//	{
		//		loadcharset1('A'+OBJECT_DIAMOND,cs_diamond,8);
		//		loadcharset1('A'+OBJECT_DIAMONDFALLING,cs_diamondfalling,8); 
		//	}

		//	
		//	cycle2&=1;

		//	render_level_ascii();
		//}

		///////////////////////////////////// HANDLE KEY
		handleKey();
		///////////////////////////////////// UPDATE
		gameUpdate();
		///////////////////////////////////// RENDER
		renderGame();
		 
		///////////////////////////////////// SOUND FX
		playsounds();
		///////////////////////////////////// WAIT
		if (wait1 > 1)
			for (i = 0; i < wait1; i++)
				aWait(4 - difficulty);
		////////////////////////////////////////////////
	}

}
extern int helpaddr;

extern void drawhelp(unsigned char c, char* s);
//void drawhelp(int c,char *s)
//{
//	printf("%c%c%c",c++,c++,c++);printf("%c%s\n",9+128,s);  
//	printf("%c%c%c",c++,c++,c);printf("\n");
//}

extern void helpC();

void help()
{
	unsigned char magicactive;
	unsigned char amosize;
	unsigned char gamewon;
	gamewon = game.won;
	game.won = TRUE;
	clrscr(32);
	init_render();
	loadcs2();
	choose_samecolor();
	helpaddr = 0xbb80 + 2 + 40;

	drawhelp(87, "ROCKFORD : YOUR HERO");
	drawhelp(33, "DIRT : DIG THROUGH");
	drawhelp(69, "BOULDER : PUSH TO MOVE'EM");
	drawhelp(75, "DIAMOND : COLLECT'EM ALL");
	drawhelp(39 + 128, "BRICK WALL");
	drawhelp(57 + 128, "STEEL WALL");
	drawhelp(45 + 128, "MAGIC WALL");
	drawhelp(63 + 128, "FIREFLY : ENEMY ! KILL'EM");
	drawhelp(81, "BUTTERFLY : ENEMY ! KILL'EM");
	drawhelp(93 + 128, "AMOEBA : YEARRKK !");
	drawhelp(51 + 128, "EXIT : FINISH");

	amosize = _amoeba.size;
	magicactive = _magic.active;

	_magic.active = TRUE;
	_amoeba.size = 1;

	FLUSHIN();

	while (peek(0x208) == 56)
	{
		animates(); rockford_cycle = ROCKFORD_FRONT; animateRockford(); animateOutbox();
		helpC();

		aWait(30);
	}

	_magic.active = magicactive;
	_amoeba.size = amosize;

	if (render == RENDER_ASCII)
	{
		clrscr(32);
		loadcharset1('A', data_previewcharset, 512);

	}
	else
		load_sprite_dataD(sprite_steelwall, P_PREOUTBOX, 255);

	removeIrq();
	AMOEBA_SOUND_ENABLED = FALSE;
	MAGIC_SOUND_ENABLED = FALSE;
	game.won = gamewon;

}

 


/************************************************************************************/

void main()
{
	int k;

 

	game.fps = 17;
	difficulty = 0;

	/*for (k=0;k<256*64;k++)
	printf("%d %d\n",k,fmod(k,17));
	*/
	doke(0x306, reg306 * 2);

	play0000();

	clrscr(32);
	//cursor off , kbd click off,caps off

	poke(0x247, 0x60);
	//poke(0xbb80+36,0);

	loadcs1();

	render_boulderdash_title();

	clores();

	cursor_off();

	intro_music(1, tempobase >> 1, 0xEE, 0); // inc

	while (peek(0x208) == 56)
	{
		k = cycle8 * 48;
		load_sprite_dataD(sprite_rockford_run_right_1 + k, P_ROCKFORD + 0x400, 0);
		load_sprite_dataD(sprite_rockford_run_left_1 + k, P_BOULDER + 0x400, 0);
		cycle8++;
		cycle8 &= 7;
		aWait(10);
	}
	//	GETCHAR();
	removeIrq();
	//patchcycling();
	poke((unsigned int)randomA + 1, peek(0x274));

	removeIrq();
	MUSIC_ACTIVE = FALSE;

	//GETCHAR();
	gameLoop();

}