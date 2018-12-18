/*
Constants
 */

/*
Variables
 */

private PVector focusVector;

private int shapesPerFrame = 1;

private float minShapeLength;

private float maxShapeLength;

private float shapeHeight;

private boolean drawFocus = true;

/*
Lifecycle
 */

void setup() {
  //size(800, 600);
  fullScreen();
  // size(1024, 1024, P3D);
  // fullScreen(P3D);
  colorMode(HSB, 1f);

  setFocusPosition();
  setShapeValues();

  clearScreen();
}

void draw() {
  //clearScreen();
  drawShapes();

  if (drawFocus) {
    drawFocus();
  }
}

void mouseClicked() {
  setFocusPosition();
}

/*
Implementations
 */

private void setFocusPosition() {
  focusVector = new PVector(width / 2f, height / 2f);//new PVector(mouseX, mouseY);
  clearScreen();
}

private void setShapeValues() {
  minShapeLength = 16f;
  maxShapeLength = min(width, height) / 2f;
  shapeHeight = minShapeLength * 0.66f;
}

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
  setFillColor();

  final PVector shapeVector = new PVector(128f, 512f); //new PVector(random(width), random(height));
  final PVector shapeToFocusVector = shapeVector.sub(focusVector);
  final float angleToFocus = PVector.angleBetween(shapeVector, shapeToFocusVector);
  final float shapeLength = 128f; //minShapeLength + random(maxShapeLength - minShapeLength);

  stroke(0xFFFFF00);
  line(shapeVector.x, shapeVector.y, focusVector.x, focusVector.y);

  pushMatrix();
  translate(shapeVector.x, shapeVector.y);
  //rotate(angleToFocus);
  //stroke(0xFFFF00FF);
  //rect(0f, 0f, shapeLength, shapeHeight);
  popMatrix();
}

private void setFillColor() {
  noStroke();
  final float hue = random(1f);
  final float saturation = 0.8f;
  final float brightness = 0.6f;
  final float alpha = 0.5f;
  fill(hue, saturation, brightness, alpha);
}

private void drawFocus() {
  stroke(0xFFFFFFF);
  point(focusVector.x, focusVector.y);
}

private float angle(final PVector v1, final PVector v2) {
  float angle = atan2(v2.y, v2.x) - atan2(v1.y, v1.x);
  if (angle < 0f) {
    angle += TWO_PI;
  }
  return angle;
}
