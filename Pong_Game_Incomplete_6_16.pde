//Unit 5 Pong Game
//Ema
//1-player & 2-player mode with collisions, bounce, score & pause
int mode = 0; // 0=INTRO, 1=GAME, 2=PAUSE, 3=GAMEOVER
int gameType = 0; // 1 = 1-player, 2 = 2-player

// Paddles
float leftY, rightY;
float paddleW = 20;
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

void setup() {
  size(800, 600);
  resetGame();
}

void draw() {
  background(0);

  if (mode == 0) showIntro();
  else if (mode == 1) playGame();
  else if (mode == 2) showPause();
  else if (mode == 3) showGameOver();
}

// ------------------ MODES --------------------

void showIntro() {
  fill(255);
  textAlign(CENTER);
  textSize(32);
  text("Welcome to PONG!", width/2, 100);
  text("Choose Game Mode", width/2, 160);
  rectMode(CENTER);
  fill(200, 100, 255);
  rect(width/2, 250, 150, 50); //1Player
  fill(255, 100, 100);
  rect(width/2, 320, 150, 50); //2Players
  fill(0);
  textSize(20);
  text("1 Player", width/2, 257);
  text("2 Players", width/2, 327);
}

void playGame() {
  // Draw paddles
  fill(255);
  rect(50, leftY, paddleW, paddleH);
  rect(width - 50, rightY, paddleW, paddleH);

  // Draw ball
  ellipse(ballX, ballY, ballD, ballD);

  // Move ball
  if (!waiting) {
    ballX += vx;
    ballY += vy;
  } else {
    waitCounter++;
    if (waitCounter >= 100) {
      waiting = false;
    }
  }

  // Paddle control
if (wKey && leftY > 0) leftY -= 4;
if (sKey && leftY + paddleH < height) leftY += 4;
  if (gameType == 2) {
    if (upKey && rightY > 0) rightY -= 5;
    if (downKey && rightY + paddleH < height) rightY += 5;
  } else {
    // AI Paddle
if (ballY < rightY + paddleH/2 && rightY > 0) rightY -= 4;
else if (ballY > rightY + paddleH/2 && rightY + paddleH < height) rightY += 4;
  }

  // Bounce
  if (ballY <= 0 || ballY >= height) vy *= -1;

  // Paddle Collision
if (ballX - ballD/2 <= 50 + paddleW && ballY > leftY && ballY < leftY + paddleH && vx < 0) vx *= -1;
if (ballX + ballD/2 >= width - 50 - paddleW && ballY > rightY && ballY < rightY + paddleH && vx > 0) vx *= -1;

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
  if (leftScore == scoreLimit || rightScore == scoreLimit) {
    mode = 3;
  }
}

void showPause() {
  fill(255);
  textAlign(CENTER);
  textSize(32);
  text("PAUSED - Click to Resume", width/2, height/2);
}

void showGameOver() {
  fill(255);
  textAlign(CENTER);
  textSize(32);
  if (leftScore == scoreLimit) text("Left Side Wins!", width/2, height/2);
  else text("Right Side Wins!", width/2, height/2);

  textSize(20);
  text("Click to Restart", width/2, height/2 + 50);
}

// ------------------ CONTROLS --------------------

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
  if (mode == 0) {
    if (mouseX > width/2 - 75 && mouseX < width/2 + 75 && mouseY > 225 && mouseY < 275) {
      gameType = 1;
      mode = 1;
    }
    if (mouseX > width/2 - 75 && mouseX < width/2 + 75 && mouseY > 295 && mouseY < 345) {
      gameType = 2;
      mode = 1;
    }
  } else if (mode == 1) {
    mode = 2;
  } else if (mode == 2) {
    mode = 1;
  } else if (mode == 3) {
    resetGame();
    mode = 0;
  }
}

// ------------------ HELPERS --------------------

void resetBall() {
  ballX = width/2;
  ballY = height/2;
  vx = random(2) > 1 ? 5 : -5;
  vy = random(-3, 3);
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
