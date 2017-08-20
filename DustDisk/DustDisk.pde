/**
 * Constants
 */

/**
 * Values
 */

private float t = 0f;

/**
 * Lifecycle
 */

void setup() {
  size(1920, 1080);
  // fullScreen();
  // fullScreen(2);
  background(0);
  noFill();
  stroke(0x30FFFFFF);
}

void draw() {
  //background(0);

  //final int t = (millis() / 100);
  t += 0.4f;

  for (float radius = 0; radius < 512f; radius += 0.1f) {
    final float a = t + radius / 8f; 
    ellipse(
      width / 2f + (radius / 2f * cos(a + t)) + (radius / 3f * cos(2 * a+ 0.1)) + random(2f), 
      height / 2f + (radius / 2f * sin(a + t)) + (radius / 3f* sin(2 * a + 0.2)) + random(2f), 
      2f, 
      2f
      );
  }

  if (random(1f) > 0.95f) {
    if (random(1f) < 0.5f) {
      stroke(0x10FFFFFF);
    } else {
      stroke(0x10000000);
    }
  }
}