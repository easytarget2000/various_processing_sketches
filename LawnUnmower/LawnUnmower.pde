/**
 * Constants
 */

private static final int NUM_OF_BEAMS = 128;

private static final float ANGLE_OFFSET_DELTA = TWO_PI / 44f;

private static final int REVS_PER_WALK = 233;

private static final int MAX_ALPHA = 64;

private static final int CYCLES_PER_FRAME = 2;

/**
 * Values
 */

private float maxJitter;

private float pointRadius;

private float angleOffset = 0f;

private float centerX;

private float centerY;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080);
  fullScreen();
  // fullScreen(2);
  background(0);

  setMaxJitter();
  setPointRadius();
  configurePaint();

  setCenterX();
  centerY = height / 2f;
}

void draw() {
  //background(0);

  final float angularDistance = TWO_PI / (float) NUM_OF_BEAMS;

  float lastX = centerX + pointRadius; 
  float lastY = centerY + pointRadius;

  for (int cycleCounter = 0; cycleCounter < CYCLES_PER_FRAME; cycleCounter++) {
    for (float angle = 0f; angle < TWO_PI + angleOffset; angle += angularDistance) {
      pointRadius += getJitter();
      line(
        lastX + 1f, 
        lastY + 1f, 
        lastX = centerX + (cos(angle + angleOffset) * pointRadius), 
        lastY = centerY + (sin(angle + angleOffset) * pointRadius)
        );

      if (pointRadius > (width / 8f) || pointRadius < (width / 16f)) {
        setPointRadius();
      }
      //else if (millis() % 333 == 0) {
      //  setMaxJitter();
      //} else if (millis() % 128 == 0) {
      //  configurePaint();
      //}
    }

    angleOffset += ANGLE_OFFSET_DELTA;
    centerX += width / (float) REVS_PER_WALK;
    if (centerX >= width + pointRadius) {
      setCenterX();
      configurePaint();
    }
  }
}

private void setPointRadius() {
  pointRadius = width / 4f;
}

private void setCenterX() {
  centerX = getJitter();
}

private void configurePaint() {
  noFill();
  stroke(getRandomColorWithAlpha(MAX_ALPHA));
}

private void setMaxJitter() {
  //maxJitter = 16f + width / random(64);
  maxJitter = 16f;
}

private float getJitter() {
  return (maxJitter / 2f) - random(maxJitter);
}

private color getRandomColorWithAlpha(final int alpha) {
  final int brightness = (int) random(255f);
  return color(
    brightness, //(int) random(255), 
    brightness, //(int) random(255), 
    brightness, //(int) random(255), 
    alpha
    );
}