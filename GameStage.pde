
class GameStage extends ez2_Stage
{
  private ez2_ScoreManager score=null;

  private Paysage paysage=null;

  private Rock tabRocks[]= null;

  private Pillars pillars=null;

  private Plane plane=null;

  private AudioSample ding=null;
  
  private AudioSample boom=null;


  //
  GameStage(int screenWidth, int screenHeight)
  {
    super(screenWidth, screenHeight);

    score= new ez2_ScoreManager("fonts/free.ttf", color(51,51,51));

    paysage= new Paysage(screenWidth, screenHeight);

    tabRocks= new Rock[2];

    tabRocks[0]= new Rock(screenWidth, screenHeight, Rock.ROCK_TYPE_TOP);

    tabRocks[1]= new Rock(screenWidth, screenHeight, Rock.ROCK_TYPE_BOTTOM);

    pillars= new Pillars(screenWidth, screenHeight);

    plane= new Plane(screenWidth, screenHeight);

    ding= gAssetsManager.getSound("ding");

    boom= gAssetsManager.getSound("boom");
  }

  //
  //
  void onEnter(StringDict message)
  {

    if (message !=null)
    {
      score.setName(message.get("NAME"));
      score.setPoints(0);
      score.setLives(3);
    }

    if (gMusicPlayer!= null)
    {
      gMusicPlayer.load("musics/play_stage_canyon2.mp3");
      gMusicPlayer.loop();
    }
  }

  //
  void onExit()
  {

    if (gMusicPlayer!= null)
    {
        gMusicPlayer.pause();
    }
  }

  //collisions
  void collisions()
  {
    //rocks-plane
    for (Rock item : tabRocks)
    {
      if (plane.getState()==Plane.PLANE_STATE_LIVE && plane.isCollide(item))
      {
        score.decrementLives();

        plane.touched();

        pillars.newWave();

        boom.stop();
        boom.trigger();
      }
    }

    //pillars-plane
    if (pillars.isCollidePlane(plane))
    {
      score.decrementLives();

      plane.touched();

      boom.stop();
      boom.trigger();
    }
  }

  //
  void update(float dt)
  {
    //paysage
    paysage.update(dt);

    //rocks
    for (Rock item : tabRocks)
    {
      item.update(dt);
    }

    //pillars
    pillars.update(dt);

    //plane
    plane.update(dt);

    //collisions
    collisions();

    //pillars touch left
    if (pillars.isTouchLeft() && plane.getState()==Plane.PLANE_STATE_LIVE)
    {
      score.incrementPoints(1);

      pillars.newWave();
      
      ding.stop();
      ding.trigger();
    }

    //gameover
    if (score.isGameOver())
    {
      StringDict msg=new  StringDict();

      msg.set("NAME", ""+score.getName());
      msg.set("SCORE", ""+score.getPoints());

      gStageManager.changeStage(new ConcluStage(screenWidth, screenHeight), msg);
    }
  }

  //
  void render()
  {
    //paysage
    paysage.render();

    //pillars
    pillars.render();

    //rock
    for (Rock item : tabRocks)
    {
      item.render();
    }
    
     //plane
    plane.render();
    
    //score
    score.render();
  }
}
//end
