class Finger {

  /**
   * Constants
   */

  /**
   * Values
   */

  private float startX;

  private float startY;

  private float currentX;

  private float currentHeight;

  private float maxHeight;

  private float xDirection;

  private float yDirection;

  private float growth;

  /**
   * Constructor
   */

  Finger(final float startX, final float startY) {
    this.startX = startX;
    this.startY = startY;
    currentX = startX;
    maxHeight = height * 0.3f + random(height * 0.7f);
    growth = maxHeight / 128f;
    xDirection = ((int) random(2f) % 2) == 0 ? -1f : 1f;

    initPosition();
  }

  private void initPosition() {
    currentX = startX;
    currentHeight = 1f;
    xDirection = -xDirection;
    yDirection = 1f;
  }

  /**
   * Lifecycle
   */

  boolean drawAndUpdate() {

    initPosition();

    do {
      final float steepness;

      if (currentHeight < maxHeight * 0.33f) {
        steepness = xDirection;
      } else if (currentHeight < maxHeight * 0.66f) {
        steepness = xDirection * 16f;
      } else {
        final float tipFactor = (currentHeight - (maxHeight * 0.66f)) / (maxHeight * 0.33f);
        steepness = xDirection * 16f * tipFactor;
      }

      if (currentHeight > maxHeight) {
        xDirection = -xDirection;
        yDirection = -yDirection;
      }

      //if (currentHeight <= 0f) {
      //  return false;
      //}

      line(
        currentX, 
        startY - currentHeight - 1f, 
        currentX = currentX + random(steepness / 8f), 
        startY - (currentHeight += (yDirection * growth)) 
        );
    } while (currentHeight > 0f);

    return true;
  }
}