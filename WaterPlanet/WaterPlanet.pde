// Water Planet Impression
// Processing 3.2.1
// 2017.02.12
import processing.opengl.*;

private World wd;

private Particle pt;

void setup() {
  size(1920, 1080, P3D);
  colorMode(HSB, 360, 100, 100, 100);
  smooth();
  sphereDetail(12);
  //frameRate(30);

  wd = new World();
  pt = new Particle();

  background(0);
}

void draw() {
  wd.redraw();

  // rotate the world
  wd.rotate();

  // particles
  pt.draw();


  //saveFrame("frames/####.png");
  //if (frameCount >= 3300) {
  //  exit();
  //}
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