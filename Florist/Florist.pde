// inspired by https://www.facebook.com/groups/creativecodingp5/permalink/2042044922710207/

import java.util.*;

float[] counts;

void setup() {
  //size(600, 600);
  fullScreen(P3D);
  smooth();
  background(0);
    frameRate(60f);

  counts = new float[width*height];
}

void draw() {
  //background(0);
  //stroke(250, 40);
  final float t = cos(map(frameCount, 0f, 180f, 0f, TWO_PI));
  
  Arrays.fill(counts, 0);
  for (int i = 0; i < 32 * 1024; i++) {
    final float x = random(-1f, 1f);
    final float y = random(-1f, 1f);
    final float xx = map(noise(x, y, t), 0f, 1f, 64f, width);
    final float yy = map(noise(y, x, t), 0f, 1f, 64f, height);
    final int pixelIndex = int(yy) * width + int(xx);
    counts[pixelIndex]++;
    counts[pixelIndex + 1]++;
    //point(xx, yy);
  }
  
  loadPixels();
  for(int i = 0; i < pixels.length; i++) {
    pixels[i] = color(log(counts[i]) * 32);
  }

  updatePixels();
  drawFps();
}

private void drawFps() {
  fill(0xFF000000);
  rect(8f, 2f, 48f, 16f);
  fill(0xFFFFFFFF);
  text(int(frameRate) + " FPS", 16f, 16f);
}
