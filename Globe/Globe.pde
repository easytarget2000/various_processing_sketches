/**
 * Constants
 */

/**
 * Values
 */

private float centerX;

private float centerY;

private float radius;

private float xRotationSpeed = 0.1f;

private float yRotationSpeed = 0.1f;

private Conductor conductor = new Conductor(120f);

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080, P3D);
  fullScreen(P3D);
  //size(1280, 720, P3D);
  frameRate(60f);

  // fullScreen(2);
  background(0);

  setRandomGlobeValues();
  setRandomRotationSpeeds();

  noFill();
  stroke(0x88FF00FF);
}

void draw() {

  if (conductor.isBeatDue(2) && random(1f) > 0.8f) {
    background(0);
  }

  if (conductor.isBeatDue(3) && random(1f) > 0.8f) {
    setRandomRotationSpeeds();
  }

  if (conductor.isBeatDue(1) && random(1f) > 0.7f) {
    setRandomColor();
  }

  for (int i = 0; i < (int) random(64f); i++) {
    translate(centerX, 0f);
    //rotateY(frameCount * (0.1f + random(0.01f)));
    rotateY(frameCount * yRotationSpeed);
    translate(-centerX, 0f);

    ellipse(centerX, centerY, radius, radius);

    translate(0f, centerY);
    //rotateX(frameCount * (0.1f + random(0.01f)));
    rotateX(frameCount * xRotationSpeed);
    translate(0F, -centerY);

    ellipse(centerX, centerY, radius, radius);
  }
}

private void setRandomGlobeValues() {
  centerX = width / 2f;
  centerY = height / 2f;
  radius = height * 0.67f;
}

private void setRandomRotationSpeeds() {
  xRotationSpeed = 0.001f + random(0.1f);
  if (random(1f) > 0.5f) {
    yRotationSpeed = xRotationSpeed;
  } else {
    yRotationSpeed = 0.001f + random(0.1f);
  }
}

private void setRandomColor() {
  if (random(1f) > 0.9f) {
    fill(getRandomColorWithAlpha(0x10));
    noStroke();
  } else {
    noFill();
    stroke(getRandomColorWithAlpha(0x80));
  }
}

private color getRandomColorWithAlpha(final int alpha) {
  if (random(1f) > 0.5f) {
    return color(
      (int) random(100) + 155, 
      (int) random(100) + 155, 
      (int) random(100) + 155, 
      alpha
      );
  } else {
    if (random(1f) > 0.5f) {
      return color(0xFF, 0xFF, 0xFF, alpha);
    } else {
      return color(0x00, 0x00, 0x00, alpha);
    }
  }
}
