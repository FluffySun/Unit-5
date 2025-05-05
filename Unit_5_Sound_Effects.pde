import processing.sound.*;

//Sound Effects
//Ema 5.5

SoundFile fail, success, music;

void setup() {
fail= new SoundFile (this, "FAILURE.wav");
success= new SoundFile (this, "SUCCESS.wav");
music= new SoundFile (this, "MUSIC.mp3");

  music.loop(); //play at every frame if put in draw function
  //amp has to be after play the sound (play/loop)
  music.amp(0.3); //0 is default (softest), 0-100?
}

void mouseReleased() {
  success. stop();
  success. play(); //continuous sounds
  //put code sound into "If statement" & check collision->create effect
}

//void draw() {
  
