int numFrames = 256;

void setup(){
  fullScreen(P3D);
  
  stroke(255);
    frameRate(60f);

  fill(255);
  
  background(0);
}

private float radius = 0f;

float x1(float t){
  return 0.25*width + radius*cos(TWO_PI*t);
}
float y1(float t){
  return 0.5*height + radius*sin(TWO_PI*t);
}

float x2(float t){
  return 0.75*width + radius*cos(2*TWO_PI*t);
}
float y2(float t){
  return 0.5*height + radius*sin(2*TWO_PI*t);
}

int numberOfLinePoints = 2048;

void draw(){
  radius = min(width, height) / 3f;
  float t = 1.0*(frameCount - 1)/numFrames;
  final float delay_factor = frameCount / 256f;

  //background(0);
  fill(50f, 100f);
  noStroke();
  rect(0f, 0f, width, height);
  
  //ellipse(x1(t),y1(t),6,6);
  //ellipse(x2(t),y2(t),6,6);
  
  pushStyle();
  strokeWeight(2);
  stroke(255f,64f);
  noFill();
  
  for(int i=0;i<=numberOfLinePoints;i++){
    float tt = 1.0*i/numberOfLinePoints;
    
    float x = lerp(x1(t - delay_factor*tt),x2(t),tt);
    float y = lerp(y1(t - delay_factor*tt),y2(t),tt);
    
    point(x,y);
  }
  popStyle();
}
