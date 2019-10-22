class Shape {

  private PVector vector;

  private float width_;

  private float height_;

  private color color_;

  private float maxAngleJitter = 0.001f;

  Shape(
    final PVector vector_, 
    final float width__, 
    final float height__, 
    final color color__
    ) {
    vector = vector_;
    width_ = width__;
    height_ = height__;
    color_ = color__;
  }

  void setColor(final color color__) {
    color_ = color__;
  }

  void draw_(final PVector focusVector) {
    noStroke();
    fill(color_);

    final PVector shapeToFocusVector = PVector.sub(vector, focusVector);
    final float angleToFocus = shapeToFocusVector.heading();

    pushMatrix();
    translate(vector.x, vector.y);
    rotate(jitterAngle(angleToFocus));
    //stroke(0xFFFF00FF);
    rect(0f, 0f, width_, height_);
    popMatrix();
  }

  private float jitterAngle(final float angle) {
    return (angle * (1f - (maxAngleJitter / 2f))) + random(angle * maxAngleJitter);
  }
}
