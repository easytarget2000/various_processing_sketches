import processing.video.*; //<>// //<>//

private static final boolean VERBOSE = true;
private static final boolean SAVE_SCAN_IMAGE_FILES = true;
private static final String SCAN_FILE_NAME_FORMAT = "scan_%s_%d_%d_%f.jpg";
private static final color OVERLAY_COLOR = 0xFFFFFFFF;
private static final int DRAW_TO_READ_SCAN_DELAY_MILLIS = 32;

LuminanceCalculator luminanceCalculator = new LuminanceCalculator();
private String scanFileNamePrefix;
private Capture cameraCapture;
private PImage lastImage;
private Mode mode = Mode.CAMERA;
private int numOfReadsPerScan = 5;
private int scanItemsPerRow = 32;
private int scanItemsPerCol = 24;
private int scanRow = 0;
private int scanColumn = 0;
private float[] luminanceValues;

void setup() {
  //size(1090, 600);
  fullScreen(2);
  colorMode(HSB, 1f, 1f, 1f, 1f);
    frameRate(60f);

  initCameraCapture();
  background(0);

  //final PImage testImage = loadImage("test-pink.jpg");
  //final float luminance = luminanceCalculator.imageLuminance(testImage);
  //println("testImage luminance:", luminance);
}

void draw() {
  if (cameraCapture.available() == false) {
    return;
  }

  switch (mode) {
  case CAMERA:
    showCameraImage();
    return;
  case SCAN:
    drawScanItemAndAdvance();
    return;
  case SCAN_DONE:
    drawScanValues();
  }
}

void keyPressed() {
  switch (key) {
  case 's':
    initScanMode();
    return;
  case 'c':
    setCameraMode();
    return;
  case 'b':
    return;
  }
}

/*
Implementations
 */

private void initCameraCapture() {  
  final String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    final int lastCamIndex = cameras.length - 1;
    cameraCapture = new Capture(this, width, height, cameras[lastCamIndex]);
    cameraCapture.start();
  }
}

private void initScanMode() {
  background(0);
  delay(512);
  
  scanFileNamePrefix = String.valueOf((int) random(10000f));
  luminanceValues = new float[scanItemsPerRow * scanItemsPerCol];
  mode = Mode.SCAN;
}

private void setCameraMode() {
  mode = Mode.CAMERA;
}

private void showCameraImage() {
  cameraCapture.read();
  //image(cameraCapture, 0f, 0f);
  set(0, 0, cameraCapture);
  colorMode(HSB, 1f);

  noStroke();
  fill(0xFFFFFFFF);
  final float targetWidth = width / 10f;
  ellipse(
    width / 2f, 
    height / 2f, 
    targetWidth, 
    targetWidth
    );
}

private void drawScanItemAndAdvance() {
  background(0);

  if (lastImage == null) {
    cameraCapture.read();
    lastImage = cameraCapture.copy();
    return;
  }

  final float scanRowWidth = width;
  final float scanItemWidth = scanRowWidth / scanItemsPerRow;
  final float scanItemX = scanColumn * scanItemWidth;
  final float scanColHeight = height;
  final float scanItemHeight = scanColHeight / scanItemsPerCol;
  final float scanItemY = scanRow * scanItemHeight;

  noStroke();
  fill(OVERLAY_COLOR);
  rect(scanItemX, scanItemY, scanItemWidth, scanItemHeight);

  float luminance = 0f;
  for (int i = 0; i < numOfReadsPerScan; i++) { 
    //delay(DRAW_TO_READ_SCAN_DELAY_MILLIS);

    cameraCapture.read();
    //final PImage camImage = cameraCapture.copy();
    //final PImage blendImage = camImage.copy();
    //blendImage.blend(
    //  lastImage, 
    //  0, 
    //  0, 
    //  lastImage.width, 
    //  lastImage.height, 
    //  0, 
    //  0, 
    //  camImage.width, 
    //  camImage.height, 
    //  SUBTRACT
    //  );
    luminance += luminanceCalculator.imageLuminance(cameraCapture);

    //lastImage = cameraCapture.copy();
  }

  luminance /= (float) numOfReadsPerScan;
  setScanluminanceValue(scanColumn, scanRow, luminance);

  //if (SAVE_SCAN_IMAGE_FILES) {
  //  final String fileName = getScanFileName(scanColumn, scanRow, luminance);
  //  blendImage.save(fileName);
  //}

  if (++scanColumn >= scanItemsPerRow) {
    scanColumn = 0;
    if (++scanRow >= scanItemsPerCol) {
      scanRow = 0;
      finishScanning();
    }
  }
}

private void finishScanning() {
  mode = Mode.SCAN_DONE;
  normalizeScanValues();
}

private void normalizeScanValues() {
  float lowestluminance = 1f;
  float highestluminance = 0f;
  for (float luminance : luminanceValues) {
    if (luminance > highestluminance) {
      highestluminance = luminance;
    } else if (luminance < lowestluminance && luminance > 0.0f) {
      lowestluminance = luminance;
    }
  }

  if (VERBOSE) {
    println("luminanceValues before normalisation:");
    println(luminanceValues);
    println();
    println("Lowest luminance:", lowestluminance);
    println("Highest luminance:", highestluminance);
  }

  for (int i = 0; i < luminanceValues.length; i++) {
    luminanceValues[i] = map(
      luminanceValues[i], 
      lowestluminance, 
      highestluminance, 
      0.2f, 
      1f
      );
  }

  if (VERBOSE) {
    println();
    println("luminanceValues after normalisation:");
    println(luminanceValues);
  }
}

private void drawScanValues() {
  final float scanRowWidth = width;
  final float scanItemWidth = scanRowWidth / scanItemsPerRow;
  final float scanColHeight = height;
  final float scanItemHeight = scanColHeight / scanItemsPerCol;

  noStroke();
  for (int col = 0; col < scanItemsPerRow; col++) {
    for (int row = 0; row < scanItemsPerCol; row++) {
      final float itemX = col * scanItemWidth;
      final float itemY = row * scanItemHeight;

      final float luminance = getScanluminanceValue(col, row);
      fill(luminance);
      rect(itemX, itemY, scanItemWidth, scanItemHeight);
    }
  }
}

private void setScanluminanceValue(final int col, final int row, final float value) {
  luminanceValues[col + (row * scanItemsPerRow)] = value;
}

private float getScanluminanceValue(final int col, final int row) {
  return luminanceValues[col + (row * scanItemsPerRow)];
}

private String getScanFileName(final int scanColumn, final int scanRow, float luminance) {
  return String.format(SCAN_FILE_NAME_FORMAT, scanFileNamePrefix, scanRow, scanColumn, luminance);
}
