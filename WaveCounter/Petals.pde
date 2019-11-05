class Petals {

  private float cntWidthMax;

  private float divRotate;

  private float cntRotateMax;

  private float basePetalSize;

  private float baseColor;

  private float petalBaseFrom, petalBaseTo, petalDivFrom, petalDivTo;

  private float noiseShpStart = random(100f); //random(0.5, 3.0);
  private float noiseHueStart = random(100f);
  private float noiseBriStart = random(100f);
  private float noiseAlpStart = random(100f);
  private float noiseSatStart = random(100f);

  public Petals() {
    divRotate = 16f; // divide 360 degree
    cntRotateMax = 2f * 360f * divRotate;  // draw while rotating
    cntWidthMax = 2f; // repeat same shape with different ellipse size
    basePetalSize = 640f;
    baseColor = map(random(1.0), 0.0, 1.0, 210.0, 360.0);
  }

  public void drawPetals() {

    for (float cntWidth = 1f; cntWidth <= cntWidthMax; ++cntWidth) {

      float noiseHue = noiseHueStart + cntWidth / 300;
      float noiseSat = noiseSatStart;
      float noiseBri = noiseBriStart;
      float noiseAlp = noiseAlpStart;
      float noiseShp = noiseShpStart;
      float sumRotation = 0f;

      for (float cntRotate = 0f; cntRotate < cntRotateMax; ++cntRotate) {

        // rotate fixed degree and calculate the plot point
        float rotation = 1f / divRotate;
        canvasRotation(rotation);
        sumRotation += rotation;
        float idxW = 0.0;
        float idxH = basePetalSize * sin(radians(sumRotation / (50f + 5f * cos(radians(2f * cntRotate))))) * map(noise(noiseShp), 0.0, 1.0, 0.8, 1.2);
        ;

        float brushHue = (baseColor + 360 + map(noise(noiseHue), 0.0, 1.0, -60.0, 60)) % 360;
        float brushSat = map(noise(noiseSat), 0.0, 1.0, 50.0, 100.0);
        float brushSiz = map(noise(noiseBri), 0.0, 1.0, 0.0, 1.0 * cntWidth);
        float brushBri = map(noise(noiseBri), 0.0, 1.0, 0.0, 100.0) / cntWidth;
        float brushAlp = map(noise(noiseAlp), 0.0, 1.0, 0.0, 100.0);
        drawLine(idxW, idxH, brushHue, brushSat, brushBri, brushAlp, brushSiz);

        noiseHue += 0.001f;
        noiseSat += 0.003f;
        noiseBri += 0.005f;
        noiseAlp += 0.005f;
        noiseShp += random(0.02f);
      }

      canvasRotation(-cntRotateMax);
    }


    noiseHueStart += 0.005f;
    noiseSatStart += 0.002f;
    noiseBriStart -= 0.003f;
    noiseAlpStart -= 0.006f;
    noiseShpStart += 0.002f;
  }

  private void drawLine(float idxW, float idxH, float brushHue, float brushSat, float brushBri, float brushAlp, float brushSiz) {
    pushMatrix();
    translate(idxW, idxH);
    fill(brushHue, brushSat, brushBri, brushAlp);
    ellipse(0.0, 0.0, brushSiz, brushSiz);
    popMatrix();
  }

  private void canvasRotation(final float degrees) {
    rotate(radians(degrees));
  }
}