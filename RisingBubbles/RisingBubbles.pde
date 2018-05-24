/*
Based on http://junkiyoshi.com/insta20180519/
 by Kiyoshi Nakauchi.
 */

/**
 * Constants
 */

private static final int NUM_OF_BALLS = 512;

private static final float CHANGE_RANDOM_SEED_PROBABILITY = 0.02f;

/**
 * Values
 */

private long randomSeed = (long) random(64f);

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080, P3D);
  //fullScreen(P3D);
   fullScreen(P3D, 2);
  background(0);

  colorMode(HSB, 255f);
  sphereDetail(12);
}

void draw() {
  //background(0);
  setRandomSeed();
  clearScreen();
  lights();
  drawBalls();
  drawFps();
}

/*
 * Implementation
 */

private void clearScreen() {
  noStroke();
  fill(0f, 0f, 0f, 32f);
  rect(0f, 0f, width, height);
}

private void setRandomSeed() {
  if ((millis() % 100 / 100f) > (1f - CHANGE_RANDOM_SEED_PROBABILITY)) {
    randomSeed += 1L;
  }
  randomSeed(randomSeed);
}

private void drawBalls() {
  noStroke();

  final float widthHalf = width / 2f;
  final float heightHalf = height / 2f;

  pushMatrix();
  translate(widthHalf, heightHalf);
  rotateX(-270f / 360f * TWO_PI);
  rotate(frameCount * 0.005f);

  for (int i = 0; i < NUM_OF_BALLS; i++) {

    fill(random(255f), 64f, 239f, 255f);

    PVector point = new PVector(
      random(-widthHalf, widthHalf), 
      random(-heightHalf, heightHalf), 
      random(-360f, 360f)
      );
    point.z = ((int)point.z + frameCount * (int) random(5f)) % 720f;
    point.z -= 360f;
    point = PVector.mult(point.normalize(), 300f);

    pushMatrix();
    translate(point.x, point.y, point.z);
    sphere(8f);
    //ellipse(0f, 0f, 32f, 32f);
    popMatrix();
  }
  popMatrix();
}

private void drawFps() {
  fill(0xFF000000);
  rect(8f, 2f, 48f, 16f);
  fill(0xFFFFFFFF);
  text(int(frameRate) + " FPS", 16f, 16f);
}
