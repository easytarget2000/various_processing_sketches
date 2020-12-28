// Based on "donut strings" by davey @beesandbombs: //<>// //<>// //<>// //<>//
// https://gist.github.com/beesandbombs/a47aca30b520ad070b32a3afcf2fdc99

private static final boolean RECORDING = false;
private static final boolean BLACK = false;

private Projector projector;
private int numStrands = 16;
private int numOfLinesPerStrand = 1200;

/*
* PApplet Lifecycle
 */

void setup() {
  //size(750, 750, P3D);
  fullScreen(P3D);
  frameRate(60f);

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

  background(0xFF69D2E7);
}

void draw() {
  projector.perform();
}

/*
* Implementations
 */

//private float x, y, z, tt;

//private float th, ph;
//private float hue, depth, twist;

private void draw_(final float t) {
  
  //background(0f);

  push();
  translate(width / 2f, height / 2f);

  strokeWeight(2f);
  donut(t);

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

private void donut(final float t) {
  final float thickness = min(width, height) / 6f;
  final float innerRadius = (min(width, height) * 0.45f) - thickness;
  final float twist = TWO_PI*cos(TWO_PI*t);

  for (int strandIndex = 0; strandIndex < numStrands; strandIndex++) {
    final float hue = strandIndex * 1f / numStrands;

    beginShape();
    for (int lineIndex = 0; lineIndex < numOfLinesPerStrand; lineIndex++) {
      final float th = TWO_PI * lineIndex / numOfLinesPerStrand;
      final float ph = TWO_PI * strandIndex / numStrands + (twist * sin(th));
      final float x = (innerRadius+thickness * cos(ph))*cos(th);
      final float y = (innerRadius+thickness * cos(ph))*sin(th);
      final float z = thickness*sin(ph);
      vert(x, y, z, thickness, hue);
    }
    endShape(CLOSE);
  }
}

private void vert(float x_, float y_, float z_, final float r, final float hue) {
  final float depth = map(modelZ(x_, y_, z_), -r, r, 0, 1);
  stroke(hue, 0.33f, depth);
  vertex(x_, y_, z_);
}
