private int numOfBoxes = 4;

private float t;

//private float c;

private float beatMultiplier = 4f;

private boolean clearFrame = true;

private boolean rotateCubes = true;

private float bpm = 128f;

private int beatLengthMillis = (int) (60 / bpm * 1000f);

private float cameraAngle = 0;// atan(sqrt(1.5));


void draw() {

  clearFrame = random(1f) > 0.9f; 
  if (clearFrame) {
    background(0);
  }

  //t = mouseX*1.0/width;

  updateMode();
  updateCameraAngle();

  t = millis() / (beatMultiplier * beatLengthMillis);

  drawCubes();
}

void setup() {
  //size(1080, 1080, P3D);
  //size(1280, 720, P3D);
  //size(1920, 1080, P3D);
  fullScreen(P3D);

  smooth(8);
  rectMode(CENTER);
  colorMode(HSB, 1);
  noFill();
  strokeWeight(1.5f);
}

void keyPressed() {
  switch (key) {
  case 'z':
    setCalmMode();
    break;

  case 'x':
    setMediumMode();
    break;

  case 'c':
    setFidgetMode();
    break;

  case 'v':
    setRandomCameraAngle();
    break;
  }
}

/*
Implementations
 */

void drawCubes() {

  push();
  translate(width/ 2, height / 2);
  rotateX(cameraAngle);
  rotateY(QUARTER_PI * t);
  for (int i=0; i < numOfBoxes; i++) {

    if (random(1f) > 0.01f) {
      final float alpha = clearFrame ? 0.2f : 0.1f;
      final float hue = (i / float(numOfBoxes) + t) % 2;
      if (random(1f) > 0.001f) {
        stroke(hue, 1, 1, alpha);
      } else {
        fill(hue, 1, 1, alpha);
      }
    } else {
      stroke(0xFFFFFFFF);
    }
    push();

    if (rotateCubes) {
      rotateY(QUARTER_PI*sin((TWO_PI * t) - (0.1f * PI) * i / numOfBoxes));
      rotateCubes = random(1f) > 0.66f;
    } else {
      rotateCubes = random(1f) > 0.95f;
    }

    box(128 + 32 * i);
    //sphere(128f + 16f * i);
    //final float radius = 256f + 32f * i;
    //ellipse(0f, 0f, radius, radius);
    pop();
  }
  pop();
}

private float ease(float p, float g) {
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

private void updateMode() {
  if (random(1f) > 0.99f) {
    if (random(1f) > 0.5f) {
      beatMultiplier /= 2f;
    } else {
      beatMultiplier *= 2f;
    }

    if (beatMultiplier > 16f || beatMultiplier < 2f) {
      beatMultiplier = 4f;
    }

    if (random(1f) > 0.5f) {
      numOfBoxes /= 2;
    } else {
      numOfBoxes *= 2;
    }

    if (numOfBoxes > 32 || numOfBoxes < 2) {
      numOfBoxes = 16;
    }
  }
}

private void setCalmMode() {
  beatMultiplier = 8f;
  numOfBoxes = 2;
} 

private void setMediumMode() {
  beatMultiplier = 3f;
  numOfBoxes = 10;
}

private void setFidgetMode() {
  beatMultiplier = 2f;
  numOfBoxes = 32;
}

private void updateCameraAngle() {
  if (random(1f) > 0.5f) {
    setRandomCameraAngle();
  }
  translate(width/ 2, height / 2);
  rotateX(cameraAngle);
}

private void setRandomCameraAngle() {
  if (random(1f) > 0.8f) {
    cameraAngle = 0f;
  } else {
    cameraAngle = random(TWO_PI);
  }
}
