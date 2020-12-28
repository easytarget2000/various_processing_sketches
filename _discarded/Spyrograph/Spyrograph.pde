/**
 * Constants
 */

/**
 * Values
 */

private ShapeMover shapeMover;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080);
  fullScreen();
  // fullScreen(2);
  background(0);
    frameRate(60f);

  initShapeMovers();
}

void draw() {
  //background(0);
  updateAndDrawShapes();
}

/*
 * Implementation
 */

private void initShapeMovers() {
  final float radiusLimit = min(width, height) * 0.33f;
  final PVector centerPosition = new PVector(width / 2f, height / 2f);
  final float trackRadiusFactor = 0.33f + random(0.67f);
  final float trackRadiusVelocity = getRandomTrackRadiusVelocity();
  final float angleOnTrack = 0f;
  final float angleOnTrackVelocity = TWO_PI / 100f;

  shapeMover = new ShapeMover(
    radiusLimit, 
    centerPosition, 
    trackRadiusFactor, 
    trackRadiusVelocity, 
    angleOnTrack, 
    angleOnTrackVelocity
    );
}

private void updateAndDrawShapes() {
  background(0);
  shapeMover.update();
  noFill();
  stroke(0x30FFFFFF);


  final PVector center = new PVector(width / 2f, height / 2f);
  final float maxRadius = min(width, height) * 0.33f;
  float currentRadius = maxRadius * 0.33f;

  final float startAngle = 0f;// millis() % 1000f / 1000f * TWO_PI;
  final float maxAngle = TWO_PI + startAngle;
  final int numOfCircles = 128;
  final float angleStep = TWO_PI / numOfCircles;
  
  for (float angle = startAngle; angle < maxAngle; angle += angleStep) {
    currentRadius += getJitter(32f);
    final float x = center.x + (cos(angle) * (maxRadius - currentRadius / 2f));
    final float y = center.y + (sin(angle) * (maxRadius - currentRadius / 2f));
    ellipse(x, y, currentRadius, currentRadius);
  }
}

private float getJitter(final float range) {
  return (range / 2f) - random(range);
}

private float getRandomTrackRadiusVelocity() {
  return 2f;
}
