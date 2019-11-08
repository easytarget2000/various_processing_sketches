import processing.video.*; //<>// //<>//

private static final color OVERLAY_COLOR = 0xFFFFFFFF;
private Capture cameraCapture;
private PImage lastImage;
private boolean showCameraImage = false;
private boolean showCameraBrightness = false;
private int overlayItemsPerRow = 60;
private int overlayItemsPerCol = 40;
private int overlayRow = 0;
private int overlayCol = 0;

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

  background(0);
  frameRate = 1;
}

void draw() {
  if (cameraCapture.available() == false) {
    return;
  }

  drawOverlay();
  compareCameraBrightness();
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

  if (showCameraBrightness) {
    text(String.valueOf(brightness), 10f, 10f);
  }
}

private float imageBrightness(final PImage image) {

  float brightnessSum = 0;
  int pixelCounter = 0;
  for (int x = 0; x < image.width; x++) {
    for (int y = 0; y < image.height; y++) {
      final color color_ = image.get(x, y);
      brightnessSum += brightness(color_);
      pixelCounter += 1f;
    }
  }

  return brightnessSum / (float) pixelCounter;
}

private void drawOverlay() {
  background(0);
  noFill();
  stroke(OVERLAY_COLOR);
  rect(0f, 0f, width - 1f, height - 1f);

  final float rowLength = width;
  final float overlayItemWidth = rowLength / overlayItemsPerRow;
  final float overlayItemX = overlayCol * overlayItemWidth;
  final float colHeight = height;
  final float overlayItemHeight = colHeight / overlayItemsPerCol;
  final float overlayItemY = overlayRow * overlayItemHeight;

  noStroke();
  fill(OVERLAY_COLOR);
  rect(overlayItemX, overlayItemY, overlayItemWidth, overlayItemHeight);

  if (++overlayCol > overlayItemsPerRow) {
    overlayCol = 0;
    if (++overlayRow > overlayItemsPerCol) {
      overlayRow = 0;
    }
  }
}
