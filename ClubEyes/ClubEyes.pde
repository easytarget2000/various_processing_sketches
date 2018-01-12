/**
 * Constants
 */

private static final char DECR_NUM_OF_EYES_KEY = 'z';

private static final char INCR_NUM_OF_EYES_KEY = 'x';

private static final char CHANGE_EYE_COLOR_KEY = 'c';

private static final char INIT_EYES_KEY = 'v';

private static final char TOGGLE_3D_MODE_KEY = 'b';


/**
 * Values
 */

private Eye[] eyes;

private int numOfEyes;

private boolean randomMode;

private color eyeColor;

private boolean threeDMode = false;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080, P3D);
  // fullScreen();
  fullScreen(P3D, 2);
  background(0);

  randomMode = false;

  numOfEyes = 3;
  initEyes();
}

void draw() {

  if (threeDMode) {
    translate(width / 2f, 0f);
    rotateY(frameCount / 4f);
    translate(-width / 2f, 0f);
    if (random(1f) > 0.9f) {
      background(0);
    }
  } else {
    background(0);
  }

  drawEyes();

  if (randomMode && random(1f) > 0.9f) {
    initEyes();
  }
}

void keyPressed() {
  switch (key) {
  case DECR_NUM_OF_EYES_KEY:
    numOfEyes -= 1;
    if (numOfEyes < 1) {
      numOfEyes = 1;
    }
    initEyes();
    break;

  case INCR_NUM_OF_EYES_KEY:
    numOfEyes += 1;
    if (numOfEyes > 6) {
      numOfEyes = 6;
    }
    initEyes();
    break;

  case CHANGE_EYE_COLOR_KEY:
    eyeColor = getRandomColor();
    initEyes();
    break;

  case INIT_EYES_KEY:
    initEyes();
    break;

  case TOGGLE_3D_MODE_KEY:
    threeDMode = !threeDMode;
  }
}

/*
 * Implementation
 */

private void initEyes() {
  if (randomMode && random(1f) > 0.9f) {
    numOfEyes = 1 + (int) random(5f);
  }

  eyes = new Eye[numOfEyes];

  final float margin = 128f;
  final float totalMargin = margin * (numOfEyes + 1);
  final float eyeWidth = ((width - totalMargin) / eyes.length);
  final float eyeWidthHalf = eyeWidth / 2f;

  final float eyeHeight = (height * 0.2f) + random(height * 0.4f);

  eyeColor = getRandomColor();

  for (int i = 0; i < eyes.length; i++) {

    if (randomMode && random(1f) > 0.9f) {
      eyeColor = getRandomColor();
    }

    final PVector eyePosition = new PVector();
    eyePosition.x = (margin * (i + 1))  + (eyeWidth / 2f) + (eyeWidth * i);
    eyePosition.y = height / 2f;

    eyes[i] = new Eye(
      eyePosition, 
      eyeWidth, 
      eyeHeight, 
      eyeColor
      );
  }
}

private color getRandomColor() {
  return color(
    (int) random(255) + 0, 
    (int) random(255) + 0, 
    (int) random(255) + 0, 
    0xFF
    );
}

private void drawEyes() {
  for (final Eye currentEye : eyes) {
    currentEye.draw_();
  }
}