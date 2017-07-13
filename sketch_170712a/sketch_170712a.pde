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
   fullScreen(2);
  background(0);

  noFill();
  stroke(0xFFAAFFAA);
}

void draw() {
  background(0);

  final float numOfVerticalLines = 128f;
  final float squareWidth = width / numOfVerticalLines;

  for (float x = 0f; x <= width; x += squareWidth) {
    final float xOffset = (millis() % 1500) / 1500f * squareWidth;
    line(x + xOffset, 0f, x + xOffset, height);
  }

  for (float y = 0f; y <= height; y += squareWidth) {
    line(0f, y, width, y);
  }
}