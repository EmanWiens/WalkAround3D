class Gallary {
  private int[] gridSize;
  private ArrayList<Exhibit> e;
  private boolean lookLeft = false, lookRight = false;
  private boolean moveForward = false, moveBackward = false;
  private float[] lookAngle = new float[] { 0, 90 };
  private float[] position;
  private final float moveSpeed = .1;
  private final float collisionDist = 1;
  private final float lookSpeed = 3;
  private boolean correctUpDown = false;

  public Gallary(int[] gridSize) {
    this.gridSize = gridSize;
    e = new ArrayList<Exhibit>();
    position = new float[] { gridSize[0] / 2, 0, gridSize[1] / 2 };
    setupGrid();
  }

  void draw() {
    // view
    rotateX(radians(lookAngle[0]));
    rotateY(radians(lookAngle[1]));
    translate(0, -1, distScale);
    translate(-position[0], 0, -position[2]);
    //println(lookAngle[0], position[0], position[2]);

    for (int x = 0; x < gridSize[0]; x++) {
      for (int z = 0; z < gridSize[1]; z++) {
        drawFloor(x, z);

        Exhibit temp = findExhibit(x, z);

        if (edgeBound(x, z)) {
          pushMatrix();
          translate(x / gridSize[0], 0, z / gridSize[1]);
          drawWallRect(x, z);

          popMatrix();
        } else if (/*and exhibit*/temp != null && !edgeBound(x, z)) {
          // "exhibit"
          pushMatrix();
          translate(x, temp.y, z);
          rotateY(radians(temp.angle));

          if (x % 2 == 0) 
            temp.drawTetra();
          else 
          temp.drawBox();

          popMatrix();
          temp.updateY();
          temp.updateAngle();
        }
      }
    }

    updateMove();
    checkForWallCollision();
    checkForExhibitCollision();
  }

  Exhibit findExhibit(int x, int z) {
    Exhibit found = null;

    for (int i = 0; i < e.size(); i++) {
      if (e.get(i).sameCoord(x, z))
        found = e.get(i);
    }

    return found;
  }

  void checkForExhibitCollision() {
    float move = 1;
    if (moveBackward) 
      move = -1;

    float moveX = position[0], moveZ = position[2];
    Exhibit temp = null;

    for (int i = 0; i < e.size(); i++) {
      if (moveX > (e.get(i).x - collisionDist) && moveX < (e.get(i).x + collisionDist) && 
        moveZ > (e.get(i).z - collisionDist) && moveZ < (e.get(i).z + collisionDist)) {
        temp = e.get(i);
      }
    }

    if (temp != null) {
      while ((moveX > (temp.x - collisionDist) && moveX < (temp.x + collisionDist)) && (moveZ > (temp.z - collisionDist) && moveZ < (temp.z + collisionDist))) {
        moveX -= (sin(radians((lookAngle[1]))))*move*moveSpeed;
        moveZ += (cos(radians((lookAngle[1]))))*move*moveSpeed;
      }

      position[0] = moveX;
      position[2] = moveZ;
    }
  }

  void checkForWallCollision() {
    if (position[0] < collisionDist)
      position[0] = collisionDist;
    else if (position[0] > gridSize[0]-1-collisionDist)
      position[0] = gridSize[0]-1-collisionDist;

    if (position[2] < collisionDist)
      position[2] = collisionDist;
    else if (position[2] > gridSize[1]-1-collisionDist)
      position[2] = gridSize[1]-1-collisionDist;
  }

  void updateMove() {
    if (moveForward)
      evalMove();
    else if (moveBackward)
      evalMove();
  }

  void evalMove() {
    int move = 1;
    if (moveBackward)
      move = -1;

    position[0] += (sin(radians((lookAngle[1]))))*move*moveSpeed;
    position[2] -= (cos(radians((lookAngle[1]))))*move*moveSpeed;
  }

  void moveForward() {
    moveForward = true;
    moveBackward = false;
  }

  void moveBackward() {
    moveBackward = true;
    moveForward = false;
  }

  void stopForward() {
    moveForward = false;
    moveBackward = false;
  }

  void stopBackward() {
    moveBackward = false;
    moveForward = false;
  }

  void lookRight() {
    lookRight = true;
    lookLeft = false;
    correctUpDown = true;
  }

  void lookLeft() {
    lookLeft = true;
    lookRight = false;
    correctUpDown = true;
  }

  void drawFloor(int x, int z) {
    beginShape(QUADS);
    // checkerboard
    if ((x + z) % 2 == 0) {
      fill(0.2, 0.2, 0.7);
    } else {
      fill(0.5, 0.5, 0.2);
    }
    float u = tm.getImg("floor").width;
    float v = tm.getImg("floor").height;

    texture(tm.getImg("floor"));
    vertex(x-0.5, 0, z-0.5, 0, 0);
    vertex(x+0.5, 0, z-0.5, u, 0);
    vertex(x+0.5, 0, z+0.5, u, v);
    vertex(x-0.5, 0, z+0.5, 0, v);
    endShape();
  }

  void drawWallRect(int x, int z) {
    beginShape(QUADS);
    // float fraction = tm.getImg("wall").width / tm.getImg("wall").height;
    float u = tm.getImg("wall").width / 2;
    float v = tm.getImg("wall").height;

    noStroke();
    fill(1, 1, 1);
    texture(tm.getImg("wall"));
    vertex(x-0.5, 2, z+0.5, 0, 0);
    vertex(x+0.5, 2, z+0.5, u, 0);
    vertex(x+0.5, 0, z+0.5, u, v);
    vertex(x-0.5, 0, z+0.5, 0, v);

    texture(tm.getImg("wall"));
    vertex(x+0.5, 2, z-0.5, 0, 0);
    vertex(x-0.5, 2, z-0.5, u, 0);
    vertex(x-0.5, 0, z-0.5, u, v);
    vertex(x+0.5, 0, z-0.5, 0, v);

    texture(tm.getImg("wall"));
    vertex(x-0.5, 2, z-0.5, 0, 0);
    vertex(x-0.5, 2, z+0.5, u, 0);
    vertex(x-0.5, 0, z+0.5, u, v);
    vertex(x-0.5, 0, z-0.5, 0, v);

    texture(tm.getImg("wall"));
    vertex(x+0.5, 2, z+0.5, 0, 0);
    vertex(x+0.5, 2, z-0.5, u, 0);
    vertex(x+0.5, 0, z-0.5, u, v);
    vertex(x+0.5, 0, z+0.5, 0, v);
    endShape();
  }

  boolean edgeBound(int i, int j) {
    return i == 0 || j == 0 || i == gridSize[0]-1 || j == gridSize[1]-1;
  }

  void updateLook() {
    if (lookRight) {
      lookAngle[1]-= lookSpeed;

      if (lookAngle[1] % 90 < lookSpeed)
        lookRight = false;
    } else if (lookLeft) {
      lookAngle[1]+= lookSpeed;

      if (lookAngle[1] % 90 < lookSpeed)
        lookLeft = false;
    }
    
    if (correctUpDown) {
      if (lookAngle[0] > 0)
        lookAngle[0]--;
      else if (lookAngle[0] < 0)
        lookAngle[0]++;
      
      if (abs(lookAngle[0]) % 90 < 2) {
        correctUpDown = false;
      }
    }
  }

  void setupGrid() {
    int count =0;
    for (int i = 0; i < gridSize[0]; i++) {
      for (int j = 0; j < gridSize[1]; j++) {
        if (i % 5 == 2 && j % 5 == 2) {
          e.add(new Exhibit(i, j, count));
          count++;
        }
      }
    }
  }
}
