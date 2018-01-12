/**
 * Constants
 */

/**
 * Values
 */
 
 private ArrayList<PixelDrop> pixelDrops;

/**
 * Lifecycle
 */

void setup() {
  size(1920, 1080);
  // fullScreen();
  // fullScreen(2);
  background(0);

  initImage();
  initPixelDrops();
}

void draw() {
  
  for (int i = 0; i < pixelDrops.size(); i++) {
    final PixelDrop currentDrop = pixelDrops.get(i);
    final boolean dropIsAlive = currentDrop.drawAndUpdate();
    if (!dropIsAlive) {
      pixelDrops.remove(i);
    }
  }
  
}

/*
 * Implementation
 */

private void initImage() {
  
  final float pixelSize = width / 128f;
  noStroke();
  
  for (float x = 0f; x < width; x += random(pixelSize * 5)) {
    for (float y = 0f; y < height; y += random(pixelSize * 5)) {
      final color randomColor = getRandomColorWithAlpha(0xFF);
      fill(randomColor);
      rect(x, y, random(pixelSize * 16), random(pixelSize * 16));
    }
  }
}

private void initPixelDrops() {
  pixelDrops = new ArrayList<PixelDrop>();
  for (int i = 0; i < width * 16; i++) {
    final PVector randomPosition = new PVector(random(width), random(height));
    final color dropColor = get((int) randomPosition.x, (int) randomPosition.y);
    final PixelDrop newDrop = new PixelDrop(randomPosition, dropColor);
    pixelDrops.add(newDrop);
  }
}

private color getRandomColorWithAlpha(final int alpha) {
  return color(
    (int) random(255) + 0, 
    (int) random(255) + 0, 
    (int) random(255) + 0, 
    alpha
    );
}