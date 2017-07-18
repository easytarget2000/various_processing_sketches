/**
 * Constants
 */

private static final int NUM_OF_BEAMS = 16;

/**
 * Values
 */

private float maxJitter;

private float pointRadius;

private int nextBeatMillis = 0;

private float bpm = 130;

private float lastX;

private float lastY;

private float initialX;

private float initialY;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080);
  //fullScreen();
   fullScreen(2);
  background(0);


  setMaxJitter();
  setPointRadius();
  configurePaint();
  setInitialCoordinates();
}

void draw() {
  //background(0);

  if (millis() >= nextBeatMillis) {
    handleBeat();
  }

  final float angularDistance = TWO_PI / (float) NUM_OF_BEAMS;
  final float angleOffset = ((millis() % 1000) / 1000f) * angularDistance; 

  for (float angle = 0f; angle < TWO_PI; angle += angularDistance) {
    pointRadius += getJitter();
    //point(
    //  initialX + (cos(angle + angleOffset) * pointRadius), 
    //  initialY + (sin(angle + angleOffset) * pointRadius)
    //  );

    rect(
      initialX + (cos(angle + angleOffset) * pointRadius), 
      initialY + (sin(angle + angleOffset) * pointRadius), 
      width / 2f, 
      height / 2f
      );

    if (pointRadius < 2f || pointRadius > (width * 0.25f)) {
      setPointRadius();
    } else if (millis() % 333 == 0) {
      setMaxJitter();
    } else if (millis() % 128 == 0) {
      configurePaint();
    } else if (millis() % 444 == 0) {
      setInitialCoordinates();
    }
  }
}

private void handleBeat() {

  if (((int) random(2f)) % 2 == 0) {
    background(0);
  }

  final int beatIntervalMillis = (int) ((60f / bpm) * 1000f);
  nextBeatMillis = millis() + beatIntervalMillis;
}

private void setPointRadius() {
  pointRadius = width / 4f;
}

private void setInitialCoordinates() {
  initialX = (width * 0.2f) + random(width * 0.4f);
  initialY = (height * 0.2f) + random(height * 0.4f);
  lastX = initialX;
  lastY = initialY;
}

private void configurePaint() {
  noFill();
  stroke(getRandomColorWithAlpha(64));
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
    (int) 50 + random(155), 
    (int) 100 + random(155), 
    (int) 100 + random(155), 
    alpha
    );
}