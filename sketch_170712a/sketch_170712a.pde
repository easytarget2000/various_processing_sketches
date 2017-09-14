/**
 * Constants
 */

/**
 * Values
 */

private Conductor conductor;

private int numOfVerticalLines = 64;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080);
   fullScreen();
  //fullScreen(2);
  background(0);

  conductor = new Conductor(130f);
}

void draw() {
  background(0);

  noFill();
  stroke(0xFFAAFFAA);

  if (conductor.isBeatDue(2)) {
    if (random(1f) > 0.5f) {
      numOfVerticalLines += (int) random(16f);
      if (numOfVerticalLines > width / 2) {
        numOfVerticalLines = width / 2;
      }
    } else {
      numOfVerticalLines -= (int) random(16f);
      if (numOfVerticalLines < 16) {
        numOfVerticalLines = 16;
      }
    }
  }
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