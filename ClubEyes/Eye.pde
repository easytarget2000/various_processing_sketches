class Eye {

  private PVector position;

  private float eyeballWidth;

  private float eyeballHeight;

  private float pupilWidth;
  
  private float pupilHeight;

  private color eyeballColor;

  Eye(
    final PVector position_, 
    final float width_, 
    final float height_, 
    final color eyeballColor_
    ) {
    position = position_;
    eyeballWidth = width_;
    eyeballHeight = height_;
    eyeballColor = eyeballColor_;

    setPupilSize();
  }

  void draw_() {
    noStroke();
    
    drawEyeBall();
    drawPupil();
    
    if (random(1f) > 0.9f) {
      setPupilSize();
    }
  }
  
  private void setPupilSize() {
    pupilWidth = random(eyeballWidth);
    pupilHeight = random(eyeballHeight);
  }
  
  private void drawEyeBall() {
    fill(eyeballColor);
    ellipse(
      position.x, 
      position.y, 
      eyeballWidth, 
      eyeballHeight
      );
  }
  
  private void drawPupil() {
    fill(0xFF000000);
    ellipse(
      position.x, 
      position.y, 
      pupilWidth, 
      pupilHeight
      );
  }
}