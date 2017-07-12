/**
 * Constants
 */

private static final int NUM_OF_SHAPES = 16;

private static final float MAX_SIZE_FACTOR = 16f;

/**
 * Values
 */

private float smallestShapeWidth;

private float smallestShapeHeight;

/**
 * Lifecycle
 */

void setup() {

  smallestShapeWidth = width / 10f;
  final float aspectRatio = (float) width / (float) height;
  smallestShapeHeight = smallestShapeWidth * (1f / aspectRatio);

  size(1920, 1080);
}

void draw() {
  background(0);
  
  noFill();
  stroke(0xFFFFFFFF);

  drawShapes();
}

private void drawShapes() {
  final float startX = sin(((millis() % 5000) / 5000f) * PI) * width;
  final float startY = cos(((millis() % 5500) / 5500f) * PI / 2f) * height;
  for (int shapeCounter = 0; shapeCounter < NUM_OF_SHAPES; shapeCounter++) {
    final float sizeFactor = (1f + (MAX_SIZE_FACTOR * (shapeCounter / (float) NUM_OF_SHAPES)));
    rect(
    startX - (sizeFactor * smallestShapeWidth * 0.5f),
    startY - (sizeFactor * smallestShapeHeight * 0.5f),
    smallestShapeWidth * sizeFactor,
    smallestShapeHeight * sizeFactor
    );
  }
}