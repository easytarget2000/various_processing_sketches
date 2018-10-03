public class FoliageNode {

  private FoliageNode next;

  private PVector vector;

  private float displaySize = max(width, height);

  private float pushForce = displaySize * 0.0047f;

  private float jitter = displaySize * 0.0005f;

  private float radius = displaySize / 256f;

  private float neighbourGravity = -radius * 0.5f;

  private float preferredNeighbourDistance = displaySize * 0.001f;

  private float maxPushDistance = displaySize * 0.1f;

  private FoliageNode() {
  }

  private FoliageNode(final PVector vector_) {
    vector = vector_;
  }

  @Override
    public String toString() {
    return "[Line " + super.toString() + " at " + vector.x + ", " + vector.y + "]";
  }

  private float distanceToNode(final FoliageNode otherNode) {
    return PVector.dist(vector, otherNode.vector);
  }

  private PVector vectorToOtherNode(final FoliageNode otherNode) {
    return PVector.sub(otherNode.vector, vector);
  }

  private float angle(final FoliageNode otherNode) {
    return angle(vector.x, vector.y, otherNode.vector.x, otherNode.vector.y);
  }

  private float angle(
    final float x1, 
    final float y1, 
    final float x2, 
    final float y2
    ) {
    final float calcAngle = atan2(
      -(y1 - y2), 
      x2 - x1
      );

    if (calcAngle < 0) {
      return calcAngle + TWO_PI;
    } else {
      return calcAngle;
    }
  }

  public void update() {

    vector.x += getJitter();
    vector.y += getJitter();
    vector.z += getJitter();

    updateAcceleration();
  }

  private void updateAcceleration() {
    FoliageNode otherNode = next;

    float force = 0f;
    float angle = 0f;

    addAccelerationToAttractor();

    do {

      final float distance = distanceToNode(otherNode);

      if (distance > maxPushDistance) {
        otherNode = otherNode.next;
        continue;
      }

      final PVector vectorToOtherNode = vectorToOtherNode(otherNode);
      //println("From: " + components(vector) + " to: " + components(otherNode.vector) + " --> : " + components(vectorToOtherNode));
      angle = angle(otherNode) + (angle * 0.05);

      force *= 0.05;

      if (otherNode == next) {

        if (distance > preferredNeighbourDistance) {
          //                        force = mPreferredNeighbourDistanceHalf;
          force += (distance / pushForce);
        } else {
          force -= neighbourGravity;
        }
      } else {

        if (distance < radius) {
          force -= radius;
        } else {
          force -= (pushForce / distance);
        }
      }

      vector.add(vectorToOtherNode.setMag(force));

      otherNode = otherNode.next;
    } while (otherNode != null && otherNode != this);
  }

  private void addAccelerationToAttractor() {
    final PVector attractorPosition = new PVector(width / 2f, height / 2f);
    final PVector vectorToAttractor = PVector.sub(vector, attractorPosition);
    final float forceToAttractor = -2f;
    vector.add(vectorToAttractor.setMag(forceToAttractor));
  }

  private float getJitter() {
    return jitter * 0.5f - random(jitter);
  }
}
