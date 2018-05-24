class Box extends Shape {

  private PVector sideLengths;

  Box(final PVector position_, final PVector sideLengths_) {
    super(position_);
    sideLengths = sideLengths_;
  }

  Box(final PVector position_, final PVector rotations_, final PVector sideLengths_) {
    super(position_, rotations_);
    sideLengths = sideLengths_;
  }

  protected void drawShape() {
    box(sideLengths.x, sideLengths.y, sideLengths.z);
  }
}
