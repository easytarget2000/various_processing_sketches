/**
 * Constants
 */

/**
 * Values
 */

/**
 * Lifecycle
 */

void setup() {
  //size(800, 600, P3D);
   //fullScreen(P3D);
   fullScreen(P3D, 2);
  background(0);
  
  lights();
}

void draw() {
  background(0);

  noStroke();
  //stroke(0xFF00FF00);

  final int numofRows = 16;
  final int numOfColumns = 64;
  final float AngleDelta = TWO_PI / (float) numofRows;

  translate(width * 0.33f, height * 0.33f, 512f);
  //rotateY(PI * 0.002f * millis());
  final float xMovementRotation = millis() / 10000f;
  rotateY(PI * 0.5f);
  //translate(width / 2f, height / 2f, 0f);

  for (int column = 0; column < numOfColumns; column++) {
    for (int row = 0; row < numofRows; row++) {
      if ((row + column) % 2 == 0) {
        fill(0xFFFF00FF);
      } else {
        fill(0xFF000000);
      }

      translate(0f, cos(AngleDelta) * 128f, 0f);
      //pushMatrix();
      rotateX(AngleDelta * xMovementRotation);
      //translate(width / 2f, height / 2f, 0f);
      //popMatrix();

      rect(0f, 0f, 128f, 128f);
    }
    
    translate(128f, 0f, 0f);
  }
}

/*
 * Implementation
 */

void drawCylinder(int sides, float r, float h)
{
  float angle = 360 / sides;
  float halfHeight = h / 2;
  // draw top shape
  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos( radians( i * angle ) ) * r;
    float y = sin( radians( i * angle ) ) * r;
    vertex( x, y, -halfHeight );
  }
  endShape(CLOSE);
  // draw bottom shape
  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos( radians( i * angle ) ) * r;
    float y = sin( radians( i * angle ) ) * r;
    vertex( x, y, halfHeight );
  }
  endShape(CLOSE);
}