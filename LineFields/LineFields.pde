/**
 * Constants
 */

/**
 * Values
 */

private LineField lineField;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080);
   fullScreen();
  // fullScreen(2);
  
  lineField = new LineField();
}

void draw() {
  background(0);
  noFill();
  stroke(0xFFFFFFFF);
  
  lineField.updateAndDraw();
}