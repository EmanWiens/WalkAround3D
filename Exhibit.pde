class Exhibit {
  private float x, y, z;
  private float angle;
  private int imageIndex;
  private final float maxY = .35, minY = .05;
  private boolean moveUp;
  private final float bobSpeed = .0025, angleSpeed = .5;

  public Exhibit(float x, float z, int i) {
    this.x = x;
    this.z = z;
    imageIndex = i % tm.exhibitImgCount();
    angle = 0;
    y = minY;
    moveUp = true;
  }

  public void updateAngle() {
    angle += angleSpeed;
  }
  
  void drawTetra() {
    beginShape(QUADS);
    noStroke();
    PImage img = tm.getImg(imageIndex);
    float u = float(img.width) /2; 
    float v = img.height;
    float sizeY = float(img.height) / height;
    float sizeX = float(img.width) / width;
    float sizeZ = sizeX;

    while (sizeX > .5) {
      sizeY = .9 * sizeY;
      sizeX = .9 * sizeX;
      sizeZ = .9 * sizeZ;
    }
    
    beginShape(TRIANGLES);
    fill(1, 1, 1);
    texture(img);
    float center = (sizeX - sizeZ) / 2;
    vertex(-sizeX, 0, +sizeZ, 0, v);
    vertex(+center, sizeY, +center, u, 0);
    vertex(0, 0, +sizeZ, u, v);
    
    vertex(0, 0, +sizeZ, u, v);
    vertex(+center, sizeY, +center, u, 0);
    vertex(+sizeX, 0, +sizeZ, 2*u, v);

    
    vertex(+sizeX, 0, +sizeZ, 0, v);
    vertex(+center, sizeY, +center, u, 0);
    vertex(+sizeX, 0, 0, u, v);
    
    vertex(+sizeX, 0, 0, u, v);
    vertex(+center, sizeY, +center, u, 0);
    vertex(+sizeX, 0, -sizeZ, 2*u, v);
    
    
    vertex(+sizeX, 0, -sizeZ, 0, v);
    vertex(+center, sizeY, +center, u, 0);
    vertex(0, 0, -sizeZ, u, v);
    
    vertex(0, 0, -sizeZ, u, v);
    vertex(+center, sizeY, +center, u, 0);
    vertex(-sizeX, 0, -sizeZ, 2*u, v);
    
    
    vertex(-sizeX, 0, -sizeZ, 0, v);
    vertex(+center, sizeY, +center, u, 0);
    vertex(-sizeX, 0, 0, u, v);
    
    vertex(-sizeX, 0, 0, u, v);
    vertex(+center, sizeY, +center, u, 0);
    vertex(-sizeX, 0, +sizeZ, 2*u, v);
    endShape();
    

    beginShape(QUADS);
    PImage coverImg = tm.getImg("cover");
    u = img.width;
    v = img.height;
        
    fill(1, 1, 1);
    texture(coverImg);
    vertex(-sizeX, 0, sizeZ, 0, 0);
    vertex(sizeX, 0, sizeZ, u, 0);
    vertex(sizeX, 0, -sizeZ, u, v);
    vertex(-sizeX, 0, -sizeZ, 0, v);

    endShape();
  }

  void drawBox() {
    beginShape(QUADS);
    noStroke();
    PImage img = tm.getImg(imageIndex);
    float u = img.width;
    float v = img.height;
    float sizeY = float(img.height) / height;
    float sizeX = float(img.width) / width;
    float sizeZ = sizeX;

    while (sizeX > .5) {
      sizeY = .9 * sizeY;
      sizeX = .9 * sizeX;
      sizeZ = .9 * sizeZ;
    }

    fill(1, 1, 1);
    texture(img);
    vertex(-sizeX, sizeY, +sizeZ, 0, 0);
    vertex(+sizeX, sizeY, +sizeZ, u, 0);
    vertex(+sizeX, 0, +sizeZ, u, v);
    vertex(-sizeX, 0, +sizeZ, 0, v);

    texture(img);
    vertex(+sizeX, sizeY, -sizeZ, 0, 0);
    vertex(-sizeX, sizeY, -sizeZ, u, 0);
    vertex(-sizeX, 0, -sizeZ, u, v);
    vertex(+sizeX, 0, -sizeZ, 0, v);

    texture(img);
    vertex(-sizeX, sizeY, -sizeZ, 0, 0);
    vertex(-sizeX, sizeY, +sizeZ, u, 0);
    vertex(-sizeX, 0, +sizeZ, u, v);
    vertex(-sizeX, 0, -sizeZ, 0, v);

    texture(img);
    vertex(+sizeX, sizeY, +sizeZ, 0, 0);
    vertex(+sizeX, sizeY, -sizeZ, u, 0);
    vertex(+sizeX, 0, -sizeZ, u, v);
    vertex(+sizeX, 0, +sizeZ, 0, v);
    endShape();
    
    beginShape(QUADS);
    PImage coverImg = tm.getImg("cover");
    u = img.width;
    v = img.height;
    
    fill(1, 1, 1);
    texture(coverImg);
    vertex(-sizeX, sizeY, sizeZ, 0, 0);
    vertex(sizeX, sizeY, sizeZ, u, 0);
    vertex(sizeX, sizeY, -sizeZ, u, v);
    vertex(-sizeX, sizeY, -sizeZ, 0, v);
    
    fill(1, 1, 1);
    texture(coverImg);
    vertex(-sizeX, 0, sizeZ, 0, 0);
    vertex(sizeX, 0, sizeZ, u, 0);
    vertex(sizeX, 0, -sizeZ, u, v);
    vertex(-sizeX, 0, -sizeZ, 0, v);

    endShape();
  }

  void updateY() {
    if (moveUp) {
      y += bobSpeed;

      if (y > maxY) 
        moveUp = false;
    } else if (!moveUp) {
      y -= bobSpeed;

      if (y < minY) 
        moveUp = true;
    }
  }

  public boolean sameCoord(int x, int z) {
    return (int)this.x == x && this.z == z;
  }
}
