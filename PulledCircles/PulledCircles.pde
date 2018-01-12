/**
 * Constants
 */

/**
 * Values
 */

private PulledCircle[] circles;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080);
  fullScreen();
  // fullScreen(2);
  background(0);
  noFill();
  noCursor();

  initCircles();
}

void draw() {
  //background(0);

  rotateCamera();

  if (random(1f) > 0.5f) {
    final color c = getRandomColor();
    stroke(c);
    fill(c);
  } else {
    //stroke(0xFF000000);
    //fill(0xF000000);
  }

  for (final PulledCircle circle : circles) {
    circle.draw_();
  }
}

/*
 Implementations
 */

private void initCircles() {
  circles = new PulledCircle[1];
  final float circleRadius = width / 8f;

  for (int i = 0; i < circles.length; i++) {
    circles[i] = new PulledCircle(circleRadius);
  }
}

private void rotateCamera() {
  translate(width / 2f, 0f);
  rotateY(frameCount / 128f);
  translate(-width / 2f, 0f);
}

//private color getRandomColor() {
//  final int brightness = (int) random(255) + 0;
//  return color(
//    brightness, 
//    brightness, 
//    brightness, 
//    0x15
//    );
//}

private color getRandomColor() {
  return color(
    (int) random(255) + 0, 
    (int) random(255) + 0, 
    (int) random(255) + 0, 
    0x15
    );
}