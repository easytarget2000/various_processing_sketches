// Based on "donut strings" by davey @beesandbombs: //<>// //<>// //<>// //<>//
// https://gist.github.com/beesandbombs/a47aca30b520ad070b32a3afcf2fdc99

private static final boolean RECORDING = false;

private Projector projector;
private float x, y, z, tt;
private int N = 1200;
private int numStrands = 8;
private float R = 150, r = 50;
private float th, ph;
private float hue, depth, twist;
private boolean black;

/*
* PApplet Lifecycle
*/

void setup() {
  size(750, 750, P3D);

  smooth(8);  
  colorMode(HSB, 1f);
  noFill();
  //pixelDensity(RECORDING ? 1 : 2);

  final ProjectorListener projectorListener = new ProjectorListener() {
    public void drawSample(final float t) {
      draw_(t);
    }
  };
  projector = new Projector(width, height, projectorListener);
  projector.recording = RECORDING;
}

void draw() {
  projector.perform();
}

/*
* Implementations
*/

private void draw_(final float t) {
  twist = TWO_PI*cos(TWO_PI*t);

  background(0);
  push();
  translate(width/2, height/2);

  strokeWeight(16f);
  black = false;
  donut();

  strokeWeight(10);
  black = true;
  push();
  translate(0, 0, -.1);
  donut();
  pop();

  pop();
}

//private void push_() {
//  pushMatrix();
//  pushStyle();
//}

//private void pop_() {
//  popStyle();
//  popMatrix();
//}

void vert(float x_, float y_, float z_) {
  depth = map(modelZ(x_, y_, z_), -r, r, 0, 1);
  stroke(hue, .8, 0f+1f*depth);
  if (black)
    stroke(0);
  vertex(x_, y_, z_);
}

void donut() {
  for (int a=0; a<numStrands; a++) {
    hue = a*1.0/numStrands;

    beginShape();
    for (int i=0; i<N; i++) {
      th = TWO_PI*i/N;
      ph = TWO_PI*a/numStrands + twist*sin(th);
      x = (R+r*cos(ph))*cos(th);
      y = (R+r*cos(ph))*sin(th);
      z = r*sin(ph);
      vert(x, y, z);
    }
    endShape(CLOSE);
  }
}
