private final float SCALE = 4f; //<>//

void setup() {
  size(600, 600);
  background(250);
  smooth(8);
  noFill();
  stroke(0f, 11f);
  strokeWeight(0.9f * SCALE);

  x1=y1=-3f;
  x2=y2=3f;
  y=y1;
  step=(x2-x1)/(width) * SCALE;
}

float x1, y1, x2, y2; // function domain
float step; // step within domain
float y;
final float amount = 3f;

void draw() {

  //background(250);

  translate(width/2f, height/2f);
  rotate(PI * noise(frameCount / 10f));

  for (float x = x1; x <= x2; x += step) {
    for (float y = y1; y <= y2; y += step) {
      drawVariation(x, y);
    }
  }

  //translate(-width/2f, -height/2f);

  //pop();
  println(frameRate);
}

void drawVariation(float x, float y) {
  PVector v = new PVector(x, y);

  v = sinusoidal(v, amount);

  float xx = map(v.x+0.003*randomGaussian_(), x1, x2, -(width /2f) + 20, (width / 2f) -20);
  float yy = map(v.y+0.003*randomGaussian_(), y1, y2, -(height /2f) + 20, (height / 2f) -20);
  point(xx, yy);
}

private float randomGaussian_() {
  return 0f;
}

PVector sinusoidal(PVector v, float amount) {
  return new PVector(amount * sin(v.x), amount * sin(v.y));
}
