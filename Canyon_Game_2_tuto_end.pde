
import java.util.*;

import ddf.minim.*;

ez2_InputManager gInputManager=null;

ez2_StageManager gStageManager=null;

ez2_AssetsManager gAssetsManager=null;

ez2_MusicPlayer gMusicPlayer=null;

Minim gMinim=null;

ez2_Game game=null;


//*************
void setup() {

  int screenWidth=800;
  int screenHeight=480;

  size(800, 480);

  gMinim= new Minim(this);

  gMusicPlayer= new ez2_MusicPlayer(gMinim);

  gAssetsManager= new ez2_AssetsManager(gMinim);

  gStageManager= new ez2_StageManager();

  gInputManager= new ez2_InputManager();


  //load textures
  gAssetsManager.putImage("paysage", "images/paysage.png");
  gAssetsManager.putImage("game_over", "images/game_over.jpg");
  gAssetsManager.putImage("plane", "images/plane1.png");
  gAssetsManager.putImage("flying", "images/flying.png");
  gAssetsManager.putImage("explosion", "images/explosion.png");
  gAssetsManager.putImage("rock_up", "images/rock_up.png");
  gAssetsManager.putImage("rock_down", "images/rock_down.png");
  gAssetsManager.putImage("pillar_down", "images/pillar_bas.png");
  gAssetsManager.putImage("pillar_up", "images/pillar_haut.png");

  //load sounds
  gAssetsManager.putSound("ding", "sounds/ding.wav", 256);
  gAssetsManager.putSound("boom", "sounds/boom.wav", 256);

  //load font
  gAssetsManager.putFont("free_50", "fonts/free.ttf", 50);
  gAssetsManager.putFont("free_40", "fonts/free.ttf", 40);
  gAssetsManager.putFont("free_20", "fonts/free.ttf", 20);

  //create game
  game= new ez2_Game(gStageManager, gInputManager);

  //stages
  gStageManager.addStage(new IntroStage(screenWidth, screenHeight));

  game.start();
}

//***********
void draw() {
  //
  game.action();
}


//*****************
void keyPressed() 
{
  gInputManager.setKeyboardPressed(keyCode);
}

//******************
void keyReleased() 
{
  gInputManager.setKeyboardReleased(keyCode);
}

//*****************
void mousePressed() {
  gInputManager.setMouseClicked(mouseX,mouseY);
}

//****************
void mouseReleased() {
  gInputManager.setMouseReleased(mouseX,mouseY);
}
