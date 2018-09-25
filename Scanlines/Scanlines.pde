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
  //size(1920, 1080);
  // fullScreen();
  // fullScreen(2);
    //fullScreen(P3D);
   fullScreen(2);
  background(0);
  frameRate(240);
}

void draw() {
  background(0);
  strokeWeight(8f);
  stroke(0xFFFFFFFF);
  final float lineLength = width / 3f;
  final float startX = (frameCount * lineLength * 1.2f) % width;
  final float endX = startX + lineLength;
  final float startY = ((frameCount * lineLength * 8) / width) % height;
  final float endY = startY;
  line(startX, startY, endX, endY);
}

/*
 * Implementation
 */

private void drawFps() {
  fill(0xFF000000);
  rect(8f, 2f, 48f, 16f);
  fill(0xFFFFFFFF);
  text(int(frameRate) + " FPS", 16f, 16f);
}
