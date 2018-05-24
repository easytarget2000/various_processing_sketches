class Circle {

  private PVector position;

  private float diameter;

  private float width_;

  private color color_;

  Circle(
    final PVector position_, 
    final float diameter_, 
    final float width__, 
    final color color__
    ) {
    position = position_;
    diameter = diameter_;
    width_ = width__;
    color_ = color__;
  }

  void update(final float growth) {
    diameter += growth;
  }

  void draw_() {
    noFill();
    strokeWeight(width_);
    stroke(color_);
    ellipse(
      position.x, 
      position.y, 
      diameter, 
      diameter
      );
  }
}
