class LineField {

  private static final int NUM_OF_COLUMNS = 64;

  private Line[] lines;

  LineField() {
    final float cellSize = width / (float) NUM_OF_COLUMNS;
    final float lineRadius = cellSize / 2f;
    final int numOfRows = (int) (((float) height / cellSize) + 1);

    lines = new Line[NUM_OF_COLUMNS * numOfRows];

    for (int column = 0; column < NUM_OF_COLUMNS; column++) {
      for (int row = 0; row < numOfRows; row++) {
        final PVector lineCenterVector = new PVector();
        final float lineAngle = getRandomLineAngle();
        lineCenterVector.x = (cellSize / 2f) + (cellSize * column);
        lineCenterVector.y = (cellSize / 2f) + (cellSize * row);

        final int index = column + row * NUM_OF_COLUMNS;
        lines[index] = new Line(lineCenterVector, lineAngle, lineRadius);
        //println("Line[" + (column + row) + "]: " + lines[column + row]);
      }
    }
  }

  void updateAndDraw() {
    for (final Line line : lines) {
      line.drawAndUpdate();
      if (random(1f) > 0.99f) {
        line.angle = getRandomLineAngle();
      }
    }
  }

  private float getRandomLineAngle() {
    return random(TWO_PI);
    //return (PI * 0.75f) * random(1f) > 0.67f ? 1 : 2;
  }

  private class Line {

    private PVector centerVector;

    private float angle;

    private float radius;

    Line(final PVector centerVector_, final float angle_, final float radius_) {
      centerVector = centerVector_;
      angle = angle_;
      radius = radius_;
    }

    String toString() {
      return "[Line: Center: " + centerVector.x + ", " + centerVector.y + "]";
    }

    void drawAndUpdate() {
      draw_();
      update_();
    }
    
    void draw_() {
      final float deltaX = cos(angle) * radius;
      final float deltaY = sin(angle) * radius;

      line(
        centerVector.x + deltaX, 
        centerVector.y + deltaY, 
        centerVector.x - deltaX, 
        centerVector.y - deltaY
        );
    }
    
    void update_() {
      angle += 0.1f;
    }
  }
}