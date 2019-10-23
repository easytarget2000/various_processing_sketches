// Based on "donut strings" by davey @beesandbombs:
// https://gist.github.com/beesandbombs/a47aca30b520ad070b32a3afcf2fdc99

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

float c01(float g) {
  return constrain(g, 0, 1);
}

void draw() {
  if (recording) {
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
        int(result[i][0]*1.0/samplesPerFrame) << 16 | 
        int(result[i][1]*1.0/samplesPerFrame) << 8 | 
        int(result[i][2]*1.0/samplesPerFrame);
    updatePixels();

    saveFrame("f###.png");
    if (frameCount==numFrames)
      exit();
  } else if (preview) {
    c = mouseY*1.0/height;
    if (mousePressed)
      println(c);
    t = (millis()/(20.0*numFrames))%1;
    draw_();
  } else {
    t = mouseX*1.0/width;
    c = mouseY*1.0/height;
    if (mousePressed)
      println(c);
    draw_();
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 4;
int numFrames = 540;        
float shutterAngle = .6;

boolean recording = false, 
  preview = true;

void setup() {
  size(750, 750, P3D);
  smooth(8);  
  pixelDensity(recording ? 1 : 2);
  result = new int[width*height][3];
  colorMode(HSB, 1);
  noFill();
}

void vert(float x_, float y_, float z_){
  depth = map(modelZ(x_, y_, z_), -r, r, 0, 1);
  stroke(hue,.8,0f+1f*depth);
  if(black)
    stroke(0);
  vertex(x_,y_,z_);
}

float x, y, z, tt;
int N = 1200;
int numStrands = 8;
float R = 150, r = 50;
float th, ph;
float hue, depth, twist;
boolean black;

void donut(){
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

void draw_() {
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
  translate(0,0,-.1);
  donut();
  pop();

  pop();
}
