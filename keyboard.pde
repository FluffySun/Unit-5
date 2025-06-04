//PONG GAME START:

void keyPressed() {
  if (key =='w' || key =='W')  wkey=true;
  if (key =='s' || key =='S') skye=true;
  if(keyCode==UP) upkey=true;
  if(keyCode==DOWN) downkey=true;
}

void keyReleased() {
    if (key =='w' || key =='W')  wkey=false;
    if (key =='s' || key =='S') skye=false;
    if (keyCode==UP) upkey=false;
    if (keyCode==DOWN) downke=false;//the thing that moves the different ways
}

//:END PONG GAME
