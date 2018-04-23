/**
 * Constants
 */

/**
 * Values
 */

private boolean clearFrame = false;

private static final color[] PALETTE = new color[] {
  0xFF000000, 
  0xFF1D2B53, 
  0xFF7E2553, 
  0xFF008751, 
  0xFFAB5236, 
  0xFF5F574F, 
  0xFFC2C3C7, 
  0xFFFFF1E8, 
  0xFFFF004D, 
  0xFFFFA300, 
  0xFFFFEC27, 
  0xFF00E436, 
  0xFF29ADFF, 
  0xFF83769C, 
  0xFFFF77A8, 
  0xFFFFCCAA
};

private float t = 0.1f;

private color opaqueColor;

private color transparentColor;

/**
 * Lifecycle
 */

void setup() {
  //size(128, 128);
  fullScreen();
  // fullScreen(2);
  background(0);

  setRandomColors();
}

void draw() {

  if (random(1f) > 0.9f) {
    clearFrame = !clearFrame;
  }

  if (random(1f) > 0.9f) {
    setRandomColors();
  }

  if (clearFrame) {
    background(0);
  }
  
  noFill();

  if (random(1f)> 0.9f) {
    t = 0.1f;
  } else if (random(1f) > 0.9f) {
    t -= 1f;
  } else if (random(1f) > 0.9f) {
    t += 1f;
  }

  t += 0.08f;

  if (clearFrame) {
    stroke(opaqueColor);
  } else {
    stroke(transparentColor);
  }

  strokeWeight(8f);
  
  for (float r = width / 8f; r < width; r += width / 16f) {
    //for r=8, 40, 8 do
    float x = 0f;
    float y = 0f;

    final float d = r * sin(t/2f) / 2f;
    for (float a = 0f; a < 16; a += 0.02f) {
      final float n = width / 2f + (10f + r) * cos(a) + d * sin(a * floor(t) + 2f * t);
      final float m = height / 2f + (10f + r) * sin(a) + d * cos(a * floor(t) + 2f * t);
      if (x != 0f) {
        final int colorIndex = (int) (7f + r / 8f);
        line(x, y, n, m);
      }

      x = n;
      y = m;
    }
  }
}

/*
 * Implementation
 */

private void setRandomColors() {
  opaqueColor = getRandomColorWithAlpha(255);
  transparentColor = getRandomColorWithAlpha(100);
}

private color getRandomColorWithAlpha(final int alpha) {
  return color(
    (int) random(100) + 155, 
    (int) random(100) + 155, 
    (int) random(100) + 155, 
    alpha
    );
}