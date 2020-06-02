/**
 Stage Manager for ezLib2
 version 2020-05-04
 */

//
class ez2_StageManager {

  private Stack<ez2_Stage> stack=null; 
  private ez2_Stage current=null;


  ez2_StageManager() {
    stack= new Stack<ez2_Stage>();
  }

  //**********************
  void addStage(ez2_Stage stage)
  {
    stack.push(stage);
    current= stack.peek();
    current.onEnter(null);
  }

  //*************
  void popStage()
  {
    if (stack.isEmpty()==false)
    {
      current=stack.pop();
      current.onExit();
    }
  }

  //*****************************
  void changeStage(ez2_Stage newStage, StringDict message)
  {
    if (stack.isEmpty()==false)
    {
      current.onExit();
      stack.pop();
      //
      stack.push(newStage);
      current=stack.peek();
      current.onEnter(message);
    }
  }

  //*******************
  void update(float dt)
  {
    current.update(dt);
  }

  //***********
  void render()
  {
    current.render();
  }
}
//end
