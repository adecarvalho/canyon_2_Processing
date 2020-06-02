
class Pillar extends ez2_Entity
{
  static final int PILLAR_TYPE_UP=20;
  static final int PILLAR_TYPE_DOWN=30;

  private int screenWidth=0;
  private int screenHeight=0;

  private boolean touchLeft=false;

  //
  Pillar(int screenWidth, int screenHeight, int type)
  {
    super(0, 0, 108, 239);

    this.screenWidth= screenWidth;
    this.screenHeight= screenHeight;

    touchLeft=false;

    switch(type)
    {
    case PILLAR_TYPE_UP:
      setImage(gAssetsManager.getImage("pillar_up"));
      setTop(0);
      setLeft(screenWidth);
      break;

    case PILLAR_TYPE_DOWN:
      setImage(gAssetsManager.getImage("pillar_down"));
      setBottom(screenHeight);
      setLeft(screenWidth);
      break;

    default:
      break;
    }

    inflate(30, 20);
  }

  //
  void update(float dt)
  {
    super.update(dt);
    //
    if (getRight() <=0)
    {
      touchLeft=true;
    }
  }

  //
  void render()
  {
    super.render();

    super.renderDebug();
  }

  //
  void reset()
  {
    touchLeft=false;
    setSpeedX(0);
    setLeft(screenWidth);
  }

  //
  void move(float speed)
  {
    setSpeedX(-speed);
  }

  //
  boolean isTouchLeft()
  {
    return touchLeft;
  }
}
//end
