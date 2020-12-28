/**
 * Constants
 */

/**
 * Values
 */

private PVector cameraEye;

private PVector cameraCenter;

private boolean changeColor = false;

/**
 * Lifecycle
 */

void setup() {
  size(1080, 1080, P3D);
  // fullScreen();
   //fullScreen(P3D, 2);
  background(0);
    frameRate(60f);

  setupCamera();
}

void draw() {
  //background(0xFFFF00FF);
  //if (random(1f) > 0.99f) {
  //  background(0);
  //}
  
  if (random(1f) > 0.999f) {
    //setupCamera();
  }

  lights();
  //ambientLight(55f, 55f, 0f);

  updateCamera();
  drawGrid();
}

/*
 * Implementation
 */

private void setupCamera() {
  cameraEye = new PVector(
    width / 2f, 
    height / 2f, 
    (height/ 2f) / tan(PI * 30f / 180f)
    );

  cameraCenter = new PVector(
    width / 2f, 
    height / 2f, 
    -5000f
    );
}

private void updateCamera() {

  cameraEye.x += 0.3f;
  cameraEye.y += 0.2f;
  cameraEye.z -= 2f;

  camera(
    cameraEye.x, cameraEye.y, cameraEye.z, 
    cameraCenter.x, cameraCenter.y, cameraCenter.z, 
    0, 1, 0
    );
}

private void drawGrid() {
  //noFill();
  //stroke(0xFFFFFFFF);

  if (random(1f) > 0.9f) {
    changeColor = !changeColor;
  }

  final float colorProbability;
  if (random(1f) > 0.9f) {
    colorProbability = 0.95f;
  } else {
    colorProbability = 0.5f;
  }

  noStroke();

  final int gridSizeX = 24;
  final int gridSizeY = 24;

  final float gridDistanceX = 48f + random(0.1f);
  final float gridDistanceY = 48f + random(0.1f);

  translate(
    (gridSizeX * gridDistanceX) / 2f, 
    (gridSizeY * gridDistanceY) / 4f, 
    0f
    );

  fill(0xFFd3d3d3);

  for (int planeCounter = 0; planeCounter < 24; planeCounter++) {

    pushMatrix();
    for (int gridX = 0; gridX < gridSizeX; gridX++) {
      pushMatrix();
      for (int gridY = 0; gridY < gridSizeY; gridY++) {

        if (changeColor) {
          if (random(1f) > colorProbability) {
            fill(0xFFcccccc);
          } else {
            fill(0xFFd3d3d3);
          }
        }
        translate(0f, gridDistanceY, 0f);
        box(32f, 32f, 128f);
      }
      popMatrix();
      translate(gridDistanceX, 0f, 0f);
    }
    popMatrix();
    translate(0f, 0f, -192f);
  }
}
