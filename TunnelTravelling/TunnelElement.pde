class TunnelElement {

  private PVector position;

  private PVector velocity;

  private float diameter;

  private float strokeWeight;

  private float hue;

  private float saturation = 0.5f + random(0.5f);

  TunnelElement(
    final PVector position_, 
    final PVector velocity_, 
    final float diameter_, 
    final float hue_
    ) {
    position = position_;
    velocity = velocity_;
    diameter = diameter_;
    hue = hue_;

    strokeWeight = 1f;
  }

  PVector getPosition() {
    return position;
  }

  float getDiameter() {
    return diameter;
  }

  float getHue() {
    return hue;
  }

  boolean update() {
    position = PVector.add(position, velocity);
    return position.z < width * 2;
  }

  void draw_(final PVector nextElementPosition, final float alpha) {
    noFill();
    stroke(hue, saturation, 1f, alpha);
    strokeWeight(strokeWeight);

    translate(0f, 0f, position.z);
    ellipse(position.x, position.y, diameter, diameter);
    translate(0f, 0f, -position.z);

    for (float angle = 0f; angle < TWO_PI; angle += (TWO_PI / 64f)) {
      final PVector pointPosition1 = new PVector();
      pointPosition1.x = position.x + (cos(angle) * diameter / 2f);
      pointPosition1.y = position.y + (sin(angle) * diameter / 2f);
      pointPosition1.z = position.z;

      final PVector pointPosition2 = new PVector();
      pointPosition2.x = nextElementPosition.x + (cos(angle) * diameter / 2f);
      pointPosition2.y = nextElementPosition.y + (sin(angle) * diameter / 2f);
      pointPosition2.z = nextElementPosition.z;

      line(pointPosition1.x, pointPosition1.y, pointPosition1.z, pointPosition2.x, pointPosition2.y, pointPosition2.z);
    }

  }
}