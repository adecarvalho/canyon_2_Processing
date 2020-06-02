
class Plane extends ez2_Entity
{
  static final int PLANE_STATE_IDLE=22;
  static final int PLANE_STATE_LIVE=23;
  static final int PLANE_STATE_TOUCHED=24;

  private int screenWidth=0;
  private int screenHeight=0;

  private PVector posiInit=null;

  private ez2_Animation animation=null;
  private ez2_Animation explosion=null;

  private ez2_Generator gaz=null;

  private float gravity=9;

  //*********************
  Plane(int screenWidth, int screenHeight)
  {
    super(screenWidth/3, screenHeight/2, gAssetsManager.getImage("plane"));

    this.screenWidth= screenWidth;
    this.screenHeight= screenHeight;


    animation= new ez2_Animation(gAssetsManager.getImage("flying"), 90, 75, 0.03, true);

    animation.play();

    explosion= new ez2_Animation(gAssetsManager.getImage("explosion"), 102, 102, 0.02, false);

    posiInit= new PVector(screenWidth/3, screenHeight/2);

    setState(PLANE_STATE_IDLE);

    setSpeeds(0, 0);

    gaz= new ez2_Generator(screenWidth/3, screenHeight/2+20, 100, 150, 170, 190);
    gaz.begin();

    inflate(10, 10);
  }

  //**********
  void reset()
  {
    setState(PLANE_STATE_IDLE);
    setPosition(posiInit);
    setSpeeds(0,0);
  }

  //************
  void touched()
  {
    if (getState()==PLANE_STATE_LIVE)
    {
      setState(PLANE_STATE_TOUCHED);
      setSpeeds(0,0);
      explosion.play();
    }
  }

  //*******************
  void update(float dt)
  {

    //
    super.update(dt);

    //
    if (getState()==PLANE_STATE_LIVE)
    {
      // acc=gravity= d.vit/dt

      float py= getPositionY();

      float dy= getSpeedY(); 

      dy= dy+ gravity*dt; 

      py=py+ dy;

      setSpeedY(dy);

      setPositionY(py);
    }

    //input
    if (gInputManager.isKeyPressed(32))
    {

      if (getState()== PLANE_STATE_IDLE)
      {
        setState(PLANE_STATE_LIVE);
      }

      setSpeedY(-3);
    }

    //bounds
    if (getTop() <0)
    {
      setTop(0);
    }

    if (getBottom() >screenHeight)
    {
      setBottom(screenHeight);
    }

    //animations
    animation.update(dt);

    explosion.update(dt);

    //gaz
    gaz.move(getPositionX(), getPositionY()+20);
    gaz.update(dt);


    //
    if (getState()==PLANE_STATE_TOUCHED && explosion.isPlaying()==false)
    {
      reset();
    }

    //
    super.update(dt);
  }

  //
  void render()
  {

    //
    if (getState()==PLANE_STATE_IDLE || getState()==PLANE_STATE_LIVE)
    {
      // super.render();

      gaz.render(); 
       
      animation.render(getPositionX(), getPositionY());

      super.renderDebug();
    }

    //
    if (getState()==PLANE_STATE_IDLE)
    {
      fill(51);
      textSize(50);

      text("Press Space bar ", screenWidth/3, screenHeight/2-50);
    }

    //
    if (getState()==PLANE_STATE_TOUCHED)
    {
      explosion.render(getPositionX(), getPositionY());
    }
  }
}
//end
