/*
 class ez_Particule and ezGenerator for ezlib2
 version 2020-05-05
 */


class ez2_Particule
{
  private PVector position=null;

  private PVector speed=null;
  private float radius;
  private float lives;
  private int col_alpha;
  private int state;
  private float timer;

  private int r, g, b;


  static final int PARTICULE_STATE_LIVE=100;
  static final int PARTITULE_STATE_DEAD=200;

  //
  ez2_Particule(float px, float py)
  {
    position= new PVector(px, py);

    speed= new PVector(0, 0);

    this.radius=10.0;
    this.lives=2.0f;
    this.state=PARTITULE_STATE_DEAD;
    this.timer=0.0f;
    this.col_alpha=255;
    this.r=50;
    this.g=50;
    this.b=50;
  }

  //
  void setColor(int r, int g, int b)
  {
    this.r=r;
    this.g=g;
    this.b=b;
  }

  //
  boolean isDead()
  {
    if (state==PARTITULE_STATE_DEAD)
    {
      return true;
    }
    return false;
  }

  //
  void reset(float xn, float yn )
  {
    position.x=xn;
    position.y=yn;

    lives=random(1, lives);
    timer=0;
    state=PARTICULE_STATE_LIVE;
  }

  //
  void setSpeed(float module, float angle)
  {
    float a=radians(angle);

    speed.x=module*cos(a);
    speed.y=-module*sin(a);
    this.state=PARTICULE_STATE_LIVE;
  }


  //
  void update(float dt)
  {
    if (state==PARTICULE_STATE_LIVE)
    {
      timer+=dt;


      if (timer >lives)
      {
        timer=0;
        state=PARTITULE_STATE_DEAD;
      }
      //
      col_alpha=int(255-(255*timer)/lives);

      position.x+=(speed.x)*dt;
      position.y+=(speed.y)*dt;
    }
  }

  //
  void render()
  {
    noStroke();
    //fill(50, 50, 50, col_alpha);
    fill(this.r, this.g, this.b, col_alpha);
    ellipse(position.x, position.y, radius, radius);
  }
}
//end
//*******************
//*******************
/**
 class ezGenerator ezLIb
 */

class ez2_Generator
{
  final int NB_PARTICULES=100;
  private ez2_Particule[] particules=null;
  private boolean go;
  private PVector position=null;

  private float speed_min=0;
  private float speed_max=0;
  private float deg_min=0;
  private float deg_max=0;

  //
  ez2_Generator(float xp, float yp, float speed_min, float speed_max, float deg_min, float deg_max)
  {
    this.position= new PVector(xp, yp);

    this.speed_min=speed_min;
    this.speed_max=speed_max;
    this.deg_min=deg_min;
    this.deg_max=deg_max;

    this.go=false;
    particules= new ez2_Particule[NB_PARTICULES];

    for (int i=0; i <NB_PARTICULES; i++)
    {
      particules[i]= new ez2_Particule(xp, yp);
      particules[i].setSpeed(random(speed_min, speed_max), random(deg_min, deg_max));
    }
  }

  //
  void setColor(int r, int g, int b)
  {
    for (int i=0; i <NB_PARTICULES; i++)
    {
      particules[i].setColor(r, g, b);
    }
  }

  //
  void setAngleMinMax(float deg_min, float deg_max) {
    this.deg_min=deg_min;
    this.deg_max=deg_max;
  }

  //
  void setSpeedMinMax(float speed_min, float speed_max) {
    this.speed_min= speed_min;
    this.speed_max=speed_max;
  }

  //
  void begin()
  {
    this.go=true;
  }

  //
  void move(float xp, float yp)
  {
    position.x=xp;
    position.y=yp;
  }

  //
  void stop()
  {
    this.go=false;
  }

  //
  void update(float dt)
  {
    if (go==true && particules.length >0)
    {
      for (int i=0; i <NB_PARTICULES; i++)
      {
        particules[i].update(dt);

        if (particules[i].isDead()==true)
        {
          particules[i].reset(position.x, position.y);
          particules[i].setSpeed(random(speed_min, speed_max), random(deg_min, deg_max));
        }
      }
    }
  }

  //
  void render()
  {
    if (go==true && particules.length >0)
    {
      for (ez2_Particule item : particules)
      {
        item.render();
      }
    }
  }
}
//end
