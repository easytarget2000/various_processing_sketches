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
  fullScreen(P3D);
  //fullScreen(P3D, 2);
  background(0);

  lights();
}

void draw() {
  background(0);

  stroke(0xFFFFFFFF);
  point(width / 2f, height / 2f);
  noStroke();

  setCamera();
  //pushMatrix();
  noStroke();

  final int numofRows = 16;
  final int numOfColumns = 64;
  final float AngleDelta = TWO_PI / (float) numofRows;

  rotateY(PI / 2f);
  translate(
    width * 0.5f - 64f, 
    height * 0.5f - 64f, 
    0f
    );
  final float xMovementRotation = millis() / 1000f;

  for (int column = 0; column < numOfColumns; column++) {
    for (int row = 0; row < numofRows; row++) {
      if ((row + column) % 2 == 0) {
        fill(0xFFFFFFFF);
      } else {
        fill(0xFF000000);
      }

      translate(0f, 128f, 0f);
      //pushMatrix();
      rotateX(AngleDelta + xMovementRotation);
      //translate(width / 2f, height / 2f, 0f);
      //popMatrix();

      rect(0f, 0f, 128f, 128f);
    }

    translate(128f, 0f, 0f);
  }

  //popMatrix();
}

/*
 * Implementation
 */

private void setCamera() {
  //camera(
  //  128f, 64f, 64f, 
  //  width / 2f, height / 2f, 0f, 
  //  0f, 1f, 0f
  //  );
}
