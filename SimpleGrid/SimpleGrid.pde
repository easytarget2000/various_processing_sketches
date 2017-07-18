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

}

void draw() {
  background(0);

  noFill();
  stroke(0xFFFFFFFF);
  
  final float numOfVerticalLines = 48f;
  final float squareWidth = width / numOfVerticalLines;

  for (float x = 0f; x <= width; x += squareWidth) {
    final float xOffset = (millis() % 1500) / 1500f * squareWidth;
    line(x + xOffset, 0f, x + xOffset, height);
  }

  for (float y = 0f; y <= height; y += squareWidth) {
    line(0f, y, width, y);
  }
  
  //noStroke();
  //fill(0xFF000000);
  //ellipse(width / 2f, height / 2f, width * 0.2f, height * 0.6f);
}