/**
 * Constants
 */
 
 private int NUM_OF_FINGERS = 18;

/**
 * Values
 */

private Finger[] fingers;

/**
 * Lifecycle
 */

void setup() {
  size(1920, 1080);
  // fullScreen();
  // fullScreen(2);
  background(0);
  stroke(getRandomColorWithAlpha(128));

  fingers = new Finger[NUM_OF_FINGERS];
  for (int i = 0; i < NUM_OF_FINGERS; i++) {
    final float xOffset = ((float) width / (float) NUM_OF_FINGERS) * (float) i;
    fingers[i] = new Finger(width * 0.05f + xOffset, height);
  }
}

void draw() {
  background(0);
  //noFill();
  //stroke(getRandomColorWithAlpha(128));

  for (final Finger finger : fingers) {
    finger.drawAndUpdate();
  }
}

private color getRandomColorWithAlpha(final int alpha) {
  return color(
    (int) 150 + random(155), 
    (int) 100 + random(155), 
    (int) 150 + random(155), 
    alpha
    );
}