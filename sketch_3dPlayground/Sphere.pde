class Sphere extends Shape {
  
  private float radius;
  
  Sphere(final PVector position_, final float radius_) {
    super(position_);
    radius = radius_;
  }
  
  protected void drawShape() {
    sphere(radius);
    
    if (position.x > 0f) {
      position.x--;
    } else {
      if (position.y < 512f) {
        position.y++;
      } else {
        position.y = 0f;
        position.x = 512f;
      }
    }
  }
}
