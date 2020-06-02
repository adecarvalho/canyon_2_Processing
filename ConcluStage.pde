
class ConcluStage extends ez2_Stage
{
  private PImage image=null;
  
  private ez2_Label labelEnter=null;
  private ez2_Label labelExit=null;
  private ez2_Label labelPoints=null;
  
  private  color c=color(209, 144, 24);

  private AudioPlayer concluMusic=null;

  //
  ConcluStage(int screenWidth, int screenHeight)
  {
    super(screenWidth, screenHeight);

    image= gAssetsManager.getImage("game_over");

    labelEnter= new ez2_Label(gAssetsManager.getFont("free_20"));
    labelEnter.setColorText(c);
    labelEnter.setText("Press Enter > play");


    labelExit= new ez2_Label(gAssetsManager.getFont("free_20"));
    labelExit.setColorText(c);
    labelExit.setText("Press Esc > exit");


    labelPoints= new ez2_Label(gAssetsManager.getFont("free_20"));
    labelPoints.setColorText(c);
    labelPoints.setText("Points");
  }

  //
  void onEnter(StringDict message)
  {
    if (message != null && message.size()>0)
    {
      labelPoints.setText(message.get("NAME")+ " win "+message.get("SCORE")+" pts");
    }

    if (gMusicPlayer!= null)
    {
      gMusicPlayer.load("musics/conclu_stage_canyon2.mp3");
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
  //
  void update(float dt)
  {
    if (gInputManager.isKeyPressed(ENTER))
    {
      gStageManager.changeStage(new IntroStage(screenWidth, screenHeight), null);
    }
  }

  //
  void render()
  {
    background(247, 247, 247);

    image(this.image, screenWidth/6, screenHeight/12);

    labelPoints.render(screenWidth/3, screenHeight-150);

    labelEnter.render(screenWidth/3, screenHeight-100);

    labelExit.render(screenWidth/3, screenHeight-50);
  }

  //
}
//end
