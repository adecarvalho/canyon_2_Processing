
class IntroStage extends ez2_Stage
{
  private ez2_MoveLabel titre=null;
  private ez2_MoveLabel action=null;
  private ez2_Label author=null;
  private Paysage paysage=null;

  private int tab[]={65, 65, 65};
  private int indice;
  private float timer;
  private boolean toggle;
  private color c=color(209, 144, 24);

  private PFont font=null;

  private float pause=2.0;


  //
  IntroStage(int screenWidth, int screenHeight)
  {
    super(screenWidth, screenHeight);

    paysage= new Paysage(screenWidth, screenHeight);

    action= new ez2_MoveLabel(gAssetsManager.getFont("free_50"));
    action.setColorText(c);
    action.setText("Press Enter to start");
    action.setInitialPosition(-1.5*screenWidth, screenHeight-150);
    action.setFinalPosition(screenWidth/6, screenHeight-150);
    action.setSpeeds(400, 0);

    titre= new ez2_MoveLabel(gAssetsManager.getFont("free_40"));
    titre.setColorText(c);
    titre.setText("Canyon 2 Processing");
    titre.setInitialPosition(screenWidth/6, -1.5*screenHeight);
    titre.setSpeeds(0, 300);
    titre.setFinalPosition(screenWidth/6, screenHeight/6);

    author= new ez2_Label(gAssetsManager.getFont("free_20"));
    author.setColorText(c);
    author.setText("A.DeCarvalho");

    indice=0;
    timer=0;
    toggle=false;

    font=gAssetsManager.getFont("free_40");
  }
  //
  //
  void onEnter(StringDict message)
  {

    if (gMusicPlayer!= null)
    {
      gMusicPlayer.load("musics/intro_stage_canyon2.mp3");
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

    timer+=dt;

    titre.update(dt);
    action.update(dt);

    if (timer >0.2f)
    {
      timer=0;
      toggle=!toggle;
    }


    //

    //
    if (gInputManager.isKeyPressed(LEFT) && indice>0)
    {
      indice--;
    }
    //
    if (gInputManager.isKeyPressed(RIGHT) && indice <2)
    {
      indice++;
    }
    //
    if (gInputManager.isKeyPressed(UP))
    {
      tab[indice]+=1;
      if (tab[indice]>90)
      {
        tab[indice]=65;
      }
    }
    //
    if (gInputManager.isKeyPressed(DOWN))
    {
      tab[indice]-=1;
      if (tab[indice]<65)
      {
        tab[indice]=90;
      }
    }
    //
    if (gInputManager.isKeyPressed(ENTER))
    {
      StringDict msg= new StringDict();
      msg.set("NAME", ""+char(tab[0])+char(tab[1])+char(tab[2]));

      gStageManager.changeStage(new GameStage(screenWidth, screenHeight), msg);
    }
  }

  //
  void printName()
  {
    int xp=screenWidth/3;
    int yp=screenHeight/3;

    textFont(font);
    fill(c);


    //indice 0
    if (indice==0)
    {
      if (toggle)
      {
        text(char(tab[0]), xp, yp);
      }

      text(char(tab[1]), xp+50, yp);

      text(char(tab[2]), xp+100, yp);
    }
    //
    else if (indice==1)
    {
      text(char(tab[0]), xp, yp);
      if (toggle)
      {
        text(char(tab[1]), xp+50, yp);
      }



      text(char(tab[2]), xp+100, yp);
    }
    //
    else
    {
      text(char(tab[0]), xp, yp);

      text(char(tab[1]), xp+50, yp);
      if (toggle)
      {
        text(char(tab[2]), xp+100, yp);
      }
    }
  }

  //
  void render()
  {
    //
    paysage.render();

    titre.render();
    
    action.render();
    
    author.render(screenWidth-200, screenHeight-50);

    printName();
   
  }
}
//end
