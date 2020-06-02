
class Rock extends ez2_Entity
{
  static final int ROCK_TYPE_TOP=100;
  static final int ROCK_TYPE_BOTTOM=200;

  private int screenWidth=0;
  private int screenHeight=0;

  private float speedModule=300;

  //
  Rock(int screenWidth, int screenHeight, int type)
  {
    super(0, 0, 1600, 70);

    this.screenWidth= screenWidth;
    this.screenHeight= screenHeight;

    switch(type)
    {
    case ROCK_TYPE_TOP:
      setImage(gAssetsManager.getImage("rock_up"));

      setTop(0);
      setLeft(0);
      setSpeedX(-speedModule);
      break;

    case ROCK_TYPE_BOTTOM:
      setImage(gAssetsManager.getImage("rock_down"));

      setBottom(screenHeight);
      setLeft(0);
      setSpeedX(-speedModule);
      break;

    default:
      break;
    }

    inflate(0, 15);
  }

  //
  void update(float dt)
  {
    super.update(dt);

    if (getRight() < screenWidth)

      setLeft(0);
  }

  //
  void render()
  {
    super.render();

    //super.renderDebug();
  }
}
//end
