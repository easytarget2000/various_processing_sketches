/*
* Constants
 */

private static final int NUM_OF_COLUMNS = 3;

private static final int[] COLORS = {
  0x30D66927, 0x30FF00FF, 0x30FFFFFF
};

/*
* Attributes
 */

private int numOfRows;

private float circleDistance;

private float circleRadius;

private float maxJitterDistance;

/*
* Lifecycle
 */

void setup() {
  //size(1920, 1080);
  fullScreen(2);
  numOfRows = NUM_OF_COLUMNS / (width / height);
  circleDistance = (width / (float) (NUM_OF_COLUMNS * 0.67));
  circleRadius = circleDistance * 0.67f;
  maxJitterDistance = circleDistance / 30f;
  
  background(0);
}

void draw() {
  //background(0);
  drawCircles();
}

private void drawCircles() {
  //noStroke();

  for (int column = 0; column < NUM_OF_COLUMNS; column++) {
    for (int row = 0; row < numOfRows; row++) {
      drawCircles(column, row);
    }
  }
}

private void drawCircles(final float column, final float row) {
  final float startX = (column * circleDistance);
  final float startY = (row * circleDistance) + (circleDistance * sin(100f / (millis() % 2000)));
  for (int i = 0; i < COLORS.length; i++) {
    //fill(COLORS[i]);
    //ellipse(
    //  //x,
    //  //y,
    //  x + cos(i * millis() * 0.001) * circleDistance, 
    //  y + sin((COLORS.length - i) * millis() * 0.001)* circleDistance, 
    //  circleRadius, 
    //  circleRadius
    //  );

    stroke(COLORS[i]);
    final float x = startX + cos(i * millis() * 0.001) * circleDistance;
    final float y = startY + sin((COLORS.length - i) * millis() * 0.001)* circleDistance;
    line(
      x, 
      y, 
      width /2f, 
      height / 2f
      );
      
      
  }
}

private float getJitter() {
  return (maxJitterDistance / 2f) - random(maxJitterDistance);
}