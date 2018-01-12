/*
Based on http://deconbatch.blogspot.de/2017/06/hydrangea-glaze.html
 
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
 
 private float divIdo = 4f;

import java.util.Random;

/* ---------------------------------------------------------------------- */
abstract class PshapeElement {

  PShape anElement;
  float elementColor, elementSaturation, elementBright, elementAlpha;

  PshapeElement() {
    anElement = pscreateElement();
    elementColor = 0;
    elementSaturation = 0;
    elementBright = 0;
    elementAlpha = 0;
  }

  abstract PShape pscreateElement();

  void setElementFill(float pcolor, float psaturation, float pbright, float palpha) {
    elementColor = pcolor;
    elementSaturation = psaturation;
    elementBright = pbright;
    elementAlpha = palpha;
    resetColor();
  }

  void resetColor() {
    anElement.setFill(color(elementColor, elementSaturation, elementBright, elementAlpha));
    anElement.setStroke(color(elementColor, elementSaturation, elementBright, elementAlpha));
  }

  void changeColor(float scolor) {
    elementColor = scolor;
    resetColor();
  }

  void changeBright(float sbright) {
    elementBright = sbright;
    resetColor();
  }

  void resetSize() {
    anElement.resetMatrix();
  }

  void changeSize(float scaleX, float scaleY, float scaleZ) {
    anElement.scale(scaleX, scaleY, scaleZ);
  }

  void rotate(float radX, float radY, float radZ) {
    anElement.rotateX(radX);
    anElement.rotateY(radY);
    anElement.rotateZ(radZ);
  }

  void show() {
    shape(anElement);
  }
}

/* ---------------------------------------------------------------------- */
class RoundBrush extends PshapeElement {

  RoundBrush() {
    super();
  }

  PShape pscreateElement() {

    stroke(0);
    noFill();
    PShape psDp = createShape(ELLIPSE, 0.0, 0.0, 10.0, 10.0);
    return psDp;
  }
}

/* ---------------------------------------------------------------------- */
class EllipseBrush extends PshapeElement {

  EllipseBrush() {
    super();
  }

  PShape pscreateElement() {

    noStroke();
    fill(0);
    PShape psDp = createShape(ELLIPSE, 0.0, 0.0, 10.0, 10.0);
    return psDp;
  }
}

/* ---------------------------------------------------------------------- */

PshapeElement pRound, pEllipse;

private float cameraEyeY = 1800f;

private float cameraVelocity = 0.01f;

void setup() {
  size(1920, 1080, P3D);

  colorMode(HSB, 360, 100, 100, 100);
  blendMode(SCREEN);
  strokeWeight(0.06);
  smooth(8);
  //noLoop();
  //  frameRate(1);

  pRound = new RoundBrush();
  pEllipse = new EllipseBrush();
}

void draw() {
  
  if (random(1f) > 0.9f) {
    background(0);
    return;
  }
  
  setCameraEyeY();

  background(0, 0, 8);

  translate(0, 0, 0);
  camera(
    0, cameraEyeY, 1000, 
    0, 0, 0, 
    0, 1, 0
    );

  drawPottery();

  if (random(1f) > 0.8f) {
    reverseCameraVelocity();
  }

  //saveFrame("frames/####.png");
  //exit();
}

private void drawPottery() {

  PVector locateRound = new PVector(0, 0, 0);
  PVector locateEllipse = new PVector(0, 0, 0);

  final float radiusRound = 800.0;
  final float radiusEllipse = 799.0;
  divIdo -= 0.1f;
  if (divIdo < 6f) {
    divIdo = 24f;
  }
  float divKdo = 0.0; // dummy
  final float circleBase = 6.0;
  final float circleMult = 3.0;
  //  final float circleBase = 8.0;
  //  final float circleMult = 2.0;

  float noiseHueIdo = random(50);
  float noiseSatIdo = random(50);
  float noiseSizIdo = random(50);

  final float noiseHueKdoStarter = random(50);
  final float noiseSatKdoStarter = random(50);
  final float noiseSizKdoStarter = random(50);

  for (float ido = 32f; ido <= 256f; ido += divIdo) { // Y
    final float radianIdo = radians(ido);
    divKdo = 32f / max((128f / divIdo * sin(radianIdo)), 1f);

    float noiseHueKdo = noiseHueKdoStarter;
    float noiseSatKdo = noiseSatKdoStarter;
    float noiseSizKdo = noiseSizKdoStarter;

    for (float kdo = 0; kdo <= 360 - divKdo; kdo += divKdo) { // Z

      final float radianKdo = radians(kdo);
      locateRound.set(
        radiusRound * cos(radianKdo) * sin(radianIdo), 
        radiusRound * sin(radianKdo) * sin(radianIdo), 
        radiusRound * cos(radianIdo)
        );
      locateEllipse.set(
        radiusEllipse * cos(radianKdo) * sin(radianIdo), 
        radiusEllipse * sin(radianKdo) * sin(radianIdo), 
        radiusEllipse * cos(radianIdo)
        );

      final float roundSize = map(noise(noiseSizIdo, noiseSizKdo), 0.0, 1.0, circleMult * circleBase, circleBase);
      final float roundHue = map(noise(noiseHueIdo, noiseHueKdo), 0.0, 1.0, 260, 360);
      final float roundSat = map(noise(noiseSatIdo, noiseSatKdo), 0.0, 1.0, 20.0, 100.0);
      final float roundBri = map(noise(noiseSatIdo, noiseSatKdo), 0.0, 1.0, 60.0, 100.0);
      final float roundAlp = 100;

      final float fctBri = map(locateRound.z, -radiusRound, radiusRound, 0.1, 1.2);

      // glaze
      pushMatrix();
      translate(locateRound.x, locateRound.y, locateRound.z);
      rotateZ(radianKdo); // must be this order Z -> Y
      rotateY(radianIdo);
      pRound.resetSize();
      pRound.changeSize(roundSize, roundSize, 1.0);
      pRound.setElementFill(roundHue, roundSat, roundBri * fctBri, roundAlp);
      pRound.show();
      popMatrix();

      noiseHueKdo += 0.05;
      noiseSatKdo += 0.12;
      noiseSizKdo += 0.10;
    }

    noiseHueIdo += 0.05f;
    noiseSatIdo += 0.12f;
    noiseSizIdo += 0.10f;
  }
}

private void setCameraEyeY() {
  cameraEyeY += cameraVelocity;
}

private void reverseCameraVelocity() {
  cameraVelocity *= -1f;
}