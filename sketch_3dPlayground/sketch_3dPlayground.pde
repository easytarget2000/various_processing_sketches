/**
 * Constants
 */

private static final PVector ORIGIN_SHAPE_SIDE_LENGTHS = new PVector(32f, 32f, 32f);

/**
 * Values
 */

private final Shape[] originShapes = new Shape[3]; 

private PVector cameraEye;

private PVector cameraCenter;

private boolean drawFps = false;

private boolean drawOrigin = true;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080, P3D);
  fullScreen(P3D);
  // fullScreen(2);
  setupCamera();
  initOriginShapes();

  background(0);
}

void draw() {
  background(0);
  updateCamera();

  if (drawOrigin) {
    drawOrigin();
  }

  if (drawFps) {
    drawFps();
  }
}

/*
 * Implementation
 */

private void setupCamera() {
  cameraEye = getDefaultCameraEye();
  cameraCenter = getDefaultCameraCenter();
}

private PVector getDefaultCameraEye() {
  return new PVector(
    width / 2f, 
    height / 2f, 
    (height/ 2f) / tan(PI * 30f / 180f)
    );
}

private PVector getDefaultCameraCenter() {
  return new PVector(
    0f, 
    0f, 
    0f
    );
}

private void updateCamera() {

  //cameraEye.x += 0.3f;
  //cameraEye.y += 0.2f;
  //cameraEye.z -= 2f;

  cameraEye.x = mouseX;
  cameraEye.y = mouseY;

  camera(
    cameraEye.x, cameraEye.y, cameraEye.z, 
    cameraCenter.x, cameraCenter.y, cameraCenter.z, 
    0, 1, 0
    );
}

private void drawOrigin() {
  stroke(0xFFFF0000);
  fill(0xFFFF0000);
  line(0f, 0f, 0f, 512f, 0f, 0f);
  originShapes[0].draw_();

  stroke(0xFF00FF00);
  fill(0xFF00FF00);
  line(0f, 0f, 0f, 0f, 512f, 0f);
  originShapes[1].draw_();

  stroke(0xFF0000FF);
  fill(0xFF0000FF);
  line(0f, 0f, 0f, 0f, 0f, 512f);
  originShapes[2].draw_();
}

private void drawFps() {
  fill(0xFF000000);
  noStroke();
  rect(8f, 2f, 48f, 16f);
  fill(0xFFFFFFFF);
  text(int(frameRate) + " FPS", 16f, 16f);
}

private void resetCameraTemporarily() {
  final PVector defaultCameraEye = getDefaultCameraEye();
  final PVector defaultCameraCenter = getDefaultCameraCenter();
  camera(
    defaultCameraEye.x, defaultCameraEye.y, defaultCameraEye.z, 
    defaultCameraCenter.x, defaultCameraCenter.y, defaultCameraCenter.z, 
    0, 1, 0
    );
}

private void initOriginShapes() {
  final PVector xOriginShapePosition = new PVector(512f, 0f, 0f);
  originShapes[0] = new Box(xOriginShapePosition, null, ORIGIN_SHAPE_SIDE_LENGTHS);

  final PVector yOriginShapePosition = new PVector(0f, 512f, 0f);
  originShapes[1] = new Box(yOriginShapePosition, ORIGIN_SHAPE_SIDE_LENGTHS);

  final PVector zOriginShapePosition = new PVector(0f, 0f, 512f);
  originShapes[2] = new Box(zOriginShapePosition, ORIGIN_SHAPE_SIDE_LENGTHS);
}
