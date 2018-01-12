class VeinLayer { //<>//
  
  private static final int MAX_VEINS_AGE = 64;

  private Vein[] veins = new Vein[128];
  
  private PVector center;
  
  private float growthVelocity;
  
  private int veinsAge;

  VeinLayer(final PVector center_, final float growthVelocity_) {
    center = center_;
    growthVelocity = growthVelocity_;
    initVeins();
  }

  private void initVeins() {
    veinsAge = 0;
    
    for (int i = 0; i < veins.length; i++) {
      final float angle = (i / (float) veins.length) * TWO_PI;
      veins[i] = new Vein(center, angle, growthVelocity);
    }
  }

  void updateAndDrawVeins() {
    for (final Vein vein : veins) {
      vein.updateAndDraw();
    }
    
    if (++veinsAge > MAX_VEINS_AGE) {
      initVeins();
    }
  }

  private class Vein {

    private ArrayList<PVector> points;

    private float angle;

    private float growthVelocity;

    //private float maxJitter;

    //private float maxJitterHalf;

    private static final float MAX_ANGLE_JITTER = 0.5f;

    private static final float MAX_ANGLE_JITTER_HALF = MAX_ANGLE_JITTER / 2f;

    private Vein(
      final PVector center, 
      final float angle_, 
      final float growthVelocity_
      ) {
      points = new ArrayList<PVector>();
      points.add(center);
      addNextPoint(center);

      angle = angle_;
      growthVelocity = growthVelocity_;

      //maxJitter = growthVelocity * 0.66f;
      //maxJitterHalf = maxJitter / 2f;

      //println("New Vein: " + this);
    }

    String toString() {
      return "[Vein: "
        + super.toString()
        + ": angle: " + angle
        + ", secondPoint: " + points.get(1).x + ", " + points.get(1).y
        + "]";
    }

    private void updateAndDraw() {
      PVector lastPoint = null;
      for (final PVector point : points) {
        if (lastPoint == null) {
          lastPoint = point;
          continue;
        }

        line(lastPoint.x, lastPoint.y, point.x, point.y);

        lastPoint = point;
      }

      addNextPoint(lastPoint);
    }

    private void addNextPoint(final PVector lastPoint) {
      final float jitteredAngle = angle + getAngleJitter();
      final float nextX = lastPoint.x + (cos(jitteredAngle) * growthVelocity);
      final float nextY = lastPoint.y + (sin(jitteredAngle) * growthVelocity);
      points.add(new PVector(nextX, nextY));
    }

    //private float getJitter() {
    //  return maxJitterHalf + random(maxJitter);
    //}

    private float getAngleJitter() {
      return MAX_ANGLE_JITTER_HALF + random(MAX_ANGLE_JITTER);
    }
  }
}