
/**
 Class Label for ezLib2
  version 2020-05-04
 */

class ez2_Label {

  private PFont font;
  private String txt;
  private color txt_color;

  ez2_Label(String fontpath, int size)
  {
    font= createFont(fontpath, size);
    txt_color= color(255, 255, 0);
    txt="";
  }
  //
  ez2_Label(PFont _font)
  {
    font= _font;
    txt_color= color(255, 255, 0);
    txt="";
  }

  //
  void setText(String txt)
  {
    this.txt=txt;
  }

  //
  String getText() {
    return this.txt;
  }

  //
  void setColorText(color c)
  {
    this.txt_color=c;
  }

  //
  void render(float px, float py)
  {
    textFont(this.font);
    fill(this.txt_color);
    text(this.txt, px, py);
  }
}
