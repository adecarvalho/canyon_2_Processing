/**
 Class Stage for ezLib2
 version 2020-05-04
 */

abstract class ez2_Stage {
  
  protected int screenWidth=0;
  protected int screenHeight=0;

  ez2_Stage(int screenWidth, int screenHeight) {
    this.screenWidth= screenWidth;
    this.screenHeight= screenHeight;
    
  }

  //
  abstract void update(float dt);

  //
  abstract void render();

  //
  abstract void onEnter(StringDict message);

  //
  abstract void onExit();
}
//end 
