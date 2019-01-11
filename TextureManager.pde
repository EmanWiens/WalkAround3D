class TextureManager {
  private PImage[] textures; 
  public static final int imageCount = 8;
  
  public TextureManager() {
    loadImages();
  }
  
  private void loadImages() {
    textures = new PImage[imageCount];
    
    textures[0] = loadImage("assets/wall.jpg");
    textures[1] = loadImage("assets/floor.jpg");
    textures[2] = loadImage("assets/cover.jpg");
    textures[3] = loadImage("assets/cactus.jpg");
    textures[4] = loadImage("assets/tree1.jpg");
    textures[5] = loadImage("assets/tree2.jpg");
    textures[6] = loadImage("assets/butterfly.jpg");
    textures[7] = loadImage("assets/giraffe.jpg");
  }
  
  public PImage getImg(String in) {
    switch (in) {
      case "wall": case "w": return textures[0];
      case "floor": case "f": return textures[1];
      case "cover": return textures[2];
      case "cactus": return textures[3];
      case "tree1": case "t1": return textures[4];
      case "tree2": case "t2": return textures[5];
      case "butterfly": case "b": return textures[6];
      case "giraffe": case "g": return textures[7];
      default: return null;
    }
  }
  
  public int exhibitImgCount() {
    return imageCount - 3;
  }
  
  public PImage getImg(int index) {
      return textures[3 + index];
  }
}
