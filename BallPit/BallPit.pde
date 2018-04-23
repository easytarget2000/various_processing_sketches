/**
 * Constants
 */

/**
 * Values
 */

private PVector initialCameraEye;

private PVector cameraEye;

private PVector cameraCenter;

private PVector cameraUp;

private PVector cameraEyeVelocity;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080);
  fullScreen(P3D);
  // fullScreen(2);
  background(0);

  sphereDetail(8);
  setupCamera();
  
  colorMode(HSB, 1f);
}

void draw() {
  background(0);

  updateCamera();
  setLights();
  drawBalls();
}

/*
 * Implementation
 */

private void setupCamera() {
  initialCameraEye = new PVector(
    width/2f, 
    height/2f, 
    (height / 2f) / tan(PI * 30f / 180f)
    );

  cameraEye = initialCameraEye;

  cameraCenter = new PVector(
    width/2f, 
    height/2f, 
    0f
    );

  cameraUp = new PVector(0f, 1f, 0f);

  updateCamera();
}

private void setLights() {
  lights();
}

private void drawBalls() {
  final int numOfSpheresPerSide = 12;
    final float numOfSpheresPerPlane = numOfSpheresPerSide * numOfSpheresPerSide;
  final float numOfSpheres = numOfSpheresPerPlane * numOfSpheresPerSide;

  final float sphereSize = min(width, height) / 40f;
  final float sphereDistance = min(width, height) / 16f;

  noFill();

  final float collectionCenterX = (width / 2f) - (sphereDistance * numOfSpheresPerSide / 2f);
  final float collectionCenterY = (height / 2f) - (sphereDistance * numOfSpheresPerSide / 2f);
  translate(collectionCenterX + 32f, collectionCenterY + 40f, -512f);

  for (int zPlane = 0; zPlane < numOfSpheresPerSide; zPlane++) {
    translate(0f, 0f, sphereDistance);
    pushMatrix();
    for (int yRow = 0; yRow < numOfSpheresPerSide; yRow++) {
      translate(random(0.5f), sphereDistance, random(0.5f));
      pushMatrix();
      for (int xColumn = 0; xColumn < numOfSpheresPerSide; xColumn++) {
        final float hue = (xColumn + (yRow * numOfSpheresPerSide) + (zPlane * numOfSpheresPerPlane)) / numOfSpheres; 
        //final float hue = zPlane / (float) numOfSpheresPerSide;
        stroke(hue, 0.5f, 1f, 0.5f);
        sphere(sphereSize);
        translate(sphereDistance, random(1f), random(1f));
      }
      popMatrix();
    }
    popMatrix();
  }
}

private void updateCamera() {
  cameraEye.y = cameraCenter.y + (sin(millis() % 16000 / 16000f * TWO_PI) * 128f);
  cameraEye.x = cameraCenter.x + (sin(millis() % 4000 / 4000f * TWO_PI) * 32f);

  camera(
    cameraEye.x, cameraEye.y, cameraEye.z, 
    cameraCenter.x, cameraCenter.y, cameraCenter.z, 
    cameraUp.x, cameraUp.y, cameraUp.z
    );

  if (random(1f) > 0.9f) {
    resetCameraEyeXY();
  }
}


private void resetCameraEyeXY() {
  cameraEye.x = initialCameraEye.x;
  cameraEye.y = initialCameraEye.y;
}
