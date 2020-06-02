/**
 class ez_MoveLabel for ezlib2
  version 2020-05-04
 */

class ez2_MoveLabel {
  private PFont font;
  private String txt;
  private color txt_color;
  private PVector position;
  private PVector positionFinal;
  private PVector velocity;

  ez2_MoveLabel(String fontpath, int size)
  {
    font= createFont(fontpath, size);
    txt_color= color(255, 255, 0);
    txt="";
  }
  //
  ez2_MoveLabel(PFont _font)
  {
    font= _font;
    txt_color= color(255, 255, 0);
    txt="";
  }

  //
  void setInitialPosition(float xp, float yp) {
    position= new PVector(xp, yp);
   
  }

  //
  void setSpeeds(float dx, float dy) {
    velocity= new PVector(dx, dy);
    
  }

  //
  void setFinalPosition(float xf, float yf) {
    positionFinal= new PVector(xf, yf);

  }


  //
  void setText(String txt)
  {
    this.txt=txt;
  }
  
  //
  String getText(){
  return this.txt;
  }

  //
  void setColorText(color c)
  {
    this.txt_color=c;
  }

  //
  void update(float dt) {

    position.x+= velocity.x*dt;
    position.y+= velocity.y*dt;

    //limites
    if (velocity.x >0)
    {
      if (position.x >= positionFinal.x)
      {
        velocity.x=0;
      }
    } else {
      if (position.x <= positionFinal.x)
      {
        velocity.x=0;
      }
    }

    //limites en y
    if(velocity.y >0)
    {
      if(position.y >= positionFinal.y)
      {
        velocity.y=0;
      }
    }
    else{
      if(position.y <= positionFinal.y)
      {
        velocity.y=0;
      }
    }
  }

  //
  void render()
  {
    textFont(this.font);
    fill(this.txt_color);
    text(this.txt, position.x, position.y);
  }
}
