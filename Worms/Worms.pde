/**
 * Constants
 */

private static final int NUM_OF_WORMS = 12;

private static final int NUM_OF_ROUNDS_PER_FRAME = 6;

/**
 * Values
 */

private Worm[] worms;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1920, P3D);
  fullScreen(P3D);
  // fullScreen(2);
  background(0);

  initWorms();

  frameRate(30);
  stroke(getRandomColorWithAlpha(0x30));
}

void draw() {
  //background(0);

  fill(0x10FFFFFF);
  //noFill();
  if (random(1f) > 0.99f) {
    stroke(getRandomColorWithAlpha(0x30));
  }

  for (int i = 0; i < NUM_OF_ROUNDS_PER_FRAME; i++) {
    drawRound();
  }
}

void keyPressed() {
  background(0);
  initWorms();
}

private void drawRound() {
  for (final Worm currentWorm : worms) {
    currentWorm.update();
    currentWorm.drawConfigured();
  }
}

private void initWorms() {
  final PVector wormOrigin = new PVector();
  wormOrigin.x = width / 2f;
  wormOrigin.y = height / 2f;
  wormOrigin.z = 0f;

  worms = new Worm[NUM_OF_WORMS];
  for (int i = 0; i < worms.length; i++) {
    final float wormRadius = 64f + random(64f);
    worms[i] = new Worm(wormOrigin, wormRadius);
  }
}

private color getRandomColorWithAlpha(final int alpha) {
  return color(
    (int) random(255) + 0, 
    (int) random(20) + 0, 
    (int) random(20) + 0, 
    alpha
    );
}