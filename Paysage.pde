
class Paysage
{
  private PVector position;
  
  private PImage img=null;
  
  private int screenWidth=0;
  private int screenHeight=0;

  private int speed=1;
  
  //
  Paysage(int screenWidth, int screenHeight)
  {
    this.screenWidth= screenWidth;
    this.screenHeight= screenHeight;
    
    position= new PVector(0,0);
    
    img= gAssetsManager.getImage("paysage");
  }

  //
  void update(float dt)
  {
    position.x -=speed;
    
    if(position.x <-screenWidth)
    {
      position.x=0;
    }
  }

  //
  void render()
  {
    if (img!= null)
    {
      image(img, position.x, position.y);
    }
  }
}
//end
