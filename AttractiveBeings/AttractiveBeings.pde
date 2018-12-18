/*
Constants
 */
 
 private static final int NUM_OF_NEW_BEINGS = 64;

/*
Variables
 */

private Being[] beings;

//private boolean fadeScreen = false;

private color backgroundColor = 0xFF4ECDC4;

private float backgroundFadeAlpha = 0.01f;

/*
Lifecycle
 */

void setup() {
  //size(800, 600, P3D);
  //fullScreen();
  // size(1024, 1024, P3D);
  fullScreen(P3D);
  colorMode(HSB, 1f);
  //sphereDetail(8);
  smooth();
  
  initBeings();

  lights();
}

void draw() {
  clearScreen();
  updateAndDrawBeings();
}

/*
Implementations
 */

private void initBeings() {
  beings = new Being[NUM_OF_NEW_BEINGS];
  for (int i = 0; i < beings.length; i++) {
    final PVector beingPosition = new PVector(width / 8f, height / 8f, 0f);
    final PVector beingVelocity = new PVector(0f, 0f, 0f);
    final float beingSize = min(width, height) / 8f;
    beings[i] = new Being(
      beingPosition, 
      beingVelocity, 
      beingSize
      );
  }
}

private void updateAndDrawBeings() {

  final PVector attractorPosition = new PVector(mouseX, mouseY, 0f);

  final boolean drawStroke = mousePressed;
  boolean drawAttractor = false;
  for (final Being currentBeing : beings) {
    currentBeing.updateAndDraw(attractorPosition, drawStroke);
    if (drawAttractor) {
      currentBeing.drawAttractor(attractorPosition);
      drawAttractor = false;
    }
  }
}

private void clearScreen() {
  final boolean fadeScreen = mousePressed;
  if (fadeScreen) {
    noStroke();
    fill(
      hue(backgroundColor), 
      saturation(backgroundColor), 
      brightness(backgroundColor), 
      backgroundFadeAlpha
      );
    rect(0f, 0f, width, height);
  } else {
    background(backgroundColor);
  }
}
