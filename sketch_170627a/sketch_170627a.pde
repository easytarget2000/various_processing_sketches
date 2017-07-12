/**
 * Constants
 */

private static final int MAX_LINES = 64;

private static final int MAX_KEYS = 4;

/**
 * Values
 */

private int pressedKeysCounter = 0;

private float density = 0f;

private float bpm = 130f;

private int nextBeatMillis = millis();

private int beatDistanceMillis;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080);
  fullScreen(2);
  setBpm(128f);
}

void draw() {
  background(0);
  drawGrid();
}

void keyPressed() {
  if (++pressedKeysCounter > MAX_KEYS) {
    pressedKeysCounter = MAX_KEYS;
  }
  
   println("keyPressed(): pressedKeysCounter: " + pressedKeysCounter);
}

void keyReleased() {
  if (--pressedKeysCounter < 0) {
    pressedKeysCounter = 0;
  }
  println("keyReleased(): pressedKeysCounter: " + pressedKeysCounter);
}

private void drawGrid() {
  noFill();
  stroke(getColor());

  //final float density = (pressedKeysCounter + 1 / MAX_KEYS);
  if (passedBeat()) {
    density = random(2f);
  }
  
  final int numberOfLines = (int) (MAX_LINES * density);
  final float lineLength = width * 2f;
  final float lineLengthHalf = lineLength / 2f;
  final float lineDistance = lineLength / numberOfLines;

  pushMatrix();
 
  //rotate(0.01 * frameCount % 1000);

  for (float x = -lineLengthHalf; x < (width + lineLengthHalf); x += lineDistance) {
    line(x, 0, x, lineLength);
    line(0, x, lineLength, 0);
  }
  translate(width/2, height/2);
  popMatrix();
}

private color getColor() {
  return 0xFF00FF00 | ((int) millis() * 4);
}

private void setBpm(final float bpm) {
  //this.bpm = bpm;
  
  beatDistanceMillis = (int) (((60f / bpm) * 1000f) / 4f);
  nextBeatMillis = millis();
}

private boolean passedBeat() {
  if (millis() >= nextBeatMillis) {
    if ((int) random(12f) % 12 == 0) {
      nextBeatMillis = millis() + beatDistanceMillis;
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}