/**
 * Constants
 */

/**
 * Values
 */

private Slope[] firstSlopes;

/**
 * Lifecycle
 */

void setup() {

  // fullScreen();
  fullScreen(1);
      frameRate(60f);

  background(0);
  firstSlopes = new Slope[64];
  for (int i = 0; i < firstSlopes.length; i++) {
    final float speed = 20f * ((firstSlopes.length - i + 1f) / (float) firstSlopes.length);
    firstSlopes[i] = new Slope(width, 0f, speed);
  }
}

void draw() {
  //background(0);

  stroke(getRandomColorWithAlpha(64));

  for (Slope firstSlope : firstSlopes) {
    Slope currentSlope = firstSlope;

    while (currentSlope != null) {

      if (!currentSlope.drawAndUpdate()) {
        firstSlope = currentSlope.nextSlope;
      }

      currentSlope = currentSlope.nextSlope;
    }
  }
}

private color getRandomColorWithAlpha(final int alpha) {
  return color(
    (int) 0 + random(64), 
    (int) 0 + random(128), 
    (int) 0 + random(255), 
    alpha
    );
}

class Slope {

  private float leftX;

  private float leftY;

  private float rightX;

  private float rightY;

  private float speed;

  private Slope nextSlope;

  Slope(final float leftX, final float leftY, final float speed) {
    this.leftX = leftX;
    this.leftY = leftY;
    this.speed = speed;

    rightX = leftX + random(128f);
    rightY = (leftY + random(20f - 10f));
  }

  boolean drawAndUpdate() {

    line(leftX, leftY, rightX, rightY);

    leftX += -speed;
    rightX += -speed;

    if (leftX < width && nextSlope == null) {
      if (rightY > height) {
        nextSlope = new Slope(width, 0f, speed);
      } else {
        nextSlope = new Slope(rightX + speed, rightY, speed);
      }
      return false;
    } else if (rightX < 0f) {
      return false;
    } else {
      return true;
    }
  }
}
