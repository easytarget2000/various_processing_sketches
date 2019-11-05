/* Based on
 * https://www.openprocessing.org/sketch/402629
 */

private int numOfVertices = 1024;

private float M = 50f;

private float h = 0.99f;

private float hh = 0.01f;

private float xVertexCoordinates[] = new float[numOfVertices+1];

private float yVertexCoordinates[] = new float[numOfVertices+1];

private float zVertexCoordinates[] = new float[numOfVertices+1];

private float v[] = new float[numOfVertices+1];

private float dv[] = new float[numOfVertices+1];

private final float R = 2*sqrt((4*PI*(200*200)/numOfVertices)/(2*sqrt(3)));

private float kx;

private float ky;

private float kz;

private float kv;

private float kdv;

private int k;

void setup() {

  //size(600, 600);
  fullScreen();
  
  background(0, 0, 0);
  noSmooth();
  stroke(255, 255, 255);
  fill(50, 50, 50);

  initVertices();
}

void draw() {

  background(0, 0, 0);
  drawSphere();
}

void mousePressed() {

  float lmin = 600f; 
  int nn = 0;
  for (int n = 0; n <= numOfVertices; n++ ) {
    final float l = sqrt(((mouseX - (300 + xVertexCoordinates[n])) * (mouseX-(300 + xVertexCoordinates[n])))+((mouseY-(300 + yVertexCoordinates[n]))*(mouseY-(300 + yVertexCoordinates[n]))));
    if (zVertexCoordinates[n] > 0 && l < lmin) { 
      nn = n; 
      lmin = l;
    } 
  }

  if (k == 0) { 
    dv[nn] = -200f; 
    k = 1;
  } else { 
    dv[nn] = 200f; 
    k = 0;
  }
}

/*
Implementation
 */

private void initVertices() {
  for (int vertexIndex = 0; vertexIndex <= numOfVertices; vertexIndex++) {
    xVertexCoordinates[vertexIndex] = random(-300f, 300f);
    yVertexCoordinates[vertexIndex] = random(-300f, 300f);
    zVertexCoordinates[vertexIndex] = random(-300f, 300f);
  }
}

private void drawSphere() {
  float l;

  for (int n = 0; n <= numOfVertices; n++ ) {
    for (int nn = n + 1; nn <= numOfVertices; nn++ ) {
      l = sqrt(((xVertexCoordinates[n]-xVertexCoordinates[nn])*(xVertexCoordinates[n]-xVertexCoordinates[nn]))+((yVertexCoordinates[n]-yVertexCoordinates[nn])*(yVertexCoordinates[n]-yVertexCoordinates[nn])));
      l = sqrt(((zVertexCoordinates[n]-zVertexCoordinates[nn])*(zVertexCoordinates[n]-zVertexCoordinates[nn]))+(l*l));
      if ( l < R ) {
        xVertexCoordinates[n] = xVertexCoordinates[n] - ((xVertexCoordinates[nn]-xVertexCoordinates[n])*((R-l)/(2*l)));
        yVertexCoordinates[n] = yVertexCoordinates[n] - ((yVertexCoordinates[nn]-yVertexCoordinates[n])*((R-l)/(2*l)));
        zVertexCoordinates[n] = zVertexCoordinates[n] - ((zVertexCoordinates[nn]-zVertexCoordinates[n])*((R-l)/(2*l)));
        xVertexCoordinates[nn] = xVertexCoordinates[nn] + ((xVertexCoordinates[nn]-xVertexCoordinates[n])*((R-l)/(2*l)));
        yVertexCoordinates[nn] = yVertexCoordinates[nn] + ((yVertexCoordinates[nn]-yVertexCoordinates[n])*((R-l)/(2*l)));
        zVertexCoordinates[nn] = zVertexCoordinates[nn] + ((zVertexCoordinates[nn]-zVertexCoordinates[n])*((R-l)/(2*l)));
        dv[n] = dv[n] + ((v[nn]-v[n])/M);
        dv[nn] = dv[nn] - ((v[nn]-v[n])/M);
        stroke(125+(zVertexCoordinates[n]/2), 125+(zVertexCoordinates[n]/2), 125+(zVertexCoordinates[n]/2)); 
        line(xVertexCoordinates[n]*1.2*(200+v[n])/200+300, yVertexCoordinates[n]*1.2*(200+v[n])/200+300, xVertexCoordinates[nn]*1.2*(200+v[nn])/200+300, yVertexCoordinates[nn]*1.2*(200+v[nn])/200+300);
      }

      if (zVertexCoordinates[n] > zVertexCoordinates[nn]) {
        kx = xVertexCoordinates[n]; 
        ky = yVertexCoordinates[n]; 
        kz = zVertexCoordinates[n]; 
        kv = v[n]; 
        kdv = dv[n]; 
        xVertexCoordinates[n] = xVertexCoordinates[nn]; 
        yVertexCoordinates[n] = yVertexCoordinates[nn]; 
        zVertexCoordinates[n] = zVertexCoordinates[nn]; 
        v[n] = v[nn]; 
        dv[n] = dv[nn];  
        xVertexCoordinates[nn] = kx; 
        yVertexCoordinates[nn] = ky; 
        zVertexCoordinates[nn] = kz; 
        v[nn] = kv; 
        dv[nn] = kdv;
      }
    }
    
    l = sqrt((xVertexCoordinates[n] * xVertexCoordinates[n]) + (yVertexCoordinates[n] * yVertexCoordinates[n]));
    l = sqrt((zVertexCoordinates[n] * zVertexCoordinates[n]) + (l * l));
    xVertexCoordinates[n] = xVertexCoordinates[n] + (xVertexCoordinates[n] * (200f - l)/(2f * l));
    yVertexCoordinates[n] = yVertexCoordinates[n] + (yVertexCoordinates[n] * (200f - l)/(2f * l));
    zVertexCoordinates[n] = zVertexCoordinates[n] + (zVertexCoordinates[n] * (200f - l)/(2f * l));
    kz = zVertexCoordinates[n];
    kx = xVertexCoordinates[n];
    zVertexCoordinates[n] = (kz * cos(float(300 - mouseX) / 10000))-(kx * sin(float(300 - mouseX) / 10000));
    xVertexCoordinates[n] = (kz * sin(float(300 - mouseX) / 10000))+(kx * cos(float(300 - mouseX) / 10000));
    kz = zVertexCoordinates[n]; 
    ky = yVertexCoordinates[n];
    zVertexCoordinates[n] = (kz*cos(float(300 - mouseY) / 10000))-(ky*sin(float(300 - mouseY) / 10000));
    yVertexCoordinates[n] = (kz*sin(float(300 - mouseY) / 10000))+(ky*cos(float(300 - mouseY) / 10000));
    dv[n] = dv[n] - (v[n]*hh); 
    v[n] = v[n] + dv[n]; 
    dv[n] = dv[n] * h;
  }
}
