/**
 * Constants
 */

private static final int NUM_OF_STARS = 128 * 10;

private static final int MIN_ALPHA = 64;

private static final int MAX_ALPHA = 255;

/**
 * Values
 */

private ArrayList<Star> stars = new ArrayList<Star>();

private int nextBeatMillis = 0;

private float bpm = 86.4;

private int beatIntervalMillis;

private float originX;

private float originY;

/**
 * Lifecycle
 */

void setup() {
  fullScreen();
  //size(1920, 1080);

  beatIntervalMillis = (int) ((60f / bpm) * 1000f);
  println(beatIntervalMillis + " xss");
  setStarOriginCoordinates();
  addStars();

  setRandomColor();
  background(0);
}

void draw() {

  if (millis() >= nextBeatMillis) {
    handleBeat();
  }

  for (int i = 0; i < stars.size(); i++) {
    final Star star = stars.get(i);
    if (!star.updateAndDraw()) {
      stars.remove(i);
    }
  }

  //println("DEBUG: Number of stars: " + stars.size());
}

private void handleBeat() {

  if (((int) random(3f)) % 3 == 0) {
    background(0);
  }

  //if (((int) random(2f)) % 2 == 0) {
    addStars();
  //}

  setRandomColor();

  nextBeatMillis = millis() + beatIntervalMillis;
}

private void addStars() {
  if ((int) random(16f) % 16 == 0) {
    setStarOriginCoordinates();
  }
  
  for (int i = 0; i < NUM_OF_STARS; i++) {
    stars.add(new Star(originX, originY));
  }
}

private void setStarOriginCoordinates() {
  originX = width / 2f;random(width);
  originY = height / 2f; random(height);
}

private void setRandomColor() {
  noFill();
  rectMode(RADIUS);
  final int randomAlpha = MIN_ALPHA + (int) random((float) MAX_ALPHA - MIN_ALPHA);
  stroke(getRandomColorWithAlpha(randomAlpha));
}

private color getRandomColorWithAlpha(final int alpha) {
  return color(
    (int) random(100) + 155, 
    (int) random(100) + 155, 
    (int) random(100) + 155, 
    alpha
    );
}

private class Star {

  private static final float MAX_VELOCITY = 128f;

  private static final float MAX_VELOCITY_HALF = MAX_VELOCITY / 2f;

  private float initialX;

  private float initialY;

  private float x;

  private float y;

  private float xVelocity;

  private float yVelocity;

  private float maxRadius;

  Star(final float initialX, final float initialY) {

    this.initialX = initialX;
    this.initialY = initialY;

    x = initialX;
    y = initialY;

    xVelocity = MAX_VELOCITY_HALF - random(MAX_VELOCITY);
    yVelocity = MAX_VELOCITY_HALF - random(MAX_VELOCITY);

    maxRadius = width / 16f;
  }

  boolean updateAndDraw() {

    //ellipse(x, y, 4, 4);

    //float distanceFactor;
    //if (xVelocity < 0) {
    //  distanceFactor = 1f - (x / initialX);
    //} else {
    //  distanceFactor = ((x - initialX) / initialX);
    //}


    //if (distanceFactor > 0.99) {
    //  distanceFactor = 1f;
    //} else if (distanceFactor < 0.1) {
    //  distanceFactor = 0.1f;
    //}

    //ellipse(x, y, maxRadius * distanceFactor, maxRadius * distanceFactor);
    //final float radius = maxRadius * distanceFactor;
    //rect(x, y, radius, radius);

    point(x, y);

    x += xVelocity;
    y += yVelocity;

    return x > 0 && x < width && y > 0 && y < height;
  }
}