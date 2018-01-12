/**
 * Constants
 */

/**
 * Values
 */

private color backgroundColor;

private VeinLayer veinLayer;

/**
 * Lifecycle
 */

void setup() {
  size(1920, 1080, P3D);
  // fullScreen();
  colorMode(HSB, 1f);
  // fullScreen(2);
  background(0);
  setRandomBackgroundColor();
  initVeinLayer();
}

void draw() {
  background(backgroundColor);

  translate(width / 2f, 0f);
  rotateY(frameCount / 128f);
  translate(-width / 2f, 0f);

  updateAndDrawVeinLayer();
}

private void initVeinLayer() {
  final PVector center = new PVector(width / 2f, height / 2f);
  final float growthVelocity = width / 512f;
  veinLayer = new VeinLayer(center, growthVelocity);
}

private void updateAndDrawVeinLayer() {
  noFill();
  stroke(0xFFFFFFFF);

  veinLayer.updateAndDrawVeins();
}

private void setRandomBackgroundColor() {
  backgroundColor = color(random(1f), 1f, 1f, 1f);
}