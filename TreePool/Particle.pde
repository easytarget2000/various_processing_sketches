public class Particle {

  private static final float PUSH_FORCE = 64f;

  private static final int LEFT_COLOR_RED = 0xD6;

  private static final int LEFT_COLOR_GREEN = 0x69;

  private static final int LEFT_COLOR_BLUE = 0x27;

  private static final int RIGHT_COLOR_RED = 0xFF;

  private static final int RIGHT_COLOR_GREEN = 0x00;

  private static final int RIGHT_COLOR_BLUE = 0xFF;

  private static final int MAX_AGE = 128;

  private int age;

  private float x;

  private float y;

  public Particle(final float x, final float y) {
    this.age = 0;
    this.x = x;
    this.y = y;
  }

  public boolean updateAndDraw(final Particle[] allParticles, boolean snapToClosest) {

    Particle closestParticle = allParticles[0];
    float distanceToClosestParticle = MAX_FLOAT;

    float force = 0f;
    float angle = 0f;

    for (final Particle otherParticle : allParticles) {
      if (otherParticle == this) {
        continue;
      }

      final float distanceToOtherParticle = distance(otherParticle);
      if (snapToClosest && distanceToOtherParticle > distanceToClosestParticle) {
        closestParticle = otherParticle;
        distanceToClosestParticle = distanceToOtherParticle;
      } else if (distanceToOtherParticle < distanceToClosestParticle) {
        closestParticle = otherParticle;
        distanceToClosestParticle = distanceToOtherParticle;
      }

      if (distanceToOtherParticle > 64f) {
        continue;
      }

      angle = angle(otherParticle) + (angle * 0.05f);

      force *= 0.05;

      if (distanceToOtherParticle < 2f) {
        force -= 2f;
      } else {
        force -= (PUSH_FORCE / distanceToOtherParticle);
      }

      if (force < 64) {
        x += cos(angle) * force;
        y += sin(angle) * force;
      }
    }

    stroke(getColor());
    line(x, y, closestParticle.x, closestParticle.y);

    //return x > 0 && x < width && y > 0 && y < height; 
    return age++ < MAX_AGE;
  }

  private float distance(final Particle otherParticle) {
    return distance(x, y, otherParticle.x, otherParticle.y);
  }

  private float angle(final Particle otherParticle) {
    return angle(x, y, otherParticle.x, otherParticle.y);
  }

  private color getColor() {
    final float ratio = x / width;

    return color(
      (int) Math.abs((ratio * RIGHT_COLOR_RED) + ((1 - ratio) * LEFT_COLOR_RED)), 
      (int) Math.abs((ratio * RIGHT_COLOR_GREEN) + ((1 - ratio) * LEFT_COLOR_GREEN)), 
      (int) Math.abs((ratio * RIGHT_COLOR_BLUE) + ((1 - ratio) * LEFT_COLOR_BLUE)), 
      0xFF
      );
  }

  protected float angle(
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

  protected float distance(
    final float x1, 
    final float y1, 
    final float x2, 
    final float y2
    ) {
    return sqrt(
      pow((x2 - x1), 2) + pow((y2 - y1), 2)
      );
  }
}