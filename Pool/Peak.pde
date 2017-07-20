class Peak {

  private Peak nextPeak;

  private float x;

  private float y;

  Peak(final Peak nextPeak, final float x, final float y) {
    this.nextPeak = nextPeak;
    this.x = x;
    this.y = y;
  }

  @Override
    String toString() {
    return "[" + super.toString() + " - " + x * y + " - x: " + x + ", y: " + y + "]";
  }

  boolean updateAndDraw() {

    Peak currentPeak = nextPeak;
    Peak closestPeak = null;
    float closestPeakDistance = x * 2f;
    while (currentPeak != null && currentPeak != this) {

      final float distanceToOtherPeak = distanceToPeak(currentPeak);
      if (distanceToOtherPeak < 512f) {
        
        final float lineLength = distanceToOtherPeak * (1f - (distanceToOtherPeak / 512f));
        
        final float angleToOtherPeak = angleToPeak(currentPeak);

        line(
          x, 
          y, 
          x + (cos(angleToOtherPeak) * lineLength), 
          y + (sin(angleToOtherPeak) * lineLength)
          );
      }

      currentPeak = currentPeak.nextPeak;
    }

    //x += getJitter();
    y += getJitter();

    point(x, y);

    if (x < 0f || x > width || y < 0f || y > height) {
      return false;
    } else {
      return true;
    }
  }

  private float getJitter() {
    return 4f - random(8f);
  }

  private float distanceToPeak(final Peak otherPeak) {
    return distance(x, y, otherPeak.x, otherPeak.y);
  }

  private float distance(
    final float x1, 
    final float y1, 
    final float x2, 
    final float y2
    ) {
    return sqrt(
      pow((x2 - x1), 2) + pow((y2 - y1), 2)
      );
  }

  private float angleToPeak(final Peak otherPeak) {
    return angle(x, y, otherPeak.x, otherPeak.y);
  }

  private float angle(
    final float x1, 
    final float y1, 
    final float x2, 
    final float y2
    ) {
    final float calcAngle = atan2(
      -(y1 - y2), 
      x2 - x1
      );

    if (calcAngle < 0) {
      return calcAngle + TWO_PI;
    } else {
      return calcAngle;
    }
  }
}