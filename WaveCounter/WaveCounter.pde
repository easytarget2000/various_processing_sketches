/*
Based on http://deconbatch.blogspot.de/2017/09/dont-count-waves.html

Copyright (C) 2017 deconbatch

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see 
*/

private Petals petals;


void setup() {

  size(1080, 1080);
  colorMode(HSB, 360, 100, 100, 100);
  blendMode(SCREEN);
  //noiseSeed(0);
  //smooth();
  noStroke();
  //  noLoop();
  //frameRate(1);
  
  petals = new Petals();  
}

void draw() {

  background(0, 0, 0);
  translate(width / 2, height / 2);

  petals.drawPetals();

  
  //saveFrame("frames/####.png");
  //if (frameCount >= 180) {
  //  exit();
  //}
  
}