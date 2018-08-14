class Line {
  
  private float angle;
  
  private color color_;
  
  Line(final float angle, final color color_) {
    this.angle = angle;
    this.color_ = color_;
  }
  
  color getColor() {
    return color_;
  }
  
  PVector getEndpoint(final PVector startingPoint, final float length) {
     return new PVector(
       startingPoint.x + (cos(angle) * length),
       startingPoint.y + (sin(angle) * length)
     );
  }
  
  void updateAngle() {
    angle += TWO_PI / 16f;
  }
}
