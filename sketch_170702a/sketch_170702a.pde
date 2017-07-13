/**
 * Constants
 */

private static final int NUM_OF_DROPS = 25;

private static final int MAX_ALPHA = 128;
/**
 * Values
 */

private Drop[] drops;

private float nextBeatMillis;

private int beatCounter = 0;

private color currentColor = getRandomColorWithAlpha(100);

/**
 * Lifecycle
 */

void setup() {
  size(1920, 1080);
  //fullScreen(2);
  background(0);
  noFill();

  addDrops();
  handleBeat();
}

void draw() {
  //background(0);
  currentColor = getColorWithRandomAlpha(currentColor);
  stroke(currentColor);
  drawDrops();

  if (millis() >= nextBeatMillis) {
    handleBeat();
  }
}

private void drawDrops() {
  float accumulatedXVelocity = 0f;
  float accumulatedYVelocity = 0f;

  for (final Drop drop : drops) {
    drop.drawConfigured();
    accumulatedXVelocity += drop.getXVelocity();
    accumulatedYVelocity += drop.getYVelocity();
    drop.update(accumulatedXVelocity, accumulatedYVelocity);
  }
}

private void handleBeat() {
  //background(0);
  //currentColor = getRandomColorWithAlpha(100);
  stroke(currentColor);

  if ((int) random(6f) % 6 == 0) {
    background(0);
  }
  
  if (++beatCounter % 8 == 0) {
    addDrops();
  }
  
  nextBeatMillis = millis() + (545 * 2);
}

private void addDrops() {
  final float startX = width * 0.01f;
  final float endX = width - (startX * 2f);

  drops = new Drop[NUM_OF_DROPS];
  for (int i = 0; i < drops.length; i++) {
    final float x = startX + ((float) i / (float) drops.length * endX);
    drops[i] = new Drop(x, height / 2f);
  }
}

private color getColorWithRandomAlpha(color c) {
  return (c & 0xffffff) | (((int) random((float) MAX_ALPHA)) << 24);
}

private color getRandomColorWithAlpha(final int alpha) {
  return color(
    (int) random(10) + 155, 
    (int) random(10) + 155, 
    (int) random(100) + 155, 
    alpha
    );
}