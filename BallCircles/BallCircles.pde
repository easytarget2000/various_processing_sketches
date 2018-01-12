/**
 * Constants
 */

private int NUM_OF_OBJECTS = 32;

/**
 * Values
 */

private PVector[] circlePositions;

private boolean freeze;

/**
 * Lifecycle
 */

void setup() {
  size(1920, 1080, P3D);
  // fullScreen();
  // fullScreen(2);
  background(0);

  initCircles();
}

void draw() {
  
  if (freeze) {
    if (random(1f) > 0.33f) {
      return;
    } else {
      freeze = false;
    }
  }

  if (random(1f) > 0.8f) {
    background(0);
  }

  noFill();
  stroke(0xFFFFFFFF);

  final float radius = width / 128f;
  final float initialYRotation = frameCount / 1000f;

  for (final PVector circlePosition : circlePositions) {

    for (float yRotation = 0f; yRotation < TWO_PI; yRotation += 0.2f) {
      rotateY_(yRotation + initialYRotation);
      ellipse(
        circlePosition.x, 
        circlePosition.y, 
        radius, 
        radius
        );
    }
  }

  if (random(1f) > 0.99f) {
    initCircles();
  }
  
  if (random(1f) > 0.9f) {
    freeze = true;
  }
}

private void initCircles() {

  final float maxCenterDistance = height * 0.33f;
  final PVector center = new PVector(width / 2f, height / 2f);

  circlePositions = new PVector[NUM_OF_OBJECTS];
  for (int circleIndex = 0; circleIndex < circlePositions.length; circleIndex++) {
    final float randomAngle = random(TWO_PI);
    final float randomCenterDistance = random(maxCenterDistance);

    final PVector circlePosition = new PVector();
    circlePosition.x = center.x + (cos(randomAngle) * randomCenterDistance);
    circlePosition.y = center.y + (sin(randomAngle) * randomCenterDistance);

    circlePositions[circleIndex] = circlePosition;
  }
}

private void rotateY_(final float angle) {
  translate(width / 2f, 0f);
  rotateY(angle);
  translate(-width / 2f, 0f);
}