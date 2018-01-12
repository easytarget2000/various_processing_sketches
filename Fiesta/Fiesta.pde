private Utils util;
private WallOfEyes wallOfEyes;

void setup() {
  size(1280, 720, P3D);
  //fullScreen(P3D);
  colorMode(HSB, 360, 100, 100, 100);
  smooth();
  background(0, 0, 0);
  
  blendMode(LIGHTEST);
  hint(DISABLE_DEPTH_TEST);

  util = new Utils();  
  wallOfEyes = new WallOfEyes();  
}

void draw() {

  background(0, 0, 0);
  translate(0, 0, 0);
  camera(0, 0, 10,
         0, -60, -100,
         0, 1, 0);

  pointLight(0, 0, 100, 0, 0, 0);
      
  wallOfEyes.drawEyes();
}


/*
Copyright (C) 2016 deconbatch

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