//Unit 5 Game
//Ema Sun
//4.29

color white = #ffffff;
color black = #000000;
color darkPurple = #C04AC6;

//Target-----------------------------------------------------------------------------

float player1x,player1y, //position
player1d; //diameter

float player2x,player2y, //position
player2d; //diameter

float ballx, bally,balld, vx, vy;

//key variables
boolean aKey, dKey, wKey, sKey, upKey, downKey, rightKey, leftKey;


void setup() { //player 1x vs player 2x...
  size (600, 600);
  player1x = width/2;
  player1y = height/2;
  player1d = 100;
  
  player2x = width/2;
  player2y = height/2;
  player2d = 100;

  ballx = width/2;
  bally=height/2;
  balld = 50;

  vx= -4;
  vy= -5;
}

void draw() {
  background (0);
  fill (darkPurple);
  circle (player1x, player1y, player1d);
  
  if (aKey) player1x = player1x - 5;
  if (dKey) player1x = player1x + 5;
  if (wKey) player1y = player1y - 5;
  if (sKey) player1y = player1y + 5;
  
  circle (player2x, player2y, player2d);
  if (rightKey) player2x = player2x + 5;
  if (leftKey) player2x = player2x -5;
  if (upKey) player2y = player2y - 5;
  if (downKey) player2y = player2y + 5;

  //ball mvt
  ballx += vx;
  bally += vy;

  //ball bounce
if (ballx <= balld/2 || ballx >= width-balld/2) vx= -vx;
if (bally <= balld/2 || bally >= height-balld/2) vy= -vy;
}

void keyPressed() {
  if ( key == 'a') aKey = true;
  if ( key == 'd') dKey = true;
  if ( key == 'w') wKey = true;
  if ( key == 's') sKey = true;
  
  if (keyCode == RIGHT) rightKey = true;
  if (keyCode == LEFT) leftKey = true;
  if (keyCode == UP) upKey = true;
  if (keyCode == DOWN) downKey = true;
  
}

void keyReleased() {
  if ( key == 'a') aKey = false;
  if ( key == 'd') dKey = false;
  if ( key == 'w') wKey = false;
  if ( key == 's') sKey = false;  
  
  if (keyCode == RIGHT) rightKey = false;
  if (keyCode == LEFT) leftKey = false;
  if (keyCode == UP) upKey = false;
  if (keyCode == DOWN) downKey = false;
}
  
  
//not optimal for games (typing) -> need the buttons/shapes to move smoothly
//void keyPressed() {
//if (key == 'a') {
// x = x - 10;
//  }
// }

//void keyReleased() {
// }
  
