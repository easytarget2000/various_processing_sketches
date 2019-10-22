class Wanderer {

  private PVector vector;

  private PVector velocity;

  Wanderer(final PVector vector_) {
    vector = vector_;
    final float maxVelocity = 10f;
    final float xVelocity = -(maxVelocity / 2f) + (maxVelocity * noise(vector.x));
    final float yVelocity = -(maxVelocity / 2f) + (maxVelocity * noise(vector.y));
    velocity = new PVector(xVelocity, yVelocity);
  }

  void updateAndDraw(
    final PVector focusVector, 
    final float minFocusVectorDistance, 
    final float maxFocusVectorDistance
    ) {

    stroke(0xFFFFFFFF);
    point(vector.x, vector.y);
    final float focusVectorDistance = PVector.dist(vector, focusVector);

    if (focusVectorDistance < maxFocusVectorDistance && focusVectorDistance > minFocusVectorDistance) {
      return;
    }

    vector.add(velocity);
    final PVector accelerationVector = new PVector(noise(vector.x), noise(vector.y));
    velocity.add(accelerationVector);
  }
}
