/**
 * Constants
 */

private static final float LINE_ANGLE_DELTA = 0.01f;

/**
 * Values
 */

private PVector center;

private float minRadius;

private float maxRadius;

/**
 * Lifecycle
 */

void setup() {
  size(1920, 1080);
  // fullScreen();
  // fullScreen(2);
  background(0);
  setRandomColor();

  center = new PVector(width / 2f, height / 2f);
  minRadius = height * 0.1f;
  maxRadius = height * 0.33f;
}

void draw() {
  for (float angle = random(0.1f); angle < TWO_PI; angle += random(0.1f)) {
    drawLineAtAngle(angle);
  }
}

private void drawLineAtAngle(final float alpha) {
  for (float distanceFromCenter = minRadius; distanceFromCenter < maxRadius; distanceFromCenter += random(4f)) {
    point(
      center.x + (cos(alpha) * distanceFromCenter), 
      center.y + (sin(alpha) * distanceFromCenter)
      );

    if (random(1f) > 0.9999f) {
      setRandomColor();
    }
  }
}

private void setRandomColor() {
  stroke(getRandomColorWithAlpha(0x1F));
}

private color getRandomColorWithAlpha(final int alpha) {
  return color(
    (int) random(255) + 0, 
    (int) random(255) + 0, 
    (int) random(255) + 0, 
    alpha
    );
}