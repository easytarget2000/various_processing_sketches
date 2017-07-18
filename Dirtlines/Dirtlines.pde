/**
 * Constants
 */

private static final int NUM_OF_COLUMNS = 512;


/**
 * Values
 */

private Column[] column;

/**
 * Lifecycle
 */

void setup() {
  size(1920, 1080);
  // fullScreen();
  // fullScreen(2);
  background(0);

  final float xSpacing = (float) width / (float) NUM_OF_COLUMNS;

  column = new Column[NUM_OF_COLUMNS];
  float lastY = -height * 0.1f;
  final float columnHeight = height * 1.2f;
  for (int i = 0; i < NUM_OF_COLUMNS; i++) {
    column[i] = new Column(
      xSpacing * i, 
      lastY += random(16f) - 8f, 
      columnHeight
      );
  }
}

void draw() {
  background(0);

  stroke(0xFFFFFFFF);

  for (final Column point : column) {
    point.drawConfigured();
    point.x += 1f;
  }
}

class Column {

  private static final int NUM_OF_ROWS = 128;

  private float x;

  private float y;

  private float rowOffset;

  Column(final float x, final float y, final float height) {
    this.x = x;
    this.y = y;
    rowOffset = (float) height / (float) NUM_OF_ROWS;
  }

  void drawConfigured() {
    for (int row = 0; row < NUM_OF_ROWS; row++) {
      point(x, y + (row * rowOffset));
    }
  }
}