class Being {
  
  private PVector position;
  
  private float size;
  
  private float growthRate;
  
  private float maxSize;
  
  private color color_;
  
  private Being() {
    size = min(width, height) / 128f;
    growthRate = size / 4f;
    maxSize = size * 48f;
  }
  
  Being(final PVector position_, final color color__) {
    this();
    position = position_;
    color_ = color__;
  }
  
  boolean updateAndDraw() {
    size += growthRate;
    
    if (size > maxSize) {
      return false;
    }
    
    //noStroke();
    //fill(color_);
    
    noFill();
    stroke(color_);
    
    rect(position.x, position.y, size, size);
    //ellipse(position.x, position.y, size, size);
    
    return true;
  }
}