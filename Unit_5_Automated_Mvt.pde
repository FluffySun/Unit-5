//color palette
color white = #ffffff;
color black = #000000;

//Ball variables
float ballx, bally, balld; //ball's position and diameter
float vx, vy; //ball's ve3locity
float ax, ay;

void setup() {
  size (600, 600, P2D); //smooth movement, less lag, slower to load
  ballx = width/2;
  bally=height/2;
  balld = 50;
}


void draw(){
  background (255);
  strokeWeight(5);
  stroke(black);
  fill(255,0,0);
  circle (ballx, bally, balld);
  
  ballx = ballx + vx;
  bally = bally +vy; //how much move in that direction

  //Easy way, no bouncing
  vx = -4; //the direction
  vy = -5; //random (-100,100)
  
  //bouncing off the walls
  //if (bally<=0) vy = -vy; //top
  //if (bally>=600) vy = -vy; //bottom
  
  //gravity:
  vx = vx + ax;
  vy = vy + ay;
  
  ax = 1;
  ay = -1;
  
  //OR function
  if (bally <= 0 || bally >= height ) vy= -vy;
  if (ballx <= 0 || ballx >= width ) vx = -vx;
  
  //bouncing off walls on the edges
  if (bally <= 0+balld/2) {
    vy = vy * -0.95;
    bally = balld/2;
  }
  
  if (bally >= height - balld/2) {
    vy = vy * -0.95;
    bally = height - balld/2;
  }
  
  if (ballx <= 0+balld/2) {
    vx = vx * -0.95;
    ballx = balld/2;
  }
  
  if (ballx >= width - balld/2) {
    vx = vx * -0.95;
    ballx = width - balld/2;
  }
}

//Collision of 2 Circles
//Distance between centers when colliding= radius + radius

//if (dist(x1,y1,x2,y2) <= R+R)
