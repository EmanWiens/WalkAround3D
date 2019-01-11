

final int[] gridSize = new int[] { 30, 30 };
final float maxLookY = 45;
final float distScale = .125;
int VISIBLE = 25;
TextureManager tm;
Gallary g;

void setup() {
  tm = new TextureManager();
  size(800, 640, P3D);
  colorMode(RGB, 1);
  strokeWeight(1);
  g = new Gallary(gridSize);
  
  frustum(-float(width)/height*distScale, float(width)/height*distScale, distScale, -distScale, 2*distScale, VISIBLE);
  resetMatrix();
}

void draw() {
  background(0, 0, 0.1);

  g.updateLook();
  g.draw();
}

void mouseMoved() {
   g.lookAngle[1] += -(pmouseX - mouseX);
   g.lookAngle[0] += -(pmouseY - mouseY);
   
   if (g.lookAngle[0] > maxLookY)
     g.lookAngle[0] = maxLookY;
   else if (g.lookAngle[0] < -maxLookY)
     g.lookAngle[0] = -maxLookY;
}

void keyPressed() {
  switch (key) {
  case 'w':
    g.moveForward();
    break;
  case 'a':
    g.lookRight();
    break;
  case 's':
    g.moveBackward();
    break;
  case 'd':
    g.lookLeft();
    break;
  }
}

void keyReleased() {
  switch (key) {
  case 'w':
    g.stopForward();
    break;
  case 's': 
    g.stopBackward();
    break;
  }
}
