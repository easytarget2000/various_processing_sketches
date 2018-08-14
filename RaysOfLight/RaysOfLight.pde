/**
 * Constants
 */

private static final int NUM_OF_LINES = 128;

/**
 * Values
 */

private Line[] lines;

private PVector startingPoint;

/**
 * Lifecycle
 */

void setup() {
  size(1920, 1080);
  // fullScreen();
  // fullScreen(2);
  //fullScreen(P3D);
  //fullScreen(P3D, 2);
  background(0);

  initLines();

  startingPoint = new PVector(width / 2f, height / 2f);
}

void draw() {
  background(0);
  drawLines();
  updateStartingPoint();
}

/*
 * Implementation
 */

private void initLines() {
  lines = new Line[NUM_OF_LINES];
  float lineAngle = random(TWO_PI);
  final float lineAngleDelta = TWO_PI / (float) lines.length;
  for (int lineIndex = 0; lineIndex < lines.length; lineIndex++) {
    final color lineColor = getRandomColor();
    lines[lineIndex] = new Line(lineAngle, lineColor);
    lineAngle += lineAngleDelta;
  }
}

private void drawLines() {
  strokeWeight(4f); 

  final float lineLength = max(width, height);
  for (final Line currentLine : lines) {
    final PVector endPoint = currentLine.getEndpoint(startingPoint, lineLength);
    stroke(currentLine.getColor());
    line(
      startingPoint.x, 
      startingPoint.y, 
      endPoint.x, 
      endPoint.y
      );

    currentLine.updateAngle();
  }
}

private color getRandomColor() {
  return color(
    (int) random(255) + 0, 
    (int) random(255) + 0, 
    (int) random(255) + 0, 
    255
    );
}

private void updateStartingPoint() {
  startingPoint.x += cos(millis() / 100f) * 32f;
}

private void drawFps() {
  fill(0xFF000000);
  rect(8f, 2f, 48f, 16f);
  fill(0xFFFFFFFF);
  text(int(frameRate) + " FPS", 16f, 16f);
}
