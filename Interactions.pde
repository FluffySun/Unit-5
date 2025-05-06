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
