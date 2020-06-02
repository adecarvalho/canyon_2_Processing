/*
class ez_AssetsManager for ezLib2
  version 2020-05-04
 */

public class ez2_AssetsManager {

  private HashMap<String, PImage> textures = null;
  private HashMap<String, AudioSample> sounds= null;
  private HashMap<String, PFont> fonts= null;

  private Minim minim=null;

  //
  ez2_AssetsManager(Minim _minim) {
    minim=_minim;
    textures= new HashMap<String, PImage>();
    sounds= new HashMap<String, AudioSample>();
    fonts= new HashMap<String, PFont>();
  }

  //
  void putImage(String label, String path) {
    textures.put(label, loadImage(path));
  }

  //
  void putSound(String label, String path, int bufferSize) {
    sounds.put(label, minim.loadSample(path, bufferSize));
  }


  //
  void putFont(String label, String path, int size ) {
    fonts.put(label, createFont(path, size));
  }

  //
  PFont getFont(String label) {
    try {
      return fonts.get(label);
    } 
    catch(Exception e) {
      return null;
    }
  }

  

  //
  AudioSample getSound(String label) {

    try {
      return sounds.get(label);
    } 
    catch(Exception e) {
      println(e);
      return null;
    }
  }



  //
  PImage getImage(String label) {
    try {
      return textures.get(label);
    }
    catch(Exception e) {
      println(e);
      return null;
    }
  }
}
