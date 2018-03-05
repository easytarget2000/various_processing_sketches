// Based on https://github.com/junkiyoshi/Insta20170817

/**
 * Constants
 */

/**
 * Values
 */

private float radiusStep = 4f;

private int counter = 0;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080, P3D);
  fullScreen(P3D, 2);
  //fullScreen(2);
  //size(1280, 720, P3D);
  background(0);

  colorMode(HSB, 255);
  strokeWeight(2f);
  noFill();
}

void draw() {
  if (random(1f) > 0.9f) {
    background(0);
    return;
  }
  
  //lights();

  //if (random(1f) < 0.7f) {
  //  background(0);
  //}

  float angle = 0;
  translate(width / 2f, height / 2f, 0f); 

  stroke(map((frameCount % 360) / 4f, 0, 360, 0, 255), 255, 255);

  for (float radius = 1f; radius < 128f; radius += radiusStep) {

    rotateY(counter * 0.0025);
    rotateX(counter * 0.0001);
    angle += counter * 0.5;

    //ofColor c;
    //final color c;
    //stroke(map((int)(angle) % 360, 0, 360, 0, 255), 255, 255);
    //ofSetColor(c);

    float x = 1920 + radius * cos(counter * DEG_TO_RAD);
    float y = 512 + radius * sin(counter * DEG_TO_RAD);

    box(x, y, width / 2f );
  }

  counter += 1;
}

void keyPressed() {

  switch (key) {
  case 'z':
    radiusStep *= 2f;
    if (radiusStep > 64f) {
      radiusStep = 2f;
    }
    break;

  case 'x':
    radiusStep /= 2f;
    if (radiusStep < 2f) {
      radiusStep = 64f;
    }
    break;

  case ' ':
    counter = (int) random(2000f);
  }
}