/**
 * Constants
 */

private static final int NUM_OF_BEAMS = 64;

/**
 * Values
 */

private float maxJitter;

private float pointRadius;

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
}

void draw() {
  //background(0);

  final float initialX = width / 2f;
  final float initialY = height / 2f;

  final float angularDistance = TWO_PI / (float) NUM_OF_BEAMS;
  final float angleOffset = ((millis() % 1000) / 1000f) * angularDistance; 

  for (float angle = 0f; angle < TWO_PI; angle += angularDistance) {
    pointRadius += getJitter();
    point(
      initialX + (cos(angle + angleOffset) * pointRadius), 
      initialY + (sin(angle + angleOffset) * pointRadius)
      );

    if (pointRadius > (width / 2f)) {
      setPointRadius();
    } else if (millis() % 333 == 0) {
      setMaxJitter();
    } else if (millis() % 128 == 0) {
      configurePaint();
    }
    
    
  }
}

private void setPointRadius() {
  pointRadius = width / 4f;
}

private void configurePaint() {
  noFill();
  stroke(getRandomColorWithAlpha(128));
}

private void setMaxJitter() {
  //maxJitter = 16f + width / random(64);
  maxJitter = width / 64f;
}

private float getJitter() {
  return (maxJitter / 2f) - random(maxJitter);
}

private color getRandomColorWithAlpha(final int alpha) {
  return color(
    (int) random(255), 
    (int) random(255), 
    (int) random(255), 
    alpha
    );
}