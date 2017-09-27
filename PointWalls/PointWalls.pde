/**
 * Constants
 */

private static final float MAX_ANGULAR_VELOCITY = 0.2f;

/**
 * Values
 */

private Conductor conductor = new Conductor(108f);

private float[] startAngles;

private float[] angularDistances;

private float[] angularVelocities;

private float diameter;

private float yRotationSpeed = 0.1f;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080);
  fullScreen(P3D);
  // fullScreen(2);
  background(0);

  initShapes();
  initPaint();
}

void draw() {

  if (conductor.isBeatDue(4) && random(1f) > 0.1f) {
    background(0);
    yRotationSpeed *= -1f;
  }

  final float xTranslation = width / 2f;
  //final float yTranslation = height / 2f;

  translate(xTranslation, 0f);

  if (conductor.isBeatDue(2) && random(1f) > 0.2f) {
    rotateY(0f);
  } else {
    rotateY(frameCount * yRotationSpeed);
  }

  translate(-xTranslation, 0f);

  for (int i = 0; i < 3; i++) {

    //switch(i) {
    //case 0:
    //  //fill(0x55FF0000);
    //  break;
    //case 1:
    //  //fill(0x5500FF00);
    //  break;
    //case 2:
    //  //fill(0x550000FF);
    //  break;
    //}

    for (float x = xTranslation - diameter / 2f; x < (width * 1.2f); x += diameter * 1.1f) {
      for (float y = diameter / 2f; y < (height * 1.2f); y += diameter * 1.1f) {
        //arc(
        //  x, 
        //  y, 
        //  diameter, 
        //  diameter, 
        //  startAngles[i], 
        //  startAngles[i] + angularDistances[i]
        //  );
          
          point(x, y);
      }
    }
  }

  if (conductor.isBeatDue(4) && random(1f) > 0.3f) {
    initShapes();
  } else {
    updateAngles();
  }

  if (conductor.isBeatDue(1) && random(1f) > 0.3f) {
    initPaint();
  }
}

private void initShapes() {
  startAngles = new float[] {
    random(TWO_PI), 
    random(TWO_PI), 
    random(TWO_PI)
  };

  angularDistances = new float[] {
    TWO_PI / 3f, 
    TWO_PI / 3f, 
    TWO_PI / 3f
  };

  angularVelocities = new float[] {
    (MAX_ANGULAR_VELOCITY / 2f) - random(MAX_ANGULAR_VELOCITY), 
    (MAX_ANGULAR_VELOCITY / 2f) - random(MAX_ANGULAR_VELOCITY), 
    (MAX_ANGULAR_VELOCITY / 2f) - random(MAX_ANGULAR_VELOCITY)
  };

  diameter = width / (16f + random(256f));
}

private void initPaint() {
      stroke(getRandomColorWithAlpha(0xFF));

  //if (random(1f) > 0.5f) {
  //  stroke(getRandomColorWithAlpha(0x33));
  //  noFill();
  //} else {
  //  fill(getRandomColorWithAlpha(0x33));
  //  noStroke();
  //}
}

private void updateAngles() {
  for (int i = 0; i < 3; i++) {
    startAngles[i] += angularVelocities[i];
  }
}

private color getRandomColorWithAlpha(final int alpha) {
  return color(
    (int) random(100) + 155, 
    (int) random(100) + 155, 
    (int) random(100) + 155, 
    alpha
    );
}