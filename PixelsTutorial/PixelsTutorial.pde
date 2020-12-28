private PImage image;

private float explosionSpeed = 0.1f;

private float explosionFactor = 0f;

private float lastExplosionFactor = explosionFactor;

private boolean resetExplosionFactor = false;

/*
Lifecycle
 */

void setup() {
  //size(1024, 1024, P3D);
  fullScreen(P3D);
  //colorMode(HSB, 1f);
    frameRate(60f);

  image  = loadImage("face.png"); // Load the image
  background(0);
}

void draw() {
  if (random(1f) > 0.95f) {
    resetScreen();
  } else {
    fadeScreen();
  }

  setExplosionFactor();
  explodeImage();
}

void keyPressed() {
  resetExplosionFactorToBeginning();
  resetScreen();
}
/*
Implementations
 */

private void fadeScreen() {
  noStroke();
  fill(0x40000000);
  rect(0f, 0f, 0f, width, height);
}

private void resetScreen() {
  background(0);
}

private void setExplosionFactor() {
  if (resetExplosionFactor) {
    if (random(1f) > 0.9f) {
      explosionFactor = lastExplosionFactor;
      resetExplosionFactor = false;
    }
    return;
  }

  lastExplosionFactor = explosionFactor;

  if (random(1f) > 0.99f) {
    explosionFactor = 0f;
  } else if (random(1f) > 0.95f) {
    explosionFactor += explosionSpeed * 10f;
    resetExplosionFactor = true;
  } else if (random(1f) > 0.9f) {
    explosionFactor = -explosionFactor;
  } else if (random(1f) > 0.999f) {
    explosionFactor -= explosionSpeed * 10f;
    resetExplosionFactor = true;
  } else {
    explosionFactor += explosionSpeed;
  }
}

private void resetExplosionFactorToBeginning() {
  explosionFactor = 0f;
  resetExplosionFactor = false;
}

private void explodeImage() {
  final int cellSize = 4;
  final int cellSizeHalf = cellSize / 2;
  final int cols = image.width / cellSize;
  final int rows = image.height / cellSize;

  final float xOffset =  (width / 2f) - (image.width / 2f);
  final float yOffset = (height / 2f) - (image.height / 2f);
  final float zOffset = -width / 2f;

  //noStroke();
  noFill();
  loadPixels();
  // Begin loop for columns
  for ( int i = 0; i < cols; i++) {
    // Begin loop for rows
    for ( int j = 0; j < rows; j++) {
      final int x = i * cellSize + cellSizeHalf;
      final int y = j * cellSize + cellSizeHalf;
      final int pixelIndex = x + y * image.width;
      final color pixelColor = image.pixels[pixelIndex];
      // Calculate a z position as a function of mouseX and pixel brightness
      final float pixelBrightness = brightness(image.pixels[pixelIndex]);
      if (pixelBrightness < 100f) {
        continue;
      }

      pushMatrix();
      translate(
        x + xOffset, 
        y + yOffset, 
        (explosionFactor * pixelBrightness) + zOffset
        );
      stroke(pixelColor);
      point(0f, 0f);
      //ellipse(0f, 0f, cellSize, cellSize);
      popMatrix();
    }
  }
}
