/**
 * Constants
 */

/**
 * Values
 */

private float r = 128f;

/**
 * Lifecycle
 */

void setup() {
  size(1280, 1280);

  r = height / 2f;
  // fullScreen();
  // fullScreen(2);
  background(0);
}

void draw() {
  background(0);

  final float t = millis() / 100f;
  noStroke();

  for (int j = 0; j < 64; j++) {
    for (float i = 0f; i < 1f; i +=.01f) {
      final float b = i * sin(i * j + t / 3f);
      final float a = b * r;
      final float x = r - a * abs(cos(t / 6f + i / 12f)) - r / 2f * abs(sin(i));
      final float y = r + a * sin(t / 4 + i / 2f);
      final float c = 2f + sin(i * j + t);

      //fill(0xFFFF00FF);
      ellipse(x, y, c, c);//a%2*4+7);
      fill(0xFF0000FF);
      //stroke(0xFF000000);
      //noFill();
      //ellipse(x, y + 32f, c+3f, c+3f);
    }
  }
}

/*
 * Implementation
 */
