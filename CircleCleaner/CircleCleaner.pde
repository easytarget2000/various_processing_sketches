/**
 * Constants
 */

private static final int ROUNDS_PER_FRAME = 4;

private static final int COLOR_MIN_BRIGHTNESS = 0;

/**
 * Values
 */

private float angle;

private PVector center;

private float maxJitter;

private float maxJitterHalf;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080);
   fullScreen();
  // fullScreen(2);
  background(0);

  angle = 0f;
  center = new PVector(width / 2f, height / 2f);
  maxJitter = width * 0.01f;
  maxJitterHalf = maxJitter / 2f;
}

void draw() {
  //background(0);
  angle += random(0.001f);

  for (int i = 0; i < ROUNDS_PER_FRAME; i++) {
    updateAndDraw();
  }

  center.x += getJitter();
  center.y += getJitter();
}

private void updateAndDraw() {
  angle += 0.01f;

  noStroke();
  if (random(1f) > 0.66f) {
    fill(getRandomGrayWithAlpha(255));
  }

  final float radius = height / 2f;
  rect(
    center.x + (cos(angle) * radius / 2f), 
    center.y + (sin(angle) * radius / 2f), 
    radius, 
    radius
    );
}

private float getJitter() {
  return maxJitterHalf - random(maxJitter);
}

private color getRandomColorWithAlpha(final int alpha) {
  return color(
    (int) random(255 - COLOR_MIN_BRIGHTNESS) + COLOR_MIN_BRIGHTNESS, 
    (int) random(255 - COLOR_MIN_BRIGHTNESS) + COLOR_MIN_BRIGHTNESS, 
    (int) random(255 - COLOR_MIN_BRIGHTNESS) + COLOR_MIN_BRIGHTNESS, 
    alpha
    );
}

private color getRandomGrayWithAlpha(final int alpha) {
  final int brightness = (int) random(255 - COLOR_MIN_BRIGHTNESS) + COLOR_MIN_BRIGHTNESS;
  return color(
    brightness, 
    brightness, 
    brightness, 
    alpha
    );
}