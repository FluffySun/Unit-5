//Unit 5 Pong Game
//Ema
PFont titleFont, buttonFont;
//INTRO MUSIC+ANIMATION START SCREEN!!! 6.20

//CHANGE: 
//Left side has the ball go through, and when move paddle to some places 
//it does not bounce back, 
//bounce in the bottom by itself
//sound

//1player & 2player mode
//collisions,bounce,score & pause

int mode = 0; //0=INTRO,1=GAME,2=PAUSE,3=GAMEOVER
int gameType = 0; //1=1player, 2=2player

// Paddles
float leftY, rightY;
float paddleW = 150;
float paddleH = 80;

// Ball
float ballX, ballY, vx, vy;
float ballD = 20;
int leftScore = 0, rightScore = 0;
int scoreLimit = 3;

// Input keys
boolean wKey, sKey, upKey, downKey;

// Score timer
int waitCounter = 0;
boolean waiting = false;

//Declare Array
Particle[] particles = new Particle[60];

void setup() {
  size(800, 600);
  //bounceSound = new SoundFile(this, "bounce.wav");
  //scoreSound = new SoundFile(this, "score.wav");
  //introMusic = new SoundFile(this, "intro.mp3");
  //winSound = new SoundFile(this, "win.wav"); //Insert sounds NEEDED!!!
  //introMusic.loop();

  resetGame();
}
//FINISH SOUND
void draw() {
  background(0);

  if(mode==0) {
  //  for (int i = 0; i < particles.length; i++) {
  //particles[i].update();
  //particles[i].display();
    //int i = 0;
//while (i < particles) {
//  particles[i]();
//  particles[i]();
//  i++;
//}
showIntro();}
 else if(mode==1) playGame();
  else if (mode==2) showPause();
  else if (mode==3) showGameOver();
} 
//------END OF DRAW------

//MODES
void showIntro() {
    //  background(15, 10, 35);
  
  //NEW>>>
  
  if (titleFont == null) {
    titleFont = createFont("Georgia-Bold", 60);
    buttonFont = createFont("Arial", 18);
  }

  // Arc-style game title
  textFont(titleFont);
  fill(255, 200, 255);
  textAlign(CENTER);
  text("⛳P O N G⛳", width/2, 120);

  //// Glowing pulse ring effect behind buttons
  //noStroke();
  //float pulse = sin(frameCount * 0.05) * 10 + 40;
  //fill(180, 100, 255, 70);
  //ellipse(width/2, 260, pulse + 100, pulse + 100);
  //ellipse(width/2, 410, pulse + 100, pulse + 100);
  
noStroke();
fill(180, 100, 255, 70); // soft glow color
ellipse(width/2, 260, 150, 150); // behind 1P button
ellipse(width/2, 410, 150, 150); // behind 2P button

  // 1 Player Button
  if (dist(mouseX,mouseY,width/2,260) < 50) {
  fill(255, 200, 255);
} else {
  fill(150, 100, 200); 
}
ellipse(width/2, 260, 100, 100);

// 2 Player Button
if (dist(mouseX,mouseY,width/2,410) < 50) {
  fill(255, 100, 100); 
} else {
  fill(200, 80, 80); 
}
ellipse(width/2, 410, 100, 100);

  // Labels on buttons
  fill(0);
  textFont(buttonFont);
  text("1P", width/2, 265);
  text("2P", width/2, 415);

  // Decorative footer
  fill(255);
  textFont(createFont("Arial", 14));
  text("Click a glowing orb to start", width/2, 500);
}
//END HERE <<<NEW

void playGame() {
  // Draw paddles
  fill(255);
  
//ORGINAL
//rect(50, leftY, paddleW, paddleH);
//rect(width - 50, rightY, paddleW, paddleH);

ellipse(60, leftY + paddleH/2, paddleW, paddleW);
ellipse(width - 60, rightY + paddleH/2, paddleW, paddleW);

//NEW NEED FIX
//left paddle
//ellipse(50, leftY + paddleH/2, paddleW, paddleW); 

//right paddle
//ellipse(width - 50, rightY + paddleH/2, paddleW, paddleW);

  //Draw ball
ellipse(ballX, ballY, ballD, ballD);

  // Move ball (? UNDERSTAND?)
  if (waiting) {
    ballX+=vx;
    ballY+=vy;
  } else {
    waitCounter++;
    if (waitCounter>=100) {
      waiting=false;
    }
  }

  // Paddle control (?UNDERSTAND?)
if (wKey && leftY>0) leftY -= 4;
if (sKey && leftY+paddleH<height) leftY += 4;
  if (gameType == 2) {
    if (upKey && rightY > 0) rightY -= 5;
    if (downKey && rightY + paddleH < height) rightY += 5;
  } else {
    //paddle
if (ballY < rightY + paddleH / 2) rightY -= 3;
else if (ballY > rightY + paddleH / 2) rightY += 3;
  }
  // Bounce
  if (ballY <= 0 || ballY >= height) vy *= -1;

  // Paddle Collision
float dLeft = dist(ballX, ballY, 60, leftY + paddleH/2);
if (vx < 0 && dLeft < (paddleW + ballD)/2) {
  vx *= -1; //video->
  //sound
}
float dRight = dist(ballX, ballY, width - 60, rightY + paddleH/2);
if (vx > 0 && dRight < (paddleW + ballD)/2) {
  vx *= -1;
}

  //???WHY DOES THIS NOT WORK???
  //DO I NEED THIS BELOW?>>>
//if (ballX + ballD/2 >= width - 50 - paddleW && ballY > rightY && ballY < rightY + paddleH && vx > 0) vx *= -1;
//END

  // Score
  if (ballX < 0) {
    rightScore++;
    resetBall();
  }
  if (ballX > width) {
    leftScore++;
    resetBall();
  }

  // Draw score
  textSize(32);
  textAlign(CENTER);
  text(leftScore, width/4, 50);
  text(rightScore, 3 * width/4, 50);

  // Win
  if (leftScore==scoreLimit||rightScore==scoreLimit) {
    mode=3;
  }
}

//-------ENDED LOOKING HERE!!-------EMA

void showPause() { //HOW DO I DO THE PAUSE BUTTON?
 fill(255);
  textAlign(CENTER);
  textSize(32);
  text("PAUSED – Click to Resume", width/2, height/2);
  textSize(20);
  text("Click anywhere to continue", width/2, height/2 + 40);
}

void showGameOver() { //NEED A GAMEOVER SCREEN->SPLIT INTO WIN & LOSE (player 1 vs 2)
  fill(255);
  textAlign(CENTER);
  textSize(32);
  if (leftScore == scoreLimit) text("Left Side Wins!", width/2, height/2);
  else text("Right Side Wins!", width/2, height/2);

  textSize(20);
  text("Click to Restart", width/2, height/2 + 50);
}

//control

void keyPressed() {
  if (key == 'w') wKey = true;
  if (key == 's') sKey = true;
  if (keyCode == UP) upKey = true;
  if (keyCode == DOWN) downKey = true;
}

void keyReleased() {
  if (key == 'w') wKey = false;
  if (key == 's') sKey = false;
  if (keyCode == UP) upKey = false;
  if (keyCode == DOWN) downKey = false;
}

void mousePressed() {
background(255);

if (mode == 0) {
  // 1 Player button
  if (dist(mouseX, mouseY, width/2, 260) < 50) 
  { 
    gameType = 1; 
    mode = 1; 
} 
else if (dist(mouseX, mouseY, width/2, 410) < 50) { 
gameType = 2; 
mode = 1; 
}

  } else if (mode == 1) {
    mode = 2; //pause
  } else if (mode == 2) {
    mode = 1; //continue
  } else if (mode == 3) {
    resetGame(); //restart
    mode = 0;
  }
}

//void createParticles() {
//  int i = 0;
//  while (i < particles) {
//    particles[i] = new Particle();
//    i++;
//  }
//}

//help

void resetBall() { //I DID NOT LEARN TO DO RANDOM LIKE THIS
  ballX = width/2;
  ballY = height/2;
if (random(1) < 0.5) vx = random(4.5,5.5);
else vx = 5;
  vy = random(-1.5, 3);
  if (vy==0) vy=1;
  waiting = true;
  waitCounter = 0;
}

void resetGame() { 
  leftY = height/2 - paddleH/2;
  rightY = height/2 - paddleH/2;
  leftScore = 0;
  rightScore = 0;
  resetBall();
}

class Particle { //1. CHANGE SMTH ABT THE PARTICLE ANIMATION AT THE START SCREEN(class)
//2. +STILL NEED SOUND EFFECTS
  float x = random(width);
  float y = random(height);
  float r = random(5, 15);
  float speed = random(0.5, 1.5);

  void update() {
    y += speed;
    if (y > height) y = 0;
  }

  void display() {
    noStroke();
    fill(255, 100, 255, 50);
    ellipse(x, y, r, r);
  }
}
