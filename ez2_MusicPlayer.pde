/**
 class ez_MusicPlayer for ezlib2
  version 2020-05-04
 */

//
class ez2_MusicPlayer {

  private Minim minim=null;
  private AudioPlayer player=null;


  ez2_MusicPlayer(Minim _minim) {
    this.minim= _minim;
  }

  //
  public void load(String path) {
    player= minim.loadFile(path);
  }

  //
  public void play() {
    if (minim != null)
    {
      player.rewind();
      player.play();
    }
  }

  //
  public void loop() {
    if (minim != null)
    {
      player.rewind();
      player.loop();
    }
  }

  //
  public void pause() {
    if (minim != null && player.isPlaying())
    {
      player.pause();
    }
  }

  //
  public boolean isPlaying() {
    return player.isPlaying();
  }
}
