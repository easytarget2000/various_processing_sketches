/**
 * Constants
 */

/**
 * Values
 */

private float t = 0f;

private float ballMultiplier = 1f;

private boolean draw = true;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080);
   fullScreen();
  // fullScreen(2);
  background(0);
  noFill();
}

void draw() {
  if (!draw) {
    background(0);
    return;
  }
  
  if (millis() % 3 == 0) {
    background(0);
  }
    
  if (random(1f) > 0.9f) {
    setRandomColor();
  }
  
  if (random(1f) > 0.95f) {
    ballMultiplier = 0.3f + random(1.7f);
  }
  
  final float maxRadius = height / (7 * ballMultiplier);
  
  for (int x = 0; x < 15 * ballMultiplier; x++) {
    for (int y = 0; y < 7 * ballMultiplier; y++) {
      final float radius = maxRadius + maxRadius* sin(t*10);
      ellipse(maxRadius / 2f + x*maxRadius, maxRadius / 2f +y*maxRadius, radius, radius);
    }
  }
  t += 0.01f;
}

void keyPressed() {
  if (key == 'x') {
    draw = false;
  }
}

void keyReleased() {
  if (key == 'x') {
    draw = true;
  }
}

private void setRandomColor() {
  stroke(getRandomColorWithAlpha(0xFF));
}

private color getRandomColorWithAlpha(final int alpha) {
  return color(
    (int) random(100) + 155, 
    (int) random(100) + 155, 
    (int) random(100) + 155, 
    alpha
    );
}