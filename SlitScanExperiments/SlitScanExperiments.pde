import processing.video.*;

Capture cam;
int X=0;

void setup() {
  size(640, 480);

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();
  }
}

void draw() {
  for (int i = 0; i < 8; i++) {
    performSlitRound();
  }

  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
}

private void performSlitRound() {
  if (!cam.available()) {
    return;
  }
  cam.read();
  cam.loadPixels();
  copy(
    cam, 
    (cam.width/2), 
    0, 
    1, 
    cam.height, 
    (X++%width), 
    0, 
    1, 
    height
    );
}
