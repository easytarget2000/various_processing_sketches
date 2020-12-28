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
  //size(800, 600, P3D);
  // fullScreen();
  fullScreen(P3D, 2);
  background(0);
  frameRate(60f);
  setupCamera();
}

void draw() {

  if (random(1f) > 0.2f) {
    background(0);
  }

  //if (random(1f) > 0.9f) {
  //  return;
  //}

  updateCamera();
  setLights();
  drawSpheres();

  if (random(1f) > 0.97f) {
    setRandomCamereEyeZVelocity();
  }

  if (random(1f) > 0.97f) {
    setRandomSphereDetail();
  }
}

void keyPressed() {

  setupCamera();
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

  //cameraEyeVelocity = new PVector(8f, -1f, -4f);
  cameraEyeVelocity = new PVector(0f, 0f, -16f);

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

private void updateCamera() {
  cameraEye = PVector.add(cameraEye, cameraEyeVelocity);

  if (cameraEye.z < initialCameraEye.z / 2f) {
    cameraEye.z = initialCameraEye.z;
  }

  //println("" + cameraEyeVelocity.z);

  camera(
    cameraEye.x, cameraEye.y, cameraEye.z, 
    cameraCenter.x, cameraCenter.y, cameraCenter.z, 
    cameraUp.x, cameraUp.y, cameraUp.z
    );

  if (random(1f) > 0.9f) {
    resetCameraEyeXY();
  }
}

private void drawSpheres() {
  //stroke(0x00FFFFFF);
  if (random(1f) > 0.5f) {
    stroke(0x22FFFFFF);
  } else {
    stroke(0x22FF00FF);
  }
  noFill();
  //fill(0xFFAAAAAA);
  //noStroke();

  translate(width / 2f, height / 2f, 0f);
  float sphereSize = min(width, height) * 4f;

  for (int i = 0; i < 8; i++) {
    sphere(sphereSize);
    if (i % 3 == 0) {
      fill(0x88880088);
    } else {
      noFill();
    }
    sphereSize *= 0.5f;
  }
}

private void setRandomCamereEyeZVelocity() {
  cameraEyeVelocity.z = -(0.5f + random(4f));
}

private void resetCameraEyeXY() {
  cameraEye.x = initialCameraEye.x;
  cameraEye.y = initialCameraEye.y;
}

private void setRandomSphereDetail() {
  sphereDetail((int) (6f + random(32f)));
}
