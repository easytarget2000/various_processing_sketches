/* //<>//
 * Static Finals
 */

private static final boolean VERBOSE = true;

/*
 * Attributes
 */

private Foliage foliage;

private color color_;

private ScreenClearer screenClearer;

private boolean drawFrameRate = false;

/**
 Lifecycle
 */

void setup() {
  //fullScreen(2);
  fullScreen(P3D, 2);
  //size(1920, 1080, P3D);
  //size(1920, 1080);

  smooth();
  //blendMode(DARKEST);

  println("Screen: " + width + "x" + height + "px");

  initFoliage();

  screenClearer = new ScreenClearer(
    ScreenClearerMode.FULL, 
    0, 
    4
    );
  screenClearer.performFullClear();

  setColor();
}

void draw() {

  screenClearer.applyMode();

  if (random(1f) > 0.9f) {
    setColor();
  }

  rotate_();
  drawAndUpdateBeings();

  if (drawFrameRate) {
    drawFrameRate();
  }
}

void keyPressed() {
}

/*
Implementations
 */

private void initFoliage() {
  foliage = new Foliage().initCircle();
}

private void rotate_() {
  translate(width / 2f, 0f);
  rotateY(frameCount / 128f);
  translate(-width / 2f, 0f);
}

private void drawAndUpdateBeings() {
  //stroke(frameCount / 1000, 1, 1, 1);

  final boolean foliageIsAlive = foliage.drawIfAlive(color_);
  if (!foliageIsAlive) {
    initFoliage();
  }
}

private void drawFrameRate() {
  fill(0);
  noStroke();
  rect(8, 8, 64, 24);

  stroke(0xFFFFFFFF);
  fill(0xFFFFFFFF);
  text(floor(frameRate) + "fps", 10, 20);
}

private void setColor() {
  color_ = new Palette().getRandomColorWithAlpha(150);
}
