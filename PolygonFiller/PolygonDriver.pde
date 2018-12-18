class PolygonDriver {
  
  private PShape shape;

  private PVector velocity;
  
  private float angularVelocity;

  private float maxJitter;
  
  PolygonDriver(
    final PShape shape_,
    final PVector velocity_, 
    final float angularVelocity_,
    final float maxJitter_
    ) {
      shape = shape_;
      velocity = velocity_;
      angularVelocity = angularVelocity_;
      maxJitter = maxJitter_;
  }

  void updateAndDraw() {
    update();
    draw_();
  }

  void update() {
    shape.translate(velocity.x, velocity.y);
    velocity.add(getJitter(), getJitter(), 0f);
    shape.rotate(angularVelocity);
  }

  void draw_() {
    shape(shape);
  }
  
  private float getJitter() {
    return (maxJitter / 2f) - random(maxJitter);
  }
}
