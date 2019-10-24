
private static final int MIN_NUMBER_OF_LINES = 1;
private static final int MAX_NUMBER_OF_LINES = 8;
private int numFrames = 128;
private int parts = 4;
private float t = 0f;
private float offset_factor = 2.0;
private int m = 2048;
private float motion_rad = 2f;
private float size = 0.4f;
private int numberOfLines = MAX_NUMBER_OF_LINES / 3;

void setup() {
  fullScreen(P3D);
  background(20f, 200f, 200f);

  strokeWeight(2);
}

void draw() {
  fill(240f, 220f, 120f, 10f);
  noStroke();
  rect(0f, 0f, width, height);

  t = (frameCount - 1f) / (float) numFrames;

  if (noise(frameCount) > 0.8f) {
    numberOfLines = (int) (random(1f) * (MAX_NUMBER_OF_LINES + (MAX_NUMBER_OF_LINES - MIN_NUMBER_OF_LINES)));
  }

  if (noise(frameCount * frameRate) > 0.8f) {
    background(220f, 200f, 100f);
    return;
  }

  stroke(10f, 100f);

  push();
  translate(width / 2f, height / 2f);

  for (int i = 0; i < numberOfLines; i++) {
    push();
    rotate(i*TWO_PI/numberOfLines);
    drawThing(i);
    pop();
  }

  pop();
}

float x1(float ph) {
  return 0.0*width+size*width*(float)noise_(75+motion_rad*cos(TWO_PI*(t+ph)), motion_rad*sin(TWO_PI*(t+ph)));
}

float y1(float ph) {
  return size*width*(float)noise_(100+motion_rad*cos(TWO_PI*(t+ph)), motion_rad*sin(TWO_PI*(t+ph)));
}

float x2(float ph) {
  return 0.3*width+0.5*size*width*(float)noise_(200+motion_rad*cos(TWO_PI*(t+ph)), motion_rad*sin(TWO_PI*(t+ph)));
}

float y2(float ph) {
  return 0.5*size*width*(float)noise_(300+motion_rad*cos(TWO_PI*(t+ph)), motion_rad*sin(TWO_PI*(t+ph)));
}


void drawThing(int j) {
  float ph2 = -parts*1.0*j/numberOfLines;

  //float xx1 = x1(ph2);
  //float yy1 = y1(ph2);
  //float xx2 = x2(ph2);
  //float yy2 = y2(ph2);

  //stroke(255);
  //fill(255);
  //ellipse(xx1, yy1, 3, 3);
  //ellipse(xx2, yy2, 3, 3);

  for (int i=0; i<=m; i++) {
    float tt = 1.0*i/m;

    float xx = lerp(x1(-offset_factor*tt+ph2), x2(-offset_factor*(1-tt)+ph2), tt);
    float yy = lerp(y1(-offset_factor*tt+ph2), y2(-offset_factor*(1-tt)+ph2), tt);

    point(xx, yy);
  }
}

private float noise_(final float x, final float y) {
  return 1f - (noise(x, y) * 2f);
}
