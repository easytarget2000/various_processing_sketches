class Alga {

  private static final float HUE_FRAME_STEP = 0.01f;

  private PVector center;

  private PVector velocity;

  private final long randomSeed;

  private float hue;

  private final int numOfZRotations;

  private final float shapeUpperBound;

  Alga(
    final PVector center_, 
    final PVector velocity_, 
    final float shapeUpperBound_, 
    final long randomSeed_, 
    final float hue_, 
    final int numOfZRotations_
    ) {
    center          = center_;
    velocity        = velocity_;
    shapeUpperBound = shapeUpperBound_;
    randomSeed      = randomSeed_;
    hue             = hue_;
    numOfZRotations = numOfZRotations_;
  }

  void drawAndUpdate() {
    center = PVector.add(center, velocity);
    randomSeed(randomSeed);

    pushMatrix();
    //translate(center.x, center.y, center.z);

    final float anglePerRotation = TWO_PI / numOfZRotations;

    for (int i = 0; i < POINTS_PER_ROTATION; i++) {
      drawPoints(anglePerRotation);
    }

    changeHue();

    popMatrix();
  }

  private void drawPoints(
    final float anglePerRotation
    ) {

    final float shapeLowerBound = -shapeUpperBound;
    final float xNoiseInput1 = random(-1f, 1f);
    final float yNoiseInput1 = random(-1f, 1f);
    final float shape1X = map(
      noise(xNoiseInput1, yNoiseInput1), 
      0f, 1f, shapeLowerBound, shapeUpperBound
      );
    final float shape1Y = map(
      noise(yNoiseInput1, xNoiseInput1), 
      0f, 1f, 
      shapeLowerBound, shapeUpperBound
      );

    final float xNoiseInput2 = random(9f, 10f);
    final float yNoiseInput2 = random(9f, 10f);
    final float shape2X = map(
      noise(xNoiseInput2, yNoiseInput2), 
      0f, 1f, 
      shapeLowerBound, shapeUpperBound
      );
    final float shape2Y = map(
      noise(yNoiseInput2, xNoiseInput2), 
      0f, 1f, 
      shapeLowerBound, shapeUpperBound
      );

    final float xNoiseInput3 = random(18f, 20f);
    final float yNoiseInput3 = random(18f, 20f);
    final float shape3X = map(
      noise(xNoiseInput3, yNoiseInput3), 
      0f, 1f, 
      shapeLowerBound, shapeUpperBound
      );
    final float shape3Y = map(
      noise(yNoiseInput3, xNoiseInput3), 
      0f, 1f, 
      shapeLowerBound, shapeUpperBound
      );

    for (int rotationCounter = 1; rotationCounter <= numOfZRotations; rotationCounter++) {
      pushMatrix();
      translate(center.x, center.y, center.z);
      rotate(rotationCounter * anglePerRotation);

      stroke(getHue(0f), 1f, 1f, 0.8f);
      //stroke(255f, 255f, 255f, 32f);
      point(shape1X, shape1Y);
      //point(xx - 1, yy - 1);

      //stroke(250f, 50f, 150f, 128f);
      stroke(getHue(0.5f), 1f, 1f, 0.7f);
      point(shape3X, shape3Y);
      ////point(xx3 + 1, yy3 + 1);

      rotate(TWO_PI / numOfZRotations / 2f);
      //stroke(0f, 150f, 250f, 128f);
      stroke(getHue(0.1f), 1f, 1f, 0.7f);
      point(shape2X, shape2Y);
      ////point(xx2, yy2 + 1);

      //stroke(250, 50, 150, 128f);
      point(shape3X, shape3Y);

      //point(xx3, yy3);
      //point(xx3 + 1, yy3);

      popMatrix();
    }
  }

  private void changeHue() {
    //if ((hue += HUE_FRAME_STEP) > 1f) {
    //hue = 0f;
    //}
  }

  private float getHue(final float offset) {
    return hue;
    //final float hue = this.hue + offset;
    //if (hue > 1f) {
    //  return hue - 1f;
    //} else if (hue < 0f) {
    //  return hue + 1f;
    //} else {
    //  return hue;
    //}
  }
}
