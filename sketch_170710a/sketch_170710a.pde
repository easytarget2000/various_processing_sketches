/**
 * Constants
 */

private static final int MIN_POINTS_PER_LINE = 8;

private static final int MAX_POINTS_PER_LINE = 128;

private static final float FALL_RATE = 0.5f;

private static final int MIN_ALPHA = 64;

private static final int MAX_ALPHA = 128;

/**
 * Values
 */

private Point[] points;

private int pointsPerLine;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080);
  fullScreen(2);
  background(0);

  setBpm(128f);
  setPointsPerLine();
  initPoints();
}

private void initPoints() {
  final float pointWidth = width / (float) pointsPerLine;
  final float maxVerticalPointDistance = pointWidth;

  final ArrayList<Point> pointList = new ArrayList<Point>();

  float y = 0f;
  for (int i = 0; i < pointsPerLine; i++) {
    final float x = i * pointWidth;
    y += (maxVerticalPointDistance * 0.5f) - random(maxVerticalPointDistance);
    for (float yOffset = 0f; yOffset < height; yOffset += pointWidth) {
      pointList.add(
        new Point(x, y + yOffset, pointWidth / 2f, pointWidth / 2f)
        );
    }
  }

  points = new Point[pointList.size()];
  pointList.toArray(points);
}

private void setPointsPerLine() {
  pointsPerLine = MIN_POINTS_PER_LINE;
  pointsPerLine += (int) random((float) (MAX_POINTS_PER_LINE - MIN_POINTS_PER_LINE));
}

private void setBpm(final float bpm) {
  this.bpm = bpm;
  setBeatIntervalMillis();
  println("BPM set to: " + this.bpm + " -> beat interval: " + beatIntervalMillis + " ms");
}

private void setBeatIntervalMillis() {
  beatIntervalMillis = (int) ((60f / this.bpm) * 1000f);
  nextBeatMillis = 0;
}

void draw() {
  //background(0);
  //noFill();
  //noStroke();
  //fill(0x03FFFFFF);
  //stroke(0xa0FFFFFF);

  if (millis() >= nextBeatMillis) {
    handleBeat();
  }

  if (millis() % 16 == 0) {
    setRandomColor();
  }

  if (millis() % 8 == 0) {
    setPointsPerLine();
  }

  for (final Point point : points) {
    point.drawConfigured();

    point.y += random(height / 16f) * FALL_RATE;
    //if (point.y > height) {
    //  point.y = height - random(height / 16f);
    //}
  }
}

private void handleBeat() {

  nextBeatMillis = millis() + beatIntervalMillis;

  if (!doHandleBeats) {
    return;
  }

  background(0);
  initPoints();
  
  if ((int) random(10f) % 10 == 0) {
    setBeatIntervalMillis();
  }

  if ((int) random(4f) % 4 == 0) {
    if ((int) random(2f) % 2 == 0) {
      beatIntervalMillis *= 2f;
    } else {
      beatIntervalMillis /= 2f;
    }
  }
  
}

private void setRandomColor() {
  rectMode(RADIUS);
  final int randomAlpha = MIN_ALPHA + (int) random((float) MAX_ALPHA - MIN_ALPHA);
  //noFill();
  //noStroke();
  stroke(0);
  fill(getRandomColorWithAlpha(randomAlpha));
  //stroke(getRandomColorWithAlpha(randomAlpha));
}
//
private color getRandomColorWithAlpha(final int alpha) {
  if ((int) random(16f) % 16 != 0) {
    final int brightness = (int) random(128f);
    return color(
      brightness, 
      brightness, 
      brightness, 
      alpha
      );
  } else {
    return color(
      (int) random(256f), 
      (int) random(256f), 
      (int) random(256f), 
      alpha
      );
  }
}

private class Point {

  private float x;

  private float y;

  private float width;

  private float height;

  private Point(final float x, final float y, final float width, final float height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }

  private void drawConfigured() {
    rect(x, y, width, height);
  }
}