//Breakout Project
//Ema Sun
//Finish May 29th
//5.28

//Arrays
int[] x;
int[] y;
boolean[] alive;
int brickd;
int n;
int tempx, tempy;

//Fonts
PFont.list();
//Mali-Bold//-48;

//Colors 
color darkblue=#272D4D;
color purple=#B83564;
color mango=#FF6A5A;
color orange=#FFB350;
color green=#83B8AA;
color white=#FFFFFF;
color black=#000000;

//Mode variables
int mode;
final int INTRO = 1;
final int GAME = 2;
final int PAUSE = 3;
final int GAMEOVER = 4;

//intro GUI
float a;

//Game entities
float bx, by, bd, vx, vy, px, py, pd;

//Keyboard variables
boolean akey, dkey;

//Brick variables
int[] x; //decalaration
int[] y;

void setup() {
  size (800,800);
  washyourhands = createFont("Wash Your Hands",50);
  textFont(washyourhands);

  
  textAlign(CENTER,CENTER);
  noStroke();
  mode = INTRO;
  
  //set up paddle & ball
  bx = width/2;
  by= height-200;
  bd =10;
  px=width/2;
  py=height;
  pd=100;
  vx=0;
  vy=1;
  
  //setup array for bricks
  n=4;
  brickd = 50;
  x = new int[n]; //instantiation
  y = new int[n];
  
  x[0]=10; //in the book x, on page 0
  y[0]=100;
  
  x[1]=400;
  y[1]=100;
  
  x[2]=700;
  y[2]=100;
  
  x[3]=100;
  y[3]=200;
}

//When put bricks into void game: circle(X[0],y[0],100);
