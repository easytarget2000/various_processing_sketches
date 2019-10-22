// Based on https://pastebin.com/nzeihThd, http://p5art.tumblr.com/post/163484884053/

import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam cam;
float theta;
int num = 150;
int frms = 200;

void setup() {
  size(540, 540, P3D);
  smooth(8);
  background(0);

  cam = new PeasyCam(this, width/2, height/2, 0, 800);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1000);
}

void draw() {
  background(#E9D3AF);
  strokeWeight(1);
  stroke(255, 15);
  lights();
  translate(width/2, height/2, -100);
  fill(#41A3A3);
  noStroke();

  for (int i=0; i<num; i++) {
    float y = map(i, 0, num, -height*.65, height*.65);
    float offSet = TWO_PI/num*i;
    float boxSize = map(sin(theta+offSet*2), -1, 1, 30, 100);
    float x = map(sin(theta+offSet*1), -1, 1, -150, 150);
    pushMatrix();
    translate(x, y);
    sphere(boxSize);
    popMatrix();
  } 

  //println(frameRate);

  //videoExport.saveFrame();

  theta += TWO_PI/frms;
}
