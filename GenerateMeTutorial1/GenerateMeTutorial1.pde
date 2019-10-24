private final float SCALE = 4f; //<>// //<>//

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
final float amount = 1f;

void draw() {

  //background(250);

  translate(width/2f, height/2f);
  //rotate(PI * noise(frameCount / 10f));

  for (float x = x1; x <= x2; x += step) {
    for (float y = y1; y <= y2; y += step) {
      drawVariation(x, y);
    }
  }

  println(frameRate);
}

void drawVariation(float x, float y) {
  PVector v = new PVector(x, y);

  //v = pdj(v, amount);
  v = sech(v, amount);

  float xx = map(v.x+0.003*randomGaussian_(), x1, x2, -(width /2f) + 20, (width / 2f) -20);
  float yy = map(v.y+0.003*randomGaussian_(), y1, y2, -(height /2f) + 20, (height / 2f) -20);
  point(xx, yy);
}

private float randomGaussian_() {
  return randomGaussian();
}

PVector sinusoidal(PVector v, float amount) {
  return new PVector(amount * sin(v.x), amount * sin(v.y));
}

PVector hyperbolic(PVector v, float amount) {
  float r = v.mag() + 2.0e-10;
  float theta = atan2(v.x, v.y);
  float x = amount * sin(theta) / r;
  float y = amount * cos(theta) * r;
  return new PVector(x, y);
}

private static final float pdj_a = 0.1;
private static final float pdj_b = 1.9;
private static final float pdj_c = -0.8;
private static final float pdj_d = -1.2;

PVector pdj(PVector v, float amount) {
  return new PVector(
    amount * (sin(pdj_a * v.y) - cos(pdj_b * v.x)), 
    amount * (sin(pdj_c * v.x) - cos(pdj_d * v.y))
    );
}

PVector julia(PVector v, float amount) {
  float r = amount * sqrt(v.mag());
  float theta = 0.5 * atan2(v.x, v.y) + (int)random(2f) * PI;
  float x = r * cos(theta);
  float y = r * sin(theta);
  return new PVector(x, y);
}

float cosh(float x) { return 0.5 * (exp(x) + exp(-x));}
float sinh(float x) { return 0.5 * (exp(x) - exp(-x));}
 
PVector sech(PVector p, float weight) {
  float d = cos(2.0*p.y) + cosh(2.0*p.x);
  if (d != 0)
    d = weight * 2.0 / d;
  return new PVector(d * cos(p.y) * cosh(p.x), -d * sin(p.y) * sinh(p.x));
}
