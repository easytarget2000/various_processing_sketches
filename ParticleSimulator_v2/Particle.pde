class Particle { //<>//

  private static final float COLOR_SATURATION = 0.5f;

  private static final float COLOR_MAX_BRIGHTNESS = 1f;

  private static final float COLOR_ALPHA = 1f;

  private PVector position;

  private PVector lastPosition;

  private PVector velocity = new PVector(0f, 0f);

  private PVector acceleration = new PVector(0f, 0f);

  private float mass;

  private float hue;

  Particle(final PVector position_, final PVector velocity_, final float mass_, final float hue_) {
    position = position_;
    lastPosition = position;
    velocity = velocity_;
    mass = mass_;
    hue = hue_;
  }

  PVector getPosition() {
    return position;
  }

  void update(final Particle[] allParticles, final PVector attractorForce) {
    final PVector force = PVector.add(accumulateForce(allParticles), attractorForce);
    acceleration = PVector.div(force, mass);
    velocity.add(acceleration);
    lastPosition = position.copy();
    position.add(velocity);
  }

  void draw_(final float forceMagnitude) {
    //final float hue = forceMagnitude / 64f;
    stroke(hue, COLOR_SATURATION, COLOR_MAX_BRIGHTNESS, COLOR_ALPHA);
    //stroke(0f, 0f, 0f, 1f);
    //point(position.x, position.y);
    line(lastPosition.x, lastPosition.y, position.x, position.y);
    //lastPosition = position;
    //point(position.x + 3f, position.y + 3f);
    //ellipse(position.x, position.y, mass, mass);
  }

  private PVector accumulateForce(final Particle[] allParticles) {
    final PVector force = new PVector(0f, 0f);
    for (final Particle otherParticle : allParticles) {
      if (otherParticle == this) {
        continue;
      }

      final PVector vectorToParticle = PVector.sub(otherParticle.getPosition(), position);
      final float distanceToParticle = PVector.dist(otherParticle.getPosition(), position);
      final PVector forceOnParticle = PVector.mult(vectorToParticle, 128f / distanceToParticle);
    }

    return force;
  }
}
