import ddf.minim.*;

Minim minim;
AudioPlayer bounce,score,intro,win;

PFont titleFont,buttonFont;

final int INTRO=0;
final int GAME=1;
final int PAUSE=2;
final int GAMEOVER=3;

int mode=INTRO;
int gameType=0;

float leftY,rightY;
float paddleW=150;
float paddleH=80;

float ballX,ballY,vx,vy;
float ballD=20;
int leftScore=0,rightScore=0;
int scoreLimit=3;

boolean wKey,sKey,upKey, downKey;
int waitCounter=0;
boolean waiting=false;

float y1 =600, r1 = 10;
float y2= 650,r2 = 15;
float y3 = 700,r3 = 20;
float y4=730, r4=25;
float y5=580, r5 = 12;
float y6 = 620,r6=18;

boolean winPlayed=false; 

void setup() {
  size(800, 600);
  minim=new Minim(this);
  bounce=minim.loadFile("bounce.wav");
  score=minim.loadFile("score.wav");
  intro=minim.loadFile("intro.mp3");
  win=minim.loadFile("win.wav");
  intro.loop();
  resetGame();
}

void draw() {
  background(0);
  if (mode==INTRO) {
    showIntro();
  } else if (mode==GAME) {
    playGame();
  } else if (mode==PAUSE) {
    showPause();
  } else if (mode==GAMEOVER) {
    showGameOver();
  }
}

void showIntro() {
  drawSparkles();

  if (titleFont==null) {
    titleFont=createFont("Georgia-Bold",60);
    buttonFont=createFont("Arial",18);
  }

  textFont(titleFont);
  fill(255,200,255);
  textAlign(CENTER);
  text("⛳P O N G⛳",width/2,120);
  noStroke();
  fill(180,100,255,70);
  ellipse(width/2, 260,150,150);
  ellipse(width/2,410, 150,150);

  if (dist(mouseX,mouseY, width/2,260) < 50) fill(255,200, 255);
  else fill(150,100, 200);
  ellipse(width/2, 260, 100,100);

  if (dist(mouseX,mouseY, width/2,410)<50) fill(255, 100,100);
  else fill(200,80,80);
  ellipse(width/2,410, 100, 100);

  fill(0);
  textFont(buttonFont);
  text("1P",width/2,265);
  text("2P",width/2,415);

  fill(255);
  textFont(createFont("Arial",14));
  text("Click a glowing orb to start",width/2,500);
}

void drawSparkles() {
  int i=1;
  while (i<=6) {
    noStroke();
    fill(random(100, 255), random(100, 255), 255, 70);
    if (i == 1) { ellipse(100, y1, r1, r1); y1-= 1.2; if (y1 < 0) y1 = height; }
    if (i== 2) { ellipse(200, y2, r2, r2); y2 -= 1.5; if (y2 < 0) y2 = height; }
    if (i==3) { ellipse(300, y3, r3, r3); y3 -= 0.9; if (y3 < 0) y3 = height; }
    if (i ==4) { ellipse(400, y4, r4, r4); y4 -= 1.7; if (y4 < 0) y4 = height; }
    if (i == 5) {ellipse(500, y5, r5, r5); y5 -= 1.3; if (y5 < 0) y5 = height; }
    if (i == 6) { ellipse(600, y6, r6, r6); y6 -=1.1; if (y6 < 0) y6 = height; }
    i++;
  }
}

void playGame() {
  //Left paddle
  fill(100,150,255);
  ellipse(60,leftY+paddleH/2,paddleW,paddleW);

  //Right paddle
  fill(255,100,100);
  ellipse(width-60,rightY+paddleH/2,paddleW,paddleW);

  //Ball
  fill(255,255,100);
  ellipse(ballX, ballY,ballD,ballD);

  if (waiting) {
    ballX+=vx;
    ballY+=vy;
  } else{
    waitCounter++;
    if (waitCounter>=100) waiting=true;
  }

  if (wKey && leftY>0) leftY-=4;
  if (sKey && leftY+paddleH < height) leftY+=4;

  if (gameType == 2) {
    if (upKey&&rightY>0) rightY-=5;
    if (downKey && rightY+paddleH<height) rightY+=5;
  } else {
    if (ballY<rightY+paddleH/2) rightY-=3;
    else if (ballY>rightY+paddleH/2) rightY+=3;
  }

  if (ballY<=0 || ballY>=height) vy*=-1;

  float dLeft=dist(ballX,ballY,60,leftY+paddleH/2);
  if (vx<0 && dLeft<(paddleW+ballD)/2) {
    vx*=-1;
    bounce.rewind(); 
    bounce.play(); 
  }

  float dRight =dist(ballX, ballY, width-60, rightY+paddleH/2);
  if (vx> 0 && dRight<(paddleW + ballD)/2) {
    vx*=-1;
    bounce.rewind();
    bounce.play();
  }
  
  if (ballX<0) {
    rightScore++;
    score.rewind();
    score.play();
    resetBall();
  }
  if (ballX>width) {
    leftScore++;
    score.rewind();
    score.play();
    resetBall();
  }
  textSize(32);
  textAlign(CENTER);
  text(leftScore,width/4,50);
  text(rightScore,3*width/4,50);

  if (leftScore==scoreLimit || rightScore==scoreLimit) mode=GAMEOVER;
}

void showPause() {
  fill(255);
  textAlign(CENTER);
  textSize(32);
  text("PAUSED – Click to Resume",width/2, height/2);
  textSize(20);
  text("Click anywhere to continue", width/2, height/2+40);
}

void showGameOver() {
  fill(255);
  textAlign(CENTER);
  textSize(32);
  if (winPlayed) {
    win.rewind(); 
    win.play(); 
    winPlayed=true;
  }
  if (leftScore ==scoreLimit && rightScore<scoreLimit) {
    text("Left Side Wins!", width / 2, height / 2);
  } else if (rightScore==scoreLimit && leftScore<scoreLimit) {
    text("Right Side Wins!", width/2, height/2);
  } else {
    text("It's a tie!", width/2,height/2);
  }
  textSize(20);
  text("Click to Restart", width/2, height/2+50);
}

void keyPressed() {
  if (key=='w') wKey=true;
  if (key=='s') sKey=true;
  if (keyCode==UP) upKey=true;
  if (keyCode==DOWN) downKey=true;
}

void keyReleased() {
  if (key=='w') wKey=false;
  if (key=='s') sKey=false;
  if (keyCode==UP) upKey=false;
  if (keyCode==DOWN) downKey=false;
}

void mousePressed() {
  if (mode==INTRO) {
    if (dist(mouseX, mouseY,width/2,260)<50) {
      gameType=1;
      mode=GAME;
    } else if (dist(mouseX,mouseY,width/2,410)<50) {
      gameType=2;
      mode=GAME;
    }
  } else if (mode==GAME) {
    mode=PAUSE;
  } else if (mode==PAUSE) {
    mode=GAME;
  } else if (mode==GAMEOVER) {
    resetGame();
    mode=INTRO;
  }
}

void resetBall() {
  ballX =width/2;
  ballY =height/2;
if (random(1)<0.5) {
  vx = random(4.5,5.5);
} else {
  vx = -random(4.5,5.5);
}
  vy = random(-1.5,3);
  if (vy==0) vy=1;
  waiting=false;
  waitCounter=0;
}

void resetGame() {
  leftY =height/2-paddleH/2;
  rightY =height/2-paddleH/2;
  leftScore =0;
  rightScore =0;
  winPlayed =false;
  resetBall();
}
