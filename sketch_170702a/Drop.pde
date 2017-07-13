class Drop {

  /**
   * Values
   */

  private float x;

  private float y;
  
  private float lastX;
  
  private float lastY;

  private float size;

  private float destinationY;

  private float destinationHorizon;

  private float xVelocity = 0f;

  private float yVelocity = 0f;

  private float minX;

  private float maxX;

  private float minY;

  private float maxY;

  private float maxVelocity;

  /**
   * Constructor
   */

  Drop(final float x, final float y) {
    this.x = x;
    lastX = x;
    this.y = y;
    lastY = y;
    //y = random(height);
    //y = height / 2f;
    size = min(width, height) / 1000f;
    destinationHorizon = size / 3f;
    setDestination();

    minX = -width * 0.1f;
    maxX = width - (minX * 2f);
    minY = -height * 0.1f;
    maxY = height - (minY * 2f);

    maxVelocity = 0.1f;
  }

  /**
   * Getter
   */

  float getYVelocity() {
    return yVelocity;
  }

  float getXVelocity() {
    return xVelocity;
  }

  /** 
   * Lifecycle
   */

  void drawConfigured() {
    for (float yOffset = -(height / 2f); yOffset <= (height / 2f); yOffset += height / 16f) {
      //point(x, y + yOffset);
      line(lastX, lastY + yOffset, x, y + yOffset);
    }
    lastX = x;
    lastY = y;
    //ellipse(x, destinationY, size * 1.5, size * 1.5);
    //line(x, y, x, y + velocity);
  }

  boolean update(final float accumulatedXVelocity, final float accumulatedYVelocity) {
    final float destinationDistance = getDestinationDistance();
    if (abs(destinationDistance) < destinationHorizon) {
      setDestination();
    } else {
      xVelocity += getJitterVelocity(); //destinationDistance / 10000f;
      yVelocity += getJitterVelocity();
      x += (xVelocity + accumulatedXVelocity) / 2f;
      y += (yVelocity + accumulatedYVelocity) / 2f;

      if (x < minX) {
        x = minX;
      } else if (x > maxX) {
        x = maxX;
      }

      if (y < minY) {
        y = minY;
      } else if (y > maxY) {
        y = maxY;
      }
    }

    return true;
  }

  private void setDestination() {
    destinationY = random(height);
  }

  private float getJitterVelocity() {
    return random(maxVelocity) - (maxVelocity / 2f);
  }

  private float getDestinationDistance() {
    return y - destinationY;
  }
}