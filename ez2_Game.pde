/**
 Class Game for EzLib2
   version 2020-05-04
 */


class ez2_Game {

  private float timer=0;
  private float extimer=0;
  private float timefps=0;
  private boolean go=false;
  private int fps=0;

  private ez2_StageManager gsm=null;
  private ez2_InputManager input=null;

  ez2_Game(ez2_StageManager gsm, ez2_InputManager input) {
    this.gsm=gsm;
    this.input= input;
    timer=0;
    extimer=0;
    go=false;
    fps=0;
  }

  void start() {
    go=true;
  }

  void pause() {
    go=false;
  }


  void action() {
    if (go) {
      timer=millis();
      float dt= (timer-extimer)/1000.0;
      fps++;
      timefps+=dt;
      
      if(timefps >= 1.0)
      {
        //println(fps);
        fps=0;
        timefps=0;
      }
     
      gsm.update(dt);

      gsm.render();

      input.update();


      extimer=timer;
    }
  }
}
