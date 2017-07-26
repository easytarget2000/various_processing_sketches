/**
 * Constants
 */

private static final int MIN_NUM_OF_RINGS = 4;

private static final int MAX_NUM_OF_RINGS = 32;

private static final int MAX_VERTICES_PER_RING = 512;

private static final int X_AXIS = 2;

private static final int Y_AXIS = 1;

private static final color[] BG_COLORS = {
  0xFFEA3556, 
  0xFF12ECA8, 
  0xFFE3F612, 
  0xFF2D4E60, 
  0xFFFFA401
};


/**
 * Values
 */

private Conductor conductor;

private float outerRingRadius;

private int numOfRings;

private boolean clearBackground;

private boolean drawNothing;

private color backgroundColor;

/**
 * Lifecycle
 */

void setup() {
  size(1920, 1080);
  //fullScreen();
  // fullScreen(2);
  background(0);

  numOfRings = MAX_NUM_OF_RINGS / 2;
  setRandomClearBackground();
  drawNothing = false;
  outerRingRadius = height * 0.33f;
  noFill();
  setColor();
  
  conductor = new Conductor(128f);

  background(0xFF000000);
}

void draw() {
  
  if (drawNothing) {
    return;
  }

  if (conductor.isBeatDue(2)) {
    backgroundColor = getRandomBackgroundColor();
    background(backgroundColor);
  }

  float[] xOffsets = new float[MAX_VERTICES_PER_RING];
  float[] yOffsets = new float[MAX_VERTICES_PER_RING];
  for (int offsetCounter = 0; offsetCounter < xOffsets.length; offsetCounter++) {
    xOffsets[offsetCounter] = getJitter();
    yOffsets[offsetCounter] = getJitter();
  }

  for (int ringCounter = 0; ringCounter < numOfRings; ringCounter++) {
    final float sizeFactor = (ringCounter + 1f) / numOfRings;
    final int numOfVertices = (int) (sizeFactor * MAX_VERTICES_PER_RING);
    final float radius = sizeFactor * outerRingRadius;
    final float firstX = (width / 2f) + radius + xOffsets[0];
    final float firstY = (height / 2f) + yOffsets[0];
    float lastX = firstX;
    float lastY = firstY;

    for (int vertexCounter = 0; vertexCounter < numOfVertices - 1; vertexCounter++) {
      final float relativeVertexPos = (vertexCounter + 1f) / numOfVertices;
      final int offsetIndex = (int) (relativeVertexPos * (MAX_VERTICES_PER_RING - 1));
      final float alpha = relativeVertexPos * TWO_PI;
      final float x = (width / 2f) + (cos(alpha) * radius) + xOffsets[offsetIndex];
      final float y = (height / 2f) + (sin(alpha) * radius) + yOffsets[offsetIndex];

      line(lastX, lastY, x + 0.1f, y);

      lastX = x;
      lastY = y;
    }

    line(lastX, lastY, firstX, firstY);
  }

  if (millis() % 4 == 0) {
    setNumOfRings();
  } else if (millis() % 22 == 0) {
    setColor();
  } else if (millis() % 53 == 0) {
    setRandomClearBackground();
  }
}

void keyPressed() {

  println("main: keyPressed(): key: " + (int) key);

  switch (key) {
  case 's':
    setClearBackground(!clearBackground);
    break;
  case 'b':
    drawNothing = true;
  }
}

void keyReleased() {

  println("main: keyReleased(): key: " + (int) key);

  switch (key) {
  case 'b':
    drawNothing = false;
    break;
  }
}

private void drawBackground() {
  background(backgroundColor);
}

private void setNumOfRings() {
  if (random(1f) > 0.5f) {
    numOfRings *= 1.3f;
  } else {
    numOfRings *= 0.8f;
  }

  if (numOfRings > MAX_NUM_OF_RINGS) {
    numOfRings = MAX_NUM_OF_RINGS;
  } else if (numOfRings < MIN_NUM_OF_RINGS) {
    numOfRings = MIN_NUM_OF_RINGS;
  }
}

private float getJitter() {
  return 2f - random(4f);
}

private void setColor() {
  if (!clearBackground && getBrightness() > 0.05f) {
    stroke(0x60000000);
  } else {
    stroke(getRandomColor());
  }
}

private void setRandomClearBackground() {
  setClearBackground(random(1f) > 0.5f);
}

private void setClearBackground(final boolean clearBackground) {
  this.clearBackground = clearBackground;
  setColor();
}

private float getBrightness() {
  int pointCounter = 0;
  float brightnessSum = 0;
  for (int x = width / 20; x < width; x += width / 20) {
    for (int y = height / 20; y < height; y += height / 20) {
      brightnessSum += brightness(get(x, y)) / 255f;
      //println("rgb: " + get(x, y) + " brightness: " + brightness(get(x, y)));
      ++pointCounter;
    }
  }

  return brightnessSum / (float) pointCounter;
}

private color getRandomColor() {
  if (random(1f) > 0.1f) {
    return (0xFFFFFFFF);
    //final int brightness = 100 + (int) random(155);

    //return color(
    //  brightness, 
    //  brightness, 
    //  brightness, 
    //  clearBackground ? 255 : 32
    //  );
  } else {
    return color(
      (int) 50 + random(200), 
      (int) 50 + random(200), 
      (int) 50 + random(200), 
      clearBackground ? 255 : 32
      );
  }
}

private color getRandomBackgroundColor() {
  return BG_COLORS[(int) random(BG_COLORS.length)];
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i += 8) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  } else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}