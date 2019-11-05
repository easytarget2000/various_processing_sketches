/*
Constants
 */

/*
Variables
 */

private ArrayList<Cube> cubes;

private PVector cameraEyeVector;

private PVector cameraEyeVelocityVector;

private PVector cameraCenterVector;

/*
Lifecycle
 */

void setup() {
  //size(800, 600);
  //fullScreen();
  size(1024, 1024, P3D);
  // fullScreen(P3D);
  colorMode(HSB, 1f);

  smooth();

  clearScreen();
  initCamera();
  initCubes();
}

void draw() {
  lights();

  clearScreen();
  setCamera();
  drawCubes();
}

void mousePressed() {
}

/*
Implementations
 */

private void initCamera() {
  cameraEyeVector = new PVector(
    width / 2f, 
    height / 2f, 
    -height * 2f// / tan(PI * 30f / 180f)
    );
  cameraEyeVelocityVector = new PVector(
    0f, 
    0f, 
    -0.1f
    );

  cameraCenterVector = new PVector(
    width / 2f, 
    height / 2f, 
    0f
    );
}

private void clearScreen() {
  background(0);
}

private void fadeClearScreen() {
  noStroke();
  fill(0f, 0f, 0f, 0.1f);
  rect(0f, 0f, width, height);
}

private void initCubes() {
  cubes = new ArrayList<Cube>();
  
  final float cubeSize = width / 8f;
  final float cubeSpacing = cubeSize * 0.66f;
  for (int layer = 0; layer < 8; layer++) {
    final float cubeZ = layer * (cubeSize + cubeSpacing);

    for (int column = 0; column < 8; column++) {
      final float cubeY = column * (cubeSize + cubeSpacing);

      for (int row = 0; row < 8; row++) {
        final float cubeX = row * (cubeSize + cubeSpacing);
        final PVector cubeVector = new PVector(cubeX, cubeY, cubeZ);
        cubes.add(new Cube(cubeVector, cubeSize));
      }
    }
  }
}

private void setCamera() {
  //camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  camera(
    mouseX, 
    mouseY, 
    cameraEyeVector.z, 
    mouseX + 10f, 
    cameraCenterVector.y, 
    cameraCenterVector.z, 
    0f, 
    1f, 
    0f
    );

  cameraEyeVector.add(cameraEyeVelocityVector);
  cameraCenterVector.add(cameraEyeVelocityVector);
}

private void drawCubes() {
  //stroke(0xFFFF0000);
  //noFill();
  noStroke();
  fill(0xE0FFFFFF);

  for (final Cube currentCube : cubes) {
    currentCube.draw_();
  }
}
