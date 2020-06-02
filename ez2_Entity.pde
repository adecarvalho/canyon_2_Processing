/**
 Class Entity for ezLib2
 version 2020-05-05
 */
/**
 CircBounds for ezLib
 */
class ez2_CircBounds {
  float xc=0;
  float yc=0;

  float radius=0;
  float ri=0;

  ez2_CircBounds(float xc, float yc, float radius)
  {
    this.xc=xc;
    this.yc=yc;
    this.radius= radius;
  }

  //
  void update(float xc, float yc) {
    this.xc=xc;
    this.yc= yc;
  }
  
  //
  void inflate(float ri)
  {
    this.ri=ri;
    this.radius-= this.ri;
  }

  //
  boolean overlap(ez2_CircBounds target) {
    //
    float target_xc= target.xc;
    float target_yc= target.yc;
    float target_radius=target.radius;

    float a=(target_xc- xc)*(target_xc-xc);

    float b=(target_yc- yc)*(target_yc-yc);

    float dis=a+b;
    //
    if (dis < (target_radius+ this.radius)*(target_radius+ this.radius))
    {
      return true;
    }

    return false;
  }

  //
  void render() {
    noFill();
    strokeWeight(2);
    stroke(255,255,0);
    ellipse(this.xc, this.yc, this.radius*2, this.radius*2);
  }
}
//************************
//************************
/**
 RecBounds for ezLib
 */
class ez2_RecBounds {
  float xp;
  float yp;

  float xi;
  float yi;

  float _width;
  float _height;


  ez2_RecBounds(float px, float py, float w, float h)
  {
    this.xp=px;
    this.yp=py;
    this._width=w;
    this._height=h;
    this.xi=0;
    this.yi=0;
  }

  //
  boolean collide(ez2_RecBounds target)
  {
    //cas B
    if (this.xp > target.xp && this.xp < (target.xp + target._width) &&
      this.yp > target.yp && this.yp < (target.yp + target._height))
      return true;

    //cas A
    if ((this.xp + this._width) > target.xp && (this.xp + this._width) < (target.xp + target._width)
      && this.yp > target.yp && this.yp < (target.yp + target._height))
      return true;

    //cas C
    if (this.xp > target.xp && this.xp < (target.xp + target._width) && (this.yp + this._height) > target.yp &&
      (this.yp + this._height) < (target.yp + target._height))
      return true;

    //cas D
    if ((this.xp + this._width) > target.xp && (this.xp + this._width) < (target.xp + target._width) 
      && (this.yp + this._height) > target.yp && (this.yp + this._height) < (target.yp + target._height))
      return true;
    //
    return false;
  }

  //
  void update(float xp, float yp)
  {
    this.xp=xp;
    this.xp=this.xp+this.xi;

    this.yp=yp;
    this.yp=this.yp+this.yi;
  }

  //
  void render()
  {
    strokeWeight(1);
    stroke(250, 0, 250);
    noFill();
    rect(this.xp, this.yp, this._width, this._height);
  }

  //
  void inflate(float xi, float yi)
  {
    this.xi=xi;
    this.yi=yi;
    this._width= this._width- 2*this.xi;
    this._height= this._height-2*this.yi;
  }
}
// end RecBounds

//****************************
class ez2_Entity {
  //
  private PVector position;
  private PVector velocity;

  private float angle=0;
  private float speedModule=0;

  private PImage img;
  private int dim_width;
  private int dim_height;

  private ez2_RecBounds recbounds=null;
  private ez2_CircBounds circBounds= null;

  private int state;

  ez2_Entity(float px, float py, int pw, int ph)
  {
    this.position= new PVector(px, py);
    this.velocity= new PVector(0, 0);
    this.img=null;

    this.dim_width=pw;
    this.dim_height=ph;

    //bounds rect
    this.recbounds= new ez2_RecBounds(this.position.x, this.position.y, this.dim_width, this.dim_height);

    //bounds circ
    this.circBounds= new ez2_CircBounds(this.getCenterX(), this.getCenterY(), this.dim_width/2);

    //state
    this.state=0;
  }

  ez2_Entity(float px, float py, String imagePath) {
    this.position= new PVector(px, py);
    this.velocity= new PVector(0, 0);

    this.img=null;
    if (imagePath != "")
    {
      this.img= loadImage(imagePath);
      this.dim_width=img.width;
      this.dim_height=img.height;
    }
    //utilise rectangle violet
    else
    {
      this.dim_width=40;
      this.dim_height=40;
    }

    //bounds
    this.recbounds= new ez2_RecBounds(this.position.x, this.position.y, this.dim_width, this.dim_height);

    //bounds circ
    this.circBounds= new ez2_CircBounds(this.getCenterX(), this.getCenterY(), this.dim_width/2);

    //state
    this.state=0;
  }
  //
  ez2_Entity(float px, float py, PImage image) {
    //
    this.position= new PVector(px, py);
    this.velocity= new PVector(0, 0);

    this.img=null;
    if (image!= null)
    {
      this.img= image;
      this.dim_width=img.width;
      this.dim_height=img.height;
    }
    //utilise rectangle violet
    else
    {
      this.dim_width=40;
      this.dim_height=40;
    }

    //bounds
    this.recbounds= new ez2_RecBounds(this.position.x, this.position.y, this.dim_width, this.dim_height);

    //bounds circ
    this.circBounds= new ez2_CircBounds(this.getCenterX(), this.getCenterY(), this.dim_width/2);

    //state
    this.state=0;
  }

  //
  void setImage(String imagePath)
  {
    this.img= loadImage(imagePath);
    this.dim_width=img.width;
    this.dim_height=img.height;
    this.recbounds= new ez2_RecBounds(this.position.x, this.position.y, this.dim_width, this.dim_height);
  }

  //
  void setImage(PImage img)
  {
    this.img= img;
    this.dim_width=img.width;
    this.dim_height=img.height;
    this.recbounds= new ez2_RecBounds(this.position.x, this.position.y, this.dim_width, this.dim_height);
  }

  //
  PImage getImage() {
    return this.img;
  }

  //
  void setAngle(float amt) {
    this.angle=amt;
  }

  //
  float getSpeedModule() {
    return this.speedModule;
  }

  //
  float getAngle() {
    return this.angle;
  }

  //
  int getState()
  {
    return this.state;
  }

  //
  void setState(int state)
  {
    this.state=state;
  }

  //
  float getWidth()
  {
    return dim_width;
  }

  //
  float getHeight()
  {
    return dim_height;
  }

  //
  float getLeft() {
    return this.position.x;
  }

  //
  void setPosition(float xp, float yp)
  {
    this.position.x=xp;
    this.position.y=yp;
  }

  //
  void setPosition(PVector pv)
  {
    this.position.x=pv.x;
    this.position.y=pv.y;
  }

  //
  void setPositionX(float x)
  {
    this.position.x=x;
  }

  //
  void setPositionY(float y)
  {
    this.position.y=y;
  }

  //
  PVector getPosition()
  {
    return this.position;
  }

  //
  float getPositionX()
  {
    return this.position.x;
  }

  //
  float getPositionY()
  {
    return this.position.y;
  }

  //
  void setCenterX(float centerX)
  {
    this.position.x= centerX-(this.dim_width/2);
  }

  //
  void setCenterY(float centerY)
  {
    this.position.y= centerY-(this.dim_height/2);
  }

  //
  float getCenterX()
  {
    return (this.position.x+this.dim_width/2);
  }

  //
  float getCenterY()
  {
    return (this.position.y+this.dim_height/2);
  }

  //
  void setLeft(float left) {
    this.position.x=left;
  }

  //
  float getRight() {
    return (this.position.x+this.dim_width);
  }

  //
  void setRight(float right) {
    this.position.x=right- this.dim_width;
  }

  //
  float getTop() {
    return this.position.y;
  }

  //
  void setTop(float top) {
    this.position.y=top;
  }

  //
  float getBottom() {
    return (this.position.y+this.dim_height);
  }

  //
  void setBottom(float bottom)
  {
    this.position.y=bottom- this.dim_height;
  }

  //
  void setSpeeds(float dx, float dy)
  {
    this.velocity.x=dx;
    this.velocity.y=dy;
  }

  //
  void setSpeedX(float dx)
  {
    this.velocity.x=dx;
  }

  //
  void setSpeedY(float dy)
  {
    this.velocity.y=dy;
  }

  //
  float getSpeedX()
  {
    return this.velocity.x;
  }

  //
  float getSpeedY()
  {
    return this.velocity.y;
  }

  //
  PVector getSpeed() {
    return this.velocity;
  }

  //recBounds collisions
  boolean isCollide(ez2_Entity target)
  {
    if (this.recbounds.collide(target.recbounds))
    {
      return true;
    }
    return false;
  }

  //CircBounds collisions
  boolean isOverlap(ez2_Entity target)
  {
    if (this.circBounds.overlap(target.circBounds))
    {
      return true;
    }
    return false;
  }

  //
  void update(float dt) {
    this.position.add(this.velocity.x*dt, this.velocity.y*dt);

    this.recbounds.update(this.position.x, this.position.y);

    circBounds.update(this.getCenterX(), this.getCenterY());
  }

  //
  void render() {
    imageMode(CORNER);

    if (this.img != null)
    {
      pushMatrix();
      translate(this.getCenterX(), this.getCenterY());
      rotate(this.angle);
      //image(this.img, this.position.x, this.position.y);
      image(this.img, -dim_width/2, -dim_height/2);
      popMatrix();
    } 
    //
    else
    {
      pushMatrix();
      fill(255, 0, 255, 100);
      noStroke();
      translate(this.getCenterX(), this.getCenterY());
      rotate(this.angle);
      //rect(this.position.x, this.position.y, this.dim_width, this.dim_height);
      rect(0, 0, this.dim_width, this.dim_height);
      popMatrix();
    }
  }

  //
  void renderDebug()
  {
    this.recbounds.render();
    this.circBounds.render();
  }

  //
  void inflate(float xi, float yi)
  {
    this.recbounds.inflate(xi, yi);
    this.recbounds.update(this.position.x, this.position.y);
  }
  //
  void inflateCircBound(float ri)
  {
    circBounds.inflate(ri);
  }
}
//end class Entity
