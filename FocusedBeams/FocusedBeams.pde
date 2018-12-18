/*
Constants
*/

/*
Variables
*/

private PVector focusVector;

private int shapesPerFrame = 128;

private float minShapeLength;

private float maxShapeLength;

/*
Lifecycle
*/

void setup() {
  size(800, 600);
  fullScreen();
  // size(1024, 1024, P3D);
  // fullScreen(P3D);
  colorMode(HSB, 1f);
  
  focusVector = new PVector(width / 2f, height /2f);
  minShapeLength = 16f;
  maxShapeLength = min(width, height) / 64f;
  
}

void draw() {
  clearScreen();
  drawShapes();
}

/*
Implementations
 */

private void clearScreen() {
  background(0);

  //noStroke();
  //fill(0f, 0f, 0f, 0.1f);
  //rect(0f, 0f, width, height);
}

private void drawShapes() {
  
  for (int i = 0; i < shapesPerFrame; i++) {
    drawRandomShape();
  }
  
}

private void drawRandomShape() {
  final PVector shapePosition = new PVector(random(width), random(height));
  final float shapeLength = minShapeLength + random(maxShapeLength - minShapeLength);
  
}
