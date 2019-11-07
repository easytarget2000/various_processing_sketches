import processing.video.*;

private Capture cam;
private int X = 0;
private boolean drawOverlay = false;
private boolean slitScan = true;
private float slitScanWidthToImageRatio = 1f / 128f;

void setup() {
  fullScreen(P2D);

  String[] cameras = Capture.list();

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
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }

  if (slitScan) {
    for (int i = 0; i < 1; i++) {
      drawSlitScanFromCam();
    }
  } else {
    drawFromCam();
  }

  if (drawOverlay) {
    drawOverlay();
  }
  
  if (randomClear) {
  }
}

private void drawSlitScanFromCam() {
  final int sourceX = cam.width / 2;
  final int sourceY = 0;
  final int sourceWidth = (int) (cam.width * slitScanWidthToImageRatio);
  final int sourceHeight = cam.height;
  final int destinationWidth = (int) (width * slitScanWidthToImageRatio);
  final int destinationHeight = height;
  final int destinationX = (X += sourceWidth) % width;
  final int destinationY = 0;
  copy(
    cam, 
    sourceX, 
    sourceY, 
    sourceWidth, 
    sourceHeight, 
    destinationX, 
    destinationY, 
    destinationWidth, 
    destinationHeight
    );
}

private void drawFromCam() {
  //image(cam, 0, 0);
  set(0, 0, cam);
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
