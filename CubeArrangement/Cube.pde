class Cube {
  
  private PVector vector;
  
  private float sizeX;
  
  private float sizeY;
  
  private float sizeZ;
  
  Cube(final PVector vector_, final float size) {
    vector = vector_;
    sizeX = size;
    sizeY = size;
    sizeZ = size;
  }
    
  void draw_() {
    pushMatrix();
    translate(vector.x, vector.y, vector.z);
    box(sizeX, sizeY, sizeZ);
    popMatrix();
  }
  
}
