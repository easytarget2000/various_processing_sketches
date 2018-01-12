
private float t;

private float c;

private float beatMultiplier = 4f;

//private float ease(final float p) {
//  return (3 * p * p) - (2 * p * p * p);
//}

float ease(float p, float g) {
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

private final float ia = atan(sqrt(1.5));

void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popStyle();
  popMatrix();
}

void draw() {

  //t = mouseX*1.0/width;

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

  t = millis() / (beatMultiplier * 500f);

  if (mousePressed)
    println(c);
  draw_();
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
  strokeWeight(1.5);
}

float x, y, z, tt;
private int numOfBoxes = 16;

void draw_() {

  final boolean clear = random(1f) > 0.7f; 
  if (clear) {
    background(0);
  }

  push();
  translate(width/ 2, height / 2);
  rotateX(-ia);
  rotateY(QUARTER_PI * t);
  for (int i=0; i < numOfBoxes; i++) {

    if (random(1f) > 0.01f) {
      final float alpha = clear ? 0.5f : 0.1f;
      stroke((i / float(numOfBoxes) + t) % 2, 1, 1, alpha);
    } else {
      stroke(0xFFFFFFFF);
    }
    push();
    rotateY(QUARTER_PI*sin(TWO_PI*t - .75*PI*i/numOfBoxes));
    box(128 + 32 * i);
    //final float radius = 256f + 32f * i;
    //ellipse(0f, 0f, radius, radius);
    pop();
  }
  pop();
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