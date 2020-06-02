/**
 */
class Pillars
{
  private int screenWidth=0;
  private int screenHeight=0;

  private Pillar pillar_up=null;
  private Pillar pillar_down=null;

  private float speed=300;

  private boolean touchedLeft=false;
  //
  Pillars(int screenWidth, int screenHeight)
  {
    this.screenWidth= screenWidth;
    this.screenHeight= screenHeight;

    pillar_up= new Pillar(screenWidth, screenHeight, Pillar.PILLAR_TYPE_UP);

    pillar_down= new Pillar(screenWidth, screenHeight, Pillar.PILLAR_TYPE_DOWN);

    newWave();
  }

  //
  void newWave()
  {
    reset();
    action();
    touchedLeft=false;
  }

  //
  void reset()
  {
    pillar_down.reset();
    pillar_up.reset();
  }

  //
  void action()
  {
    float val= random(1);

    if (val <0.5)
    {
      pillar_down.move(speed);
    } else
    {
      pillar_up.move(speed);
    }
  }

  //
  boolean isTouchLeft()
  {
    return touchedLeft;
  }

  //
  boolean isCollidePlane(Plane plane)
  {
    int state= plane.getState();

    if (state!=Plane.PLANE_STATE_LIVE)
    {
      return false;
    }

    //
    if (pillar_down.isCollide(plane) || pillar_up.isCollide(plane))
    {
      reset();
      action();
      return true;
    }

    return false;
  }

  //
  void update(float dt)
  {
    pillar_up.update(dt);
    pillar_down.update(dt);

    if (pillar_down.isTouchLeft() || pillar_up.isTouchLeft())
    {
      touchedLeft=true;
    }
  }

  //
  void render()
  {
    pillar_up.render();
    pillar_down.render();
  }
}
//end
