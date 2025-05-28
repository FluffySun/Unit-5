void game() {
  //float brickd;
  
  background(darkblue);
  
  //paddle-------------------------------------------------------------------------------
  fill(white); //draw paddle
  circle(px,py,pd);
  if (akey) px=px-5; //key mvt
  if (dkey) px=px+5;
  
  //ball
  fill(white); //draw ball
  circle(bx,by,bd);
  
  bx=bx=vx; //mvt
  by=by+vy;
  
  //bouncing
  if (dist(bx,by,px,py) < bd/2 + pd/2) { //paddle bounce
    vx = (bx-px)/10;
    vy = (by - py)/10;
  }
  if (by < bd/2 || by > height-bd/2) { //bounce off top
    vy =vy * -1;
  }
  if (bx < bd/2 || bx > width-bd/2) { //bounce off side
    vx =vx * -1;
  }
  
  //bricks
  //circle(x[0],y[0],brickd);
  //circle(x[1],y[1],brickd); 
  //circle(x[2],y[2],brickd);
  
  int i = 0;
  while (i < n) {
    circle(x[i],y[i],brickd);
    i=i+1;
  }
}

void gameClicks() {
}
