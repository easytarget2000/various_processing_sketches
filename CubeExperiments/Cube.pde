class Cube {
  
  private PVector vector;
  
  private float size;
  
  Cube(final PVector vector_, final float size_) {
    vector = vector_;
    size = size_;
  }
  
  void draw_() {
    pushMatrix();
    translate(vector.x, vector.y, vector.z);
    box(size);
    popMatrix();
  }
  
}
