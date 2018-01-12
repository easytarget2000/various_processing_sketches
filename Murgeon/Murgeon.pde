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
class Utils {

  Random obj_random;

  Utils() {
    obj_random = new Random();
  }

  float gaussdist(float pmean, float plimit, float pdevi) {
    /**
     Gaussian distribution
     1.parameters.
     pmean  : mean value
     plimit : max value of abs(deviation)
     ex. plimit >= 0
     pmean = 0.5, plimit = 0.5 -> return value = from 0.0 to 1.0
     pdevi  : standard deviation value
     ex. good value? -> pdevi = plimit / 2
     2.return.
     gaussian distribution
     **/

    if (plimit == 0) {
      return pmean;
    }

    float gauss = (float) obj_random.nextGaussian() * pdevi;
    // not good idea
    if (abs(gauss) > plimit) {
      gauss = pow(plimit, 2) / gauss;
    }

    return pmean + gauss;
  }
}

/* ---------------------------------------------------------------------- */

Utils ut;
PshapeElement pRound, pEllipse;

void setup() {
  size(1200, 1200, P3D);

  colorMode(HSB, 360, 100, 100, 100);
  blendMode(SCREEN);
  strokeWeight(0.0001); // sensitive!
  smooth(8);
  noLoop();
  //  frameRate(1);

  ut = new Utils();  
  pRound = new RoundBrush();
}

void draw() {

  background(0, 0, 8);

  translate(0, 0, 0);
  camera(0, 1000, 1400, 
    0, 0, 0, 
    0, 1, 0);

  drawFace();

  saveFrame("frames/####.png");
  exit();
}


void drawFace() {

  PVector locateRound = new PVector(0, 0, 0);

  float divIdo = 0.1;
  float divKdo = 0.0; // dummy
  float circleBase = 8.0;
  float circleMult = 14.0;

  float radiusRound = 500.0;
  float baseColor = random(110, 300); // yellow-green are no good for me.

  float noiseOmtIdo = random(50);
  float noiseSatIdo = random(50);
  float noiseBriIdo = random(50);
  float noiseSizIdo = random(50);

  float noiseOmtKdoStarter = random(50);
  float noiseSatKdoStarter = random(50);
  float noiseBriKdoStarter = random(50);
  float noiseSizKdoStarter = random(50);

  for (float ido = 80; ido <= 120; ido += divIdo) { // Y

    float radianIdo = radians(ido);
    divKdo = 360 / max(180 / divIdo * sin(radianIdo), 1);

    float noiseOmtKdo = noiseOmtKdoStarter;
    float noiseSatKdo = noiseSatKdoStarter;
    float noiseBriKdo = noiseBriKdoStarter;
    float noiseSizKdo = noiseSizKdoStarter;

    for (float kdo = 0; kdo <= 360 - divKdo; kdo += divKdo) { // Z

      // do not draw some part
      if (noise(noiseOmtIdo, noiseOmtKdo) > ut.gaussdist(0.70, 0.5, 0.25)) {

        float radianKdo = radians(kdo);
        locateRound.set(
          radiusRound * cos(radianKdo) * sin(radianIdo), 
          radiusRound * sin(radianKdo) * sin(radianIdo), 
          radiusRound * cos(radianIdo)
          );

        float roundSize = map(noise(noiseSizIdo, noiseSizKdo), 0.0, 1.0, circleMult * circleBase, circleBase);
        float roundHue = (baseColor + map(noise(noiseBriIdo, noiseBriKdo), 0.0, 1.0, 0, 160)) % 360;
        float roundSat = map(noise(noiseSatIdo, noiseSatKdo), 0.0, 1.0, 10.0, 100.0);
        float roundBri = map(noise(noiseBriIdo, noiseBriKdo), 0.0, 1.0, 20.0, 70.0);
        float roundAlp = 100;

        float fctBri = map(locateRound.z, -radiusRound, radiusRound, 0.1, 1.2);

        pushMatrix();
        translate(locateRound.x, locateRound.y, locateRound.z);
        rotateZ(radianKdo); // must be this order Z -> Y
        rotateY(radianIdo);
        pRound.resetSize();
        pRound.changeSize(roundSize, roundSize, 1.0);
        pRound.setElementFill(roundHue, roundSat, roundBri * fctBri, roundAlp);
        pRound.show();
        popMatrix();
      }      

      noiseOmtKdo += 0.008;
      noiseSatKdo += 0.006;
      noiseBriKdo += 0.005;
      noiseSizKdo += 0.003;
    }

    noiseOmtIdo += 0.008;
    noiseSatIdo += 0.006;
    noiseBriIdo += 0.005;
    noiseSizIdo += 0.003;
  }
}

/*
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