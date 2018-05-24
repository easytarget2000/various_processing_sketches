
float theta;   
float a = 380f;
int c=355;


void setup() {
  fullScreen();
  smooth();
  background(0);
  //strokeWeight(3);
}
void draw() {

  fill(0x10000000);
  noStroke();
  rect(0f, 0f, width, height);
  noFill();
  
  //background(0);
  for (int i = 0; i < 1; i++) {
    cycle();
  }
}

private void cycle() {

  stroke(255);
  theta = radians(a);
  translate(width/2, height/2);
  branch(350);
  a += 0.2f;
  //println(a);
  stroke(random(255), random(255), random(255));
  if (a >= 360f) {
    a = 0f;
  }
}

void branch(float h) {
  h *= 0.4f;
  stroke(random(255), random(55), random(80f), 255f);

  for (int i = 0; i < 8; i = i+1) {

    if (h > 16f) {

      pushMatrix();  
      rotate(theta*i); 
      //line(0, 0, random(2), -h);
      point(0f, 0f);
      point(random(2f), -h / 2f);
      point(random(2f), -h);
      translate(0, -h); 
      branch(h-i);      
      popMatrix();
    }
  }
}
