import processing.video.*; //<>// //<>//

private Capture cam;
private PImage lastImage;
private boolean drawOverlay = false;

void setup() {
  fullScreen(P2D);

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
    cam = new Capture(this, width, height, cameras[lastCamIndex]);
    cam.start();
  }

  background(0);
  frameRate = 1;
}

void draw() {
  if (cam.available() == false) {
    return;
  }

  background(0);
  drawFromCam();

  if (drawOverlay) {
    drawOverlay();
  }
}

private void drawFromCam() {
  //image(cam, 0, 0);
  cam.read();
  //image(cam, 0, 0);
  final PImage camImage = cam.copy();
  final float brightness = imageBrightness(camImage);

  text(String.valueOf(brightness), 10f, 10f);
  camImage.save("cam.jpg");
  //exit();
}

private float imageBrightness(final PImage image) {

  float brightnessSum = 0;
  int pixelCounter = 0;
  for (int x = 0; x < image.width; x++) {
    for (int y = 0; y < image.height; y++) {
      final color color_ = image.get(x, y); //<>//
      if (color_ != -16777216) {
        println("c: ", color_);
      }
      brightnessSum += brightness(color_);
      pixelCounter += 1f;
    }
  }

  final int maxBrightness = pixelCounter * 0xFFFFFF;
  return brightnessSum / (float) pixelCounter;
}

private void drawOverlay() {
  //fill(0xFFFFFFFF);
  //noStroke();
  stroke(0xFFFFFFFF);
  noFill();
  rect(width / 2f - 50f, height / 2f - 50f, 100f, 100f);
  rect(width / 2f - 40f, height / 2f - 40f, 80f, 80f);
  rect(width / 2f - 20f, height / 2f - 20f, 40f, 40f);
}
