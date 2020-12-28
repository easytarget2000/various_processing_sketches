class Being {

  private static final float ATTRACTOR_LINE_LENGTH_HALF = 16f;

  private PVector position;

  private PVector velocity;

  private float size;

  private color closeColor = 0x30C7F464;

  private color farColor = 0xCCFF6B6B;

  private float maxJitter;

  private float maxJitterHalf;

  private float attractorEventHorizon = 128f;

  private float attractorMaxDistance = min(width, height);

  Being(
    final PVector position_, 
    final PVector velocity_, 
    final float size_ 
    ) {
    position = position_;
    size = size_;
    velocity = velocity_;

    maxJitter = 1f;
    maxJitterHalf = maxJitter / 2f;
  }

  void updateAndDraw(final PVector attractorPosition, final boolean drawStroke) {
    jitter();
    final PVector vectorToAttractor = PVector.sub(attractorPosition, position);

    float attractorDistance = dist(vectorToAttractor);
    if (attractorDistance < 0.1f) {
      attractorDistance = 0.1f;
    } else if (attractorDistance > attractorMaxDistance) {
      attractorDistance = attractorMaxDistance;
    }

    if (attractorDistance < attractorEventHorizon) {
      velocity.mult(0.9f);
    }

    final PVector acceleration = PVector.mult(vectorToAttractor.normalize(), attractorDistance / 256f);
    velocity = PVector.add(velocity, acceleration);
    position = PVector.add(position, velocity);

    drawConfigured(attractorDistance, drawStroke);
  }

  private void drawConfigured(final float attractorDistance, final boolean drawStroke) {
    fill(getColor(attractorDistance));
    if (drawStroke) {
      stroke(0xFF000000);
    } else {
      noStroke();
    }

    pushMatrix();
    translate(position.x, position.y, position.z);
    sphere(size);
    popMatrix();
    
    //ellipse(position.x, position.y, size, size);
  }

  private color getColor(final float attractorDistance) {
    final float distanceFactor = map(
      attractorDistance, 
      attractorEventHorizon, 
      attractorMaxDistance, 
      0f, 
      1f
      );
    return lerpColor(closeColor, farColor, distanceFactor);
  }

  void drawAttractor(final PVector attractorPosition) {
    stroke(0xFFFFFFFF);
    line(
      attractorPosition.x - ATTRACTOR_LINE_LENGTH_HALF, 
      attractorPosition.y, 
      attractorPosition.z, 
      attractorPosition.x + ATTRACTOR_LINE_LENGTH_HALF, 
      attractorPosition.y, 
      attractorPosition.z
      );

    line(
      attractorPosition.x, 
      attractorPosition.y - ATTRACTOR_LINE_LENGTH_HALF, 
      attractorPosition.z, 
      attractorPosition.x, 
      attractorPosition.y + ATTRACTOR_LINE_LENGTH_HALF, 
      attractorPosition.z
      );

    line(
      attractorPosition.x, 
      attractorPosition.y, 
      attractorPosition.z - ATTRACTOR_LINE_LENGTH_HALF, 
      attractorPosition.x, 
      attractorPosition.y, 
      attractorPosition.z + ATTRACTOR_LINE_LENGTH_HALF
      );
  }

  private void jitter() {
    final PVector jitterVector = new PVector(
      maxJitterHalf - random(maxJitter), 
      maxJitterHalf - random(maxJitter), 
      maxJitterHalf - random(maxJitter)
      );

    velocity = PVector.add(velocity, jitterVector);
  }

  private float dist(final PVector pvector) {
    return sqrt(
      (pvector.x * pvector.x) +
      (pvector.y * pvector.y) +
      (pvector.z * pvector.z)
      );
  }
}
