/**
 Class InputManager for EzLib2
 version 2020-05-04
 */

class ez2_InputManager
{
  private boolean tabKeyPressed[];
  private boolean tabKeyReleased[];

  private PVector mousePosition=null;
  private boolean mouseClicked=false;

  private final int nbKey=500;

  ez2_InputManager()
  {
    tabKeyPressed= new boolean[nbKey];
    tabKeyReleased= new boolean[nbKey];

    mousePosition= new PVector();
    mouseClicked= false;

    for (int i=0; i< nbKey; i++)
    {
      tabKeyPressed[i]=false;
      tabKeyReleased[i]=false;
    }
  }

  //
  void update()
  {
    for (int i=0; i< nbKey; i++)
    {
      tabKeyPressed[i]=false;
      tabKeyReleased[i]=false;
    }
  }

  //
  void setMouseClicked(float x, float y)
  {
    mousePosition.x=x;
    mousePosition.y=y;
    mouseClicked=true;
  }

  //
  void setMouseReleased(float x, float y)
  {
    mousePosition.x=x;
    mousePosition.y=y;
    mouseClicked=false;
  }

  //
  boolean isMouseClicked()
  {
    return mouseClicked;
  }

  //
  PVector getMousePosition() {
    return mousePosition;
  }

  //
  float getMousePositionX() {
    return mousePosition.x;
  }

  //
  float getMousePositionY() {
    return mousePosition.y;
  }

  //
  void setKeyboardPressed(int keycode)
  {
    tabKeyPressed[keycode]=true;
  }

  //
  void setKeyboardReleased(int keycode)
  {
    tabKeyReleased[keycode]=true;
  }

  //
  boolean isKeyPressed(int keycode)
  {
    return tabKeyPressed[keycode];
  }

  //
  boolean isKeyReleased(int keycode)
  {
    return tabKeyReleased[keycode];
  }
}
//
