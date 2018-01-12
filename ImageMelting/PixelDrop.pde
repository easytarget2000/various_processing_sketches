class PixelDrop {

  private PVector position;

  private PVector movement;

  private color color_;

  PixelDrop(final PVector position_, final color color__) {
    position = position_;

    final float minYMovement = height / 2048f;
    final float maxYMovement = height / 128f;
    movement = new PVector(
      0f, 
      minYMovement + random(maxYMovement)
      );
    color_ = color__;
  }

  boolean drawAndUpdate() {
    final PVector newPosition = PVector.add(position, movement);

    stroke(color_);
    line(
      position.x, 
      position.y, 
      newPosition.x, 
      newPosition.y
      );

    position = newPosition;

    if (random(1f) > 0.9f) {
      return false;
    } else {
      return position.x > 0 && position.x < width && position.y > 0 && position.y < height;
    }
  }
}