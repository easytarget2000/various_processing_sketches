/*
Constants
 */

/*
Variables
 */

private PVector focusVector;

private int numOfShapesToInit = 1024;

private ArrayList<Shape> shapes;

private boolean drawFocus = true;

private float fadeAlpha = 0.05f;

private int shapeAlpha = 50;

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
  //fadeClearScreen();
  clearScreen();
  setFocusPosition();
  drawShapes();

  if (drawFocus) {
    drawFocus();
  }
}

void mouseClicked() {
  //setFocusPosition();
}

/*
Implementations
 */

private void setFocusPosition() {
  focusVector = new PVector(mouseX, mouseY);
}

private void setShapeValues() {
  final float minShapeWidth = 16f;
  final float maxShapeWidth = min(width, height) / 2f;
  final float minShapeHeight = minShapeWidth * 0.33f;
  final float maxShapeHeight = minShapeHeight * 3f;

  shapes = new ArrayList<Shape>();
  for (int i = 0; i < numOfShapesToInit; i++) {
    final PVector shapeVector = getRandomShapeVector();
    final float shapeWidth = minShapeWidth + (noise(shapeVector.x, shapeVector.y) * (maxShapeWidth - minShapeWidth));
    final float shapeHeight = minShapeHeight + random(maxShapeHeight - minShapeHeight);
    final color shapeColor = getRandomColor(shapeVector.x, shapeVector.y, shapeAlpha);
    final Shape shape = new Shape(
      shapeVector, 
      shapeWidth, 
      shapeHeight, 
      shapeColor
      );
    shapes.add(shape);
  }
}

private PVector getRandomShapeVector() {
  return new PVector(
    (width * 0.05f) + (width * random(0.9f)),
    (height * 0.05f) + (height * random(0.9f))
  );
}

private void clearScreen() {
  background(0);
}

private void fadeClearScreen() {
  noStroke();
  fill(0f, 0f, 0f, fadeAlpha);
  rect(0f, 0f, width, height);
}

private void drawShapes() {

  for (final Shape shape : shapes) {
    shape.draw_(focusVector);
  }
}

private void drawFocus() {
  stroke(0xFFFFFFF);
  point(focusVector.x, focusVector.y);
}
