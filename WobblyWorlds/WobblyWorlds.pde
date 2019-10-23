// by Etienne JACOB
// motion blur template by beesandbombs
// needs opensimplexnoise code in another tab
// --> code here : https://gist.github.com/Bleuje/fce86ef35b66c4a2b6a469b27163591e

int[][] result;
float t, c;

float ease(float p) {
  return 3*p*p - 2*p*p*p;
}

float ease(float p, float g) {
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

float mn = .5*sqrt(3), ia = atan(sqrt(.5));

void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popStyle();
  popMatrix();
}

void draw() {
  for (int i=0; i<width*height; i++)
    for (int a=0; a<3; a++)
      result[i][a] = 0;

  c = 0;
  for (int sa=0; sa<samplesPerFrame; sa++) {
    t = map(frameCount-1 + sa*shutterAngle/samplesPerFrame, 0, numFrames, 0, 1);
    draw_();
    loadPixels();
    for (int i=0; i<pixels.length; i++) {
      result[i][0] += pixels[i] >> 16 & 0xff;
      result[i][1] += pixels[i] >> 8 & 0xff;
      result[i][2] += pixels[i] & 0xff;
    }
  }

  loadPixels();
  for (int i=0; i<pixels.length; i++)
    pixels[i] = 0xff << 24 | 
      int(result[i][0]*1/samplesPerFrame) << 16 | 
      int(result[i][1]*1/samplesPerFrame) << 8 | 
      int(result[i][2]*1f/samplesPerFrame);
  updatePixels();

  //saveFrame("fr###.gif");
  //println(frameCount, "/", numFrames, frameRate);
  //if (frameCount==numFrames)
  //  exit();
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 2;
int numFrames = 120;        
float shutterAngle = 64;

boolean recording = true;

float xmin, xmax;

float ymin, ymax;

void setup() {
  //size(800, 800, P3D);
  fullScreen(P3D);
  result = new int[width*height][3];

  xmin = -1.7f * width;
  xmax = 1.7f * width;

  ymin = -8.5f * width;
  ymax = 0.8f* width;

  colorMode(HSB, 1f);
  background(0);
}

private static final int n = 64;
private static final int m = 128;
//private static final int N = 6;

//private static final float f = 0.5f;

private boolean didClearScreen = false;

void draw_() {
  if (!didClearScreen && noise(t * 1000f) > 0.5f) {
      background(0);
      didClearScreen = true;
      return;
  }
  
  didClearScreen = false;

  push();
  translate(width/2f, (height/2f) - 200f, 5f);
  rotateX(0.32f * PI);

  /*
  float cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
   perspective(PI/7.5, width/height, cameraZ/10.0, cameraZ*10.0);*/
  final float seed = 123f;
  final float rad = 0.8f;
  final float change = 1.5f;

  noStroke();
  for (int i = 0; i < n; i++) {

    final float x1 = map(i, 0, n, xmin, xmax);
    final float x2 = map(i + 1f, 0, n, xmin, xmax);

    //fill(hue);

    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < m; j++) {
      final float y = map(j, 0f, m - 1f, ymin, ymax);

      final float p = map(y, ymin, ymax, 1f, 0f);

      final float xx1 = (1f - p) * x1;
      final float xx2 = (1f - p) * x2;

      final float xxx1 = (1f - (0.2f *p)) * x1;
      final float xxx2 = (1f - (0.3f *p)) * x2;

      final float offset = 15f * pow(1 - p, 3f) / 5f;

      final float ds1 = 64f * noise(
        seed + change * offset + rad * cos(TWO_PI*(-t + offset)), 
        rad * sin(TWO_PI*(-t + offset)), 
        0.01f * xx1
        );
      final float ds2 = 64f * noise(
        seed + (change * offset) + rad * cos(TWO_PI*(-t + offset)), 
        rad * sin(TWO_PI*(-t + offset)), 
        0.01f * xx2
        );
      final float dy = 128f * noise(
        (2f * seed) + change*offset + rad * cos(TWO_PI*(-t + offset)), 
        rad * sin(TWO_PI*(-t + offset)), 
        0.01f * xx2
        );

      final float depth1 = 2f * depth(xx1, y + dy) + dy;
      final float depth2 = 2f * depth(xx2, y + dy) + dy;

      final float ff = constrain(
        map(
        modelZ((xxx1 + ds1 + xxx2 + ds2) / 2f, y, (depth1 + depth2) / 2f), 
        -3000f, 500f, 
        0f, 1f
        ), 0f, 1f
        );

      fill(t, 0.9f, ff, 1f);

      vertex(xxx1 + ds1, y, depth1);
      vertex(xxx2 + ds2, y, depth2);
    }
    endShape();
  }

  pop();
}

private float depth(float x, float y) {
  final float p = map(y, ymin, ymax, 1f, 0f);
  final float q = map(x, xmin, xmax, 0f, 1f);
  return -400f + 350f * (1f - sin(PI * p)) + 650f * pow(((cos(TWO_PI * q) + 1f) / 2f), 1.7f);
}
