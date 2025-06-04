//Breakout Project
//Ema Sun
//Finish May 29th
//5.28

//Arrays
//Brick variables
int[] x; //decalaration
int[] y;
boolean[] alive;
int brickd;
int n;
int tempx, tempy; //calculation

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

//entity variable->PONG: START
float leftx, lefty, leftd, rightx, righty, rightd; //paddle
float ballx, bally, balld; //ball

//scoring
int leftscore,rightscore,timer;

//keyboard variables
boolean wkey,skye,upkey,downkey;

//PONG END

void setup() {
  size (800,800);
  washyourhands = createFont("Wash Your Hands",50);
  textFont(washyourhands);
  
  textAlign(CENTER,CENTER);
  noStroke();
  mode = INTRO;
  
  //PONG STARTS:
  leftx=0;
  lefty=height/2;
  leftd=200;
  
  rightx=width;
  righty=height/2;
  rightd=200;
  
  //initialize ball
  ballx=width/2;
  bally=height/2;
  balld=100;
  
  //initialize keyboard vars
  wkey=skey=upkey=downkey=false;
  
   
  //:PONG ENDS
}
  
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
  n=28;
  brickd = 50;
  x = new int[n]; //instantiation
  y = new int[n];
  alive = new boolean[n];
  
  tempx=100;
  tempy=100;
  int i=0;
  while (i<n) {
    x[i]=tempx;
    y[i]=tempy;
    alive[i]=true;
    tempx=tempx+100;
    if (tempx==width) {
      tempx=100;
      tempy=tempy+100;
    }
    i=i+1; //SWITCH EVERYTHING FOR THE ROWS OF CIRCLES EACH DIFF COLOR
  }
    
//NO NEED: x[0]=10; //in the book x, on page 0

//When put bricks into void game: circle(X[0],y[0],100);

void draw() {
  if (mode == INTRO) {
    intro();
  } else if (mode == GAME) {
    game();
  } else if (mode == GAMEOVER) {
    gameOver();
  } else {
    println("ERROR! Mode is" +mode);
  }
}

void mouseReleased() {
  mode = mode + 1;
}
