// Based on https://github.com/junkiyoshi/Insta20170817

/**
 * Constants
 */

/**
 * Values
 */

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080, P3D);
   fullScreen(P3D);
  // fullScreen(2);
  background(0);

  colorMode(HSB, 255);
  strokeWeight(16f);
}

void draw() {
  background(0);

  float angle = 0;

  for (float radius = 16; radius < 1024; radius += 32) {
    float tmp_x = 0f;
    float tmp_y = 0f;

    rotateY(frameCount * 0.0025);
    angle += frameCount * 0.25;

    //ofColor c;
    //final color c;
    stroke(map((int)(angle) % 360, 0, 360, 0, 255), 255, 255);
    //ofSetColor(c);

    for (float deg = frameCount; deg < frameCount + 256; deg += 0.1) {
      float x = 1920 + radius * cos(deg * DEG_TO_RAD);
      float y = 512 + radius * sin(deg * DEG_TO_RAD);

      if (tmp_x != 0 && tmp_y != 0) {
        line(x, y, tmp_x, tmp_y);
      }

      tmp_x = x;
      tmp_y = y;
    }
  }
}