class Worm {

  private static final float DIRECTION_NUDGE = 0.1f;

  private PVector initialPosition;

  private PVector position;

  private float radius;

  private PVector direction;

  private float velocity;

  Worm(final PVector initialPosition_, final float radius_) {
    initialPosition = initialPosition_;
    position = initialPosition;
    radius = radius_;

    setRandomDirection();

    velocity = 2f + random(width / 2048f);
  }

  void update() {

    final PVector scaledDirection = PVector.mult(direction, velocity);
    position =  PVector.add(position, scaledDirection);

    //if (random(1f) > 0.99f) {
    //  setRandomDirection();
    //} else 
    if (random(1f) > 0.5f) {
      adjustDirection();
    }

    if (isOutOfBounds()) {
      if (random(1f) > 0.33f) {
        velocity = -velocity;
      } else {
        position = initialPosition;
      }
    }
  }

  void drawConfigured() {
    //println("drawConfigured(): " + position.x + ", " + position.y);

    //ellipse(
    //  position.x, 
    //  position.y, 
    //  radius, 
    //  radius
    //  );

    pushMatrix();
    translate(position.x, position.y, position.z);

    sphere(radius /2f);
    popMatrix();
  }

  private void setRandomDirection() {
    direction = new PVector();
    direction.x = 1f - random(2f);
    direction.y = 1f - random(2f);
    direction.z = 1f - random(2f);
    direction.normalize();
  }

  private void adjustDirection() {
    final float xNudgeSign = random(1f) > 0.5f ? 1f : -1f;
    direction.x = direction.x + (xNudgeSign * DIRECTION_NUDGE);
    final float yNudgeSign = random(1f) > 0.5f ? 1f : -1f;
    direction.y = direction.y + (yNudgeSign * DIRECTION_NUDGE);
    direction.normalize();
  }

  private boolean isOutOfBounds() {
    return position.x - radius < 0 || position.x + radius > width
      || position.y - radius < 0  || position.y + radius > height;
  }
}