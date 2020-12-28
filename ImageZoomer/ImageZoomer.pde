import processing.video.*;

private PImage image;

private Capture cam;

private float explosionSpeed = 0.5f;

private float explosionFactor = 0f;

private float lastExplosionFactor = explosionFactor;

private boolean resetExplosionFactor = false;

private float hue = 0f;

/*
Lifecycle
 */

void setup() {
  //size(640, 360, P3D);
  fullScreen(P3D);
  colorMode(HSB);
    frameRate(60f);

  image  = loadImage("face.png"); // Load the image
  setupCam();

  background(0);
}

void draw() {
  
  setHue();
  
  if (random(1f) > 0.95f) {
    resetScreen();
  } else {
    fadeScreen();
  }

  setExplosionFactor();

  if (cam.available() == true) {
    cam.read();
    explodeImage();
  }
}

void keyPressed() {
  resetExplosionFactorToBeginning();
  resetScreen();
}
/*
Implementations
 */

private void setupCam() {
  final String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, 1280, 720);
    cam.start();
  }
}

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
  } else if (random(1f) > 0.99f) {
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

private void setHue() {
  if ((hue += 1f) > 255f) {
    hue = 0f;
  }
}

private void explodeImage() {
  final int cellSize = 4;
  final int cellSizeHalf = cellSize / 2;
  final int cols = cam.width / cellSize;
  final int rows = cam.height / cellSize;

  final float xOffset =  (width / 2f) - (cam.width / 2f);
  final float yOffset = (height / 2f) - (cam.height / 2f);
  final float zOffset = -width / 5f;

  //noStroke();
  noFill();
  loadPixels();
  cam.loadPixels();

  for ( int i = 0; i < cols; i++) {
    // Begin loop for rows
    for ( int j = 0; j < rows; j++) {
      final int x = i * cellSize + cellSizeHalf;
      final int y = j * cellSize + cellSizeHalf;
      final int pixelIndex = x + y * cam.width;
      //final color pixelColor = cam.pixels[pixelIndex];
      // Calculate a z position as a function of mouseX and pixel brightness
      final float pixelBrightness = brightness(cam.pixels[pixelIndex]);
      if (pixelBrightness < 10f) {
        continue;
      }

      //pushMatrix();
      //translate(
      //  x + xOffset, 
      //  y + yOffset, 
      //  (explosionFactor * pixelBrightness) + zOffset
      //  );
      stroke(hue, 255f, 255f);
      point(
        x + xOffset, 
        y + yOffset, 
        (explosionFactor * pixelBrightness) + zOffset
        );
      //ellipse(0f, 0f, cellSize, cellSize);
      //popMatrix();
    }
  }
 
}
