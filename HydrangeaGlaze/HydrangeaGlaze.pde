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

private Conductor conductor;

private float deltaYAngle = 64f;

private PshapeElement shapeElement;

private float hue = 0f;

private float elementXScale;

private float elementYScale;

private float deltaElementYScale;

private float deltaHue = 0.001f;

private PVector cameraPosition;

private PVector cameraVelocity;

private boolean clearScreen = false;

private boolean swapColors;

void setup() {
  size(1920, 1080, P3D);
  //fullScreen(P3D, 2);
  frameRate(60f);

  colorMode(HSB, 1f, 1f, 1f, 1f);
  blendMode(SCREEN);
  strokeWeight(0.06);
  smooth(8);

  initCamera();

  conductor = new Conductor(130f);

  shapeElement = new RoundBrush();
  initElementScale();

  setSwapColorsRandomly();
  
  frameRate(30);
}

void draw() {

  setSwapColorsRandomly();
  drawBackground();

  if (random(1f) > 0.8f) {
    clearScreen = !clearScreen;
  }
  //translate(0, 0, 0);
  adjustCamera();

  drawPottery();

  if (conductor.isBeatDue(4) && random(1f) > 0.5f) {
    reverseCameraYVelocity();
  }
}

void keyPressed() {
  initElementScale();
}

private void drawPottery() {

  PVector locateRound = new PVector(0, 0, 0);
  PVector locateEllipse = new PVector(0, 0, 0);

  final float radiusEllipse = 799f;

  adjustElementScale();
  adjustHue();
  float currentHue = hue;
  final float alpha = clearScreen ? 1f : 0.67f;

  for (float yAngle = 0f; yAngle <= 360f; yAngle += deltaYAngle) { // Y
    final float yRotationRad = radians(yAngle);
    final float deltaZAngle = (deltaYAngle / 2f) * max((128f / deltaYAngle * sin(yRotationRad)), 2f);

    for (float zAngle = 0f; zAngle <= 360f - deltaZAngle; zAngle += deltaZAngle) { // Z

      final float zRotationRad = radians(zAngle);

      currentHue += 0.01f;

      locateEllipse.set(
        radiusEllipse * cos(zRotationRad) * sin(yRotationRad), 
        radiusEllipse * sin(zRotationRad) * sin(yRotationRad), 
        radiusEllipse * cos(yRotationRad)
        );

      pushMatrix();
      translate(locateRound.x, locateRound.y, locateRound.z);
      rotateZ(zRotationRad); // must be this order Z -> Y
      rotateY(yRotationRad);

      if (swapColors) {
        shapeElement.setColor(0f, 0f, 1f, alpha);
      } else {
        shapeElement.setColor(
          currentHue, 
          1f, 
          0.7f, 
          alpha
          );
      }

      shapeElement.drawShape();
      popMatrix();
    }
  }
}

private void drawBackground() {
  if (clearScreen) {
    if (swapColors) {
      background(hue, 0.5f, 1f);
    } else {
      background(0f, 0f, 0f);
    }
  }
}

/*
Camera
 */

private void initCamera() {
  final float cameraX = 0f;
  final float cameraY = 2048f;
  final float cameraZ = min(width, height);
  cameraPosition = new PVector(cameraX, cameraY, cameraZ);

  cameraVelocity = new PVector(0f, cameraY / 64f, 0f);
}

private void adjustCamera() {
  if (cameraPosition.y < 128f || cameraPosition.y > 3000f) {
    cameraVelocity.y *= -1f;
  }

  cameraPosition = PVector.add(cameraPosition, cameraVelocity);

  camera(
    cameraPosition.x, cameraPosition.y, cameraPosition.z, 
    0f, 0f, 0f, 
    0f, 1f, 0f
    );
}

private void reverseCameraYVelocity() {
  //cameraVelocity.y *= -1f;
}

private void adjustHue() {
  hue += deltaHue;
  if (hue > 1f || hue < 0f) {
    deltaHue *= -1f;
    hue += deltaHue;
  }
}

private void initElementScale() {
  elementXScale = min(width, height) / 64f;
  elementYScale = elementXScale / 8f;
  deltaElementYScale = elementYScale / 16f;
  shapeElement.changeSize(elementXScale, elementYScale, 16f);
}

private void adjustElementScale() {
  elementYScale += deltaElementYScale;
  if (elementYScale < elementXScale / 16f || elementYScale > elementXScale * 1.5f) {
    deltaElementYScale *= -1f;
    elementYScale += deltaElementYScale;
  }
  shapeElement.resetSize();
  shapeElement.changeSize(elementXScale, elementYScale, 16f);
}

private void setSwapColorsRandomly() {
  if (random(1f) > 0.99f) {
    swapColors = !swapColors;
  }
}
