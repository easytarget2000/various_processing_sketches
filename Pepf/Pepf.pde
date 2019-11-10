import processing.video.*; //<>// //<>//

private static final color OVERLAY_COLOR = 0xFFFFFFFF;
private Capture cameraCapture;
private PImage lastImage;
private boolean showCameraImage = false;
private boolean showCameraBrightness = true;
private int brightnessCalcStepSize = 1;
private int scanItemsPerRow = 6;
private int scanItemsPerCol = 4;
private int scanRow = 0;
private int scanColumn = 0;
private boolean isScanning = false;
private float[] brightnessValues;

void setup() {
  size(1090, 600);

  String[] cameras = Capture.list();

  colorMode(HSB, 1f);

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

  initScan();
  background(0);
}

void draw() {
  if (cameraCapture.available() == false) {
    return;
  }

  if (isScanning) {
    drawScanOverlay();
    compareCameraBrightness();
  } else {
    drawScanResults();
  }
}

private void initScan() {
  brightnessValues = new float[scanItemsPerRow * scanItemsPerCol];
  isScanning = true;
}

private void compareCameraBrightness() {
  //image(cam, 0, 0);
  cameraCapture.read();
  //image(cam, 0, 0);
  final PImage camImage = cameraCapture.copy();

  if (lastImage == null) {
    lastImage = camImage;
    return;
  }

  final PImage blendImage = camImage.copy();
  blendImage.blend(lastImage, 0, 0, lastImage.width, lastImage.height, 0, 0, camImage.width, camImage.height, SUBTRACT);
  if (showCameraImage) {
    set(0, 0, blendImage);
  }
  lastImage = camImage.copy();

  final float brightness = imageBrightness(blendImage);
  setScanBrightnessValue(scanColumn, scanRow, brightness);//brightness;
  if (showCameraBrightness) {
    text(String.valueOf(brightness), 10f, 10f);
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

private void drawScanOverlay() {
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
      isScanning = false;
    }
  }
}

private void drawScanResults() {
  final float scanRowWidth = width;
  final float scanItemWidth = scanRowWidth / scanItemsPerRow;
  final float scanColHeight = height;
  final float scanItemHeight = scanColHeight / scanItemsPerCol;

  noStroke();
  for (int col = 0; col < scanItemsPerCol; col++) {
    for (int row = 0; row < scanItemsPerRow; row++) {
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
