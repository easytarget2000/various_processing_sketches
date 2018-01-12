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

  if (!recording) {
    t = mouseX*1.0/width;
    c = mouseY*1.0/height;
    if (mousePressed)
      println(c);
    draw_();
  } else {
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

    saveFrame("fr###.png");
    if (frameCount==numFrames)
      exit();
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 5;
int numFrames = 15;        
float shutterAngle = .6;

boolean recording = true;

class Center{
  float bb = 2;
  float x = random(bb*border,width-bb*border);
  float y = random(bb*border,height-bb*border);
  
  float rot = random(0,0);
  float repulse = random(1,5);
  
  Center(float x_,float y_,float r){
    x = x_;
    y = y_;
    repulse = r;
  }
  
  void show(){
    stroke(255,0,0);
    strokeWeight(3);
    point(x,y);
  }
}

float DT = 0.3;

class Path{
  float x = random(-width,2*width);
  float y = lerp(1.3*height,-height,pow(random(1),5));
  
  ArrayList<PVector> positions = new ArrayList<PVector>();
  
  float red = (random(2)<1? 100 : 255);
  float green = 255;
  float blue = 255;
  
  float sz = random(1,2);
  
  int npart = 3;
  
  float t_off = random(1);
  
  Path(){
    positions.add(new PVector(x,y));
  }
  
  void update(){
    PVector res = field(x,y);
    x += DT*res.x;
    y += DT*res.y;
    positions.add(new PVector(x,y));
  }
  
  void show(){
    stroke(red,green,blue,100);
    //stroke(255,100);
    stroke(255,100);
    strokeWeight(sz);
    noFill();
    beginShape();
    for(int i = 0;i<positions.size();i++){
      vertex(positions.get(i).x,positions.get(i).y);
    }
    endShape();
  }
  void show2(){
    
    strokeWeight(sz);
    float tt = (t+t_off)%1;
    int len = positions.size();
    for(int i=0;i<npart;i++){
      float loc = constrain(map(i+tt,0,npart,0,len-1-0.01),0,len-1-0.001);;
      int i1 = floor(loc);
      int i2 = i1+1;
      float interp = loc - floor(loc);
      float xx = lerp(positions.get(i1).x,positions.get(i2).x,interp);
      float yy = lerp(positions.get(i1).y,positions.get(i2).y,interp);
      
      float fact = 1;
      //fact = constrain(map(y,0,height/3,0,1),0,1);
      //if(xx<border||xx>width-border||yy<border||yy>height-border) fact = 0;
      
      float alpha = fact*255*pow(sin(PI*loc/(len-1)),0.25);
      
      stroke(255,alpha);
      //stroke(red,green,blue,alpha);
      
      point(xx,yy);
    }
  }
}

int border = 50;

int N = 1;

int NPart = 100000;

Center[] array = new Center[N];

Path[] array2 = new Path[NPart];




PVector field(float x,float y){
  
  float amount = 20;
  float amount2 = 15;
  float scl = 0.05;
  
  float sumx = 0;
  float sumy = 0;
  for(int i = 0;i<N;i++){
    float distance = dist(x,y,array[i].x,array[i].y);
    float intensity = constrain(map(distance,0,width,1,0),0,1);
    intensity = pow(intensity,25);
    float nx = (x - array[i].x)/distance;
    float ny = (y - array[i].y)/distance;
    
    sumx += (array[i].rot*ny + array[i].repulse*nx)*intensity*amount;
    sumy += (-array[i].rot*nx + array[i].repulse*ny)*intensity*amount;
  }
  sumx += amount2*(noise(100+scl*x,100+scl*y)-0.5);
  sumy += amount2*(noise(200+scl*x,200+scl*y)-0.5);
  return new PVector(sumx+15,sumy-30);
}

void path_step(){
  for(int i=0;i<NPart;i++){
    array2[i].update();
  }
}

int nsteps = 50;


void setup(){
  size(500,500,P3D);
  result = new int[width*height][3];
  background(0);
  
  array[0] = new Center(0.5*width,0.4*height,5);
  
  for(int i=0;i<NPart;i++){
    array2[i] = new Path();
  }
  
  for(int i=0;i<nsteps;i++){
    println(i+1);
    path_step();
  }
}



void draw_(){
  background(0);
  lights();
  push();

  translate(0,50,-0);
  rotateX(0.95);
  for(int i=0;i<NPart;i++){
    array2[i].show2();
  }
  for(int i=0;i<N;i++){
    float rad = 7*array[i].repulse;
    push();
    translate(array[i].x+6,array[i].y-12);
    fill(0);
    noStroke();
    sphere(rad);
    pop();
  }
  
  pop();
}