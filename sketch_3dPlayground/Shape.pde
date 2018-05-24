class Shape {
  
  //private final PVector ZERO_VECTOR = new PVector(0f, 0f, 0f);
  
  protected PVector position;
  
  protected PVector rotations;
  
  protected Shape(final PVector position_) {
    this(position_, new PVector(0f, 0f, 0f));
  }
  
  protected Shape(final PVector position_, final PVector rotations_) {
    position = position_;
    rotations = rotations_;
  }
   
  void draw_() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    drawShape();
    popMatrix();
  }

  protected void drawShape() {
    point(0f, 0f, 0f);
  }
  
}
