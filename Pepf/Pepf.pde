import processing.video.*; //<>//

private static final boolean VERBOSE = true;
private static final color OVERLAY_COLOR = 0xFFFFFFFF;
private static final String SCAN_FILE_NAME_FORMAT = "scan_%s_%d_%d_%f.jpg";
private String scanFileNamePrefix;
private Capture cameraCapture;
private PImage lastImage;
private Mode mode = Mode.CAMERA;
private boolean saveBlendImages = true;
private int brightnessCalcStepSize = 1;
private int scanItemsPerRow = 8;
private int scanItemsPerCol = 4;
private int scanRow = 0;
private int scanColumn = 0;
private float[] brightnessValues;

void setup() {
  size(1090, 600);
  //fullScreen(2);


  colorMode(HSB, 1f);

  initCameraCapture();
  background(0);
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
    compareCameraBrightness();
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
  scanFileNamePrefix = String.valueOf((int) random(10000f));
  brightnessValues = new float[scanItemsPerRow * scanItemsPerCol];
  mode = Mode.SCAN;
}

private void setCameraMode() {
  mode = Mode.CAMERA;
}

private void showCameraImage() {
  cameraCapture.read();
  //image(cameraCapture, 0f, 0f);
  set(0, 0, cameraCapture);

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
  noFill();
  stroke(OVERLAY_COLOR);
  rect(0f, 0f, width - 1f, height - 1f);

  final float scanRowWidth = width;
  final float scanItemWidth = scanRowWidth / scanItemsPerRow;
  final float scanItemX = scanColumn * scanItemWidth;
  final float scanColHeight = height;
  final float scanItemHeight = scanColHeight / scanItemsPerCol;
  final float scanItemY = scanRow * scanItemHeight;

  noStroke();
  fill(OVERLAY_COLOR);
  rect(scanItemX, scanItemY, scanItemWidth, scanItemHeight);

  if (++scanColumn >= scanItemsPerRow) {
    scanColumn = 0;
    if (++scanRow >= scanItemsPerCol) {
      scanRow = 0;
      finishScanning();
    }
  }
}

private void compareCameraBrightness() {
  cameraCapture.read();
  final PImage camImage = cameraCapture.copy();

  if (lastImage == null) {
    lastImage = camImage;
    return;
  }

  final PImage blendImage = camImage.copy();
  blendImage.blend(
    lastImage, 
    0, 
    0, 
    lastImage.width, 
    lastImage.height, 
    0, 
    0, 
    camImage.width, 
    camImage.height, 
    SUBTRACT
    );
  lastImage = camImage.copy();

  final float brightness = imageBrightness(blendImage);
  setScanBrightnessValue(scanColumn, scanRow, brightness);

  if (saveBlendImages) {
    final String fileName = getScanFileName(scanColumn, scanRow, brightness);
    blendImage.save(fileName);
  }
}

private float imageBrightness(final PImage image) {
  float brightnessSum = 0;
  int pixelCounter = 0;
  for (int x = 0; x < image.width; x += brightnessCalcStepSize) {
    for (int y = 0; y < image.height; y += brightnessCalcStepSize) {
      final color color_ = image.get(x, y);
      brightnessSum += brightness(color_);
      pixelCounter += brightnessCalcStepSize;
    }
  }

  return (brightnessSum * brightnessCalcStepSize) / (float) pixelCounter;
}

private void finishScanning() {
  mode = Mode.SCAN_DONE;
  normalizeScanValues();
}

private void normalizeScanValues() {
  float lowestBrightness = 1f;
  float highestBrightness = 0f;
  for (float brightness : brightnessValues) {
    if (brightness > highestBrightness) {
      highestBrightness = brightness;
    } else if (brightness < lowestBrightness) {
      lowestBrightness = brightness;
    }
  }

  if (VERBOSE) {
    println("brightnessValues before normalisation:");
    println(brightnessValues);
  }

  for (int i = 0; i < brightnessValues.length; i++) {
    brightnessValues[i] = map(
      brightnessValues[i], 
      lowestBrightness, 
      highestBrightness, 
      0f, 
      1f
      );
  }

  if (VERBOSE) {
    println();
    println("brightnessValues after normalisation:");
    println(brightnessValues);
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

      final float brightness = getScanBrightnessValue(col, row);
      fill(brightness);
      rect(itemX, itemY, scanItemWidth, scanItemHeight);
    }
  }
}

private void setScanBrightnessValue(final int col, final int row, final float value) {
  brightnessValues[col + (row * scanItemsPerRow)] = value;
}

private float getScanBrightnessValue(final int col, final int row) {
  return brightnessValues[col + (row * scanItemsPerRow)];
}

private String getScanFileName(final int scanColumn, final int scanRow, float brightness) {
  return String.format(SCAN_FILE_NAME_FORMAT, scanFileNamePrefix, scanColumn, scanRow, brightness);
}
