/**
 Class Animation sprite for ezLib2
 version 2020-05-04
 */
class Quad {
  int x, y, w, h;

  Quad(int x, int y, int w, int h)
  {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
  }
  //
  void debug()
  {
    println("x= "+x+" y= "+y);
  }
}
//end quads
//
class ez2_Animation
{
  private PImage atlas=null;
  private PImage destination=null;

  private ArrayList<Quad> quads=null;
  private float sprite_width=0;
  private float sprite_height=0;
  private int nbX=0;
  private int nbY=0;
  private int currentFrame=0;
  private float timer=0;
  private boolean go=false;
  private float duration=0;
  private boolean looping=false;

  //
  ez2_Animation(PImage atlas_image, float w_sprite, float h_sprite, float duration, boolean looping)
  {
    quads= new ArrayList<Quad>();
    destination= createImage(int(w_sprite), int(h_sprite), ARGB);

    //atlas= loadImage(atlas_path);
    atlas= atlas_image;

    this.duration=duration;
    this.looping=looping;

    sprite_width=w_sprite;
    sprite_height=h_sprite;

    if (atlas==null)
    {
      println("error load image animation");
    } else
    {
      int w_atlas=atlas.width;
      int h_atlas=atlas.height;

      nbX=int(w_atlas/sprite_width);
      nbY=int(h_atlas/sprite_height);

      currentFrame=0;
      timer=0;

      createQuads();
    }
  }

  //
  ez2_Animation(PImage atlas_image, float w_sprite, float h_sprite)
  {
    this(atlas_image, w_sprite, h_sprite, 0.02f, true);
  }

  //
  void createQuads()
  {
    for (int y=0; y<nbY; y++)
    {
      for (int x=0; x<nbX; x++)
      {
        quads.add(new Quad(x, y, int(sprite_width), int(sprite_height)));
      }
    }
    //
  }

  //
  void play()
  {
    go=true;
  }

  //
  void stop()
  {
    go=false;
    currentFrame=0;
  }

  //
  boolean isPlaying()
  {
    return go;
  }

  //
  void update(float dt)
  {
    if (go && quads.size()>1)
    {

      timer+=dt;

      if (timer >duration)
      {
        timer=0;
        currentFrame++;
        if (currentFrame > quads.size()-1)
        {
          currentFrame=0;
          if (looping==false)
          {
            go=false;
          }
        }
      }
    }
  }

  //
  void render(float x, float y)
  {
    Quad item=quads.get(currentFrame);

    destination.copy(atlas, int(item.x*sprite_width), int(item.y*sprite_height), int(sprite_width), int(sprite_height), 0, 0, int(sprite_width), int(sprite_height));

    //
    image(destination, x, y);
  }
}
//end Animation
