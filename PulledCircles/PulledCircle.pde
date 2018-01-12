class PulledCircle {

  private static final int NUM_OF_OBJECTS_PER_FRAME = 512;

  private static final float LINE_TO_CRATER_RATIO = 0.0f;

  private PVector lastCenter;

  private float radius;

  PulledCircle(final float radius_) {
    radius = radius_;
  }

  void draw_() {

    //final PVector center = new PVector(mouseX, mouseY);
    final PVector center = new PVector(width / 2f, height / 2f);

    //float distanceToLastCenter;
    //if (lastCenter == null) {
    //  distanceToLastCenter = 0f;
    //} else {
    //  distanceToLastCenter = PVector.dist(center, lastCenter);
    //  if (distanceToLastCenter < 1f) {
    //    distanceToLastCenter = 1f;
    //  }
    //}

    //lastCenter = center;

    final float adjustedRadius = height * 0.33f; //radius / (distanceToLastCenter * 0.0001f);

    for (int i = 0; i < NUM_OF_OBJECTS_PER_FRAME; i++) {
      final float startAngle = random(TWO_PI);

      if (random(1f) > LINE_TO_CRATER_RATIO) {
        
        
        final float endAngle = random(TWO_PI);
        line(
          center.x + (cos(startAngle) * adjustedRadius), 
          center.y + (sin(startAngle) * adjustedRadius), 
          center.x + (cos(endAngle) * adjustedRadius), 
          center.y + (sin(endAngle) * adjustedRadius)
          );
      } else {
        final float craterRadius = random(adjustedRadius / 2f);
        final float distanceFromCenter = random(adjustedRadius) - (craterRadius * 0.9f);

        ellipse(
          center.x + (cos(startAngle) * distanceFromCenter), 
          center.y + (sin(startAngle) * distanceFromCenter), 
          craterRadius, 
          craterRadius
          );
      }
    }
  }
}