/**
 * Constants
 */

/**
 * Values
 */

private Conductor conductor;

private int numOfVerticalLines = 64;

private PImage numberImages[];

private ArrayList<Number> numbers;

private float scale = 8f;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080);
  fullScreen();
  //fullScreen(2);
  background(0);
  loadNumberImages();
  initNumbers();

  conductor = new Conductor(120f);
}

private void loadNumberImages() {
  numberImages = new PImage[] {
    loadImage("0.png"), 
    loadImage("1.png"), 
    loadImage("2.png"), 
    loadImage("3.png"), 
    loadImage("4.png"), 
    loadImage("5.png"), 
    loadImage("6.png"), 
    loadImage("7.png"), 
    loadImage("8.png"), 
    loadImage("9.png"), 
  };
}

void draw() {

  noFill();
  stroke(0xFFAAFFAA);

  if (conductor.isBeatDue(4)) {
    background(0);
    initNumbers();
    if (random(1f) > 0.5f) {
      drawNumbers();
    }
  } else {
    drawNumbers();
  }


  //noStroke();
  //fill(0xFF000000);
  //ellipse(width / 2f, height / 2f, width * 0.2f, height * 0.6f);
}

private void initNumbers() {
  numbers = new ArrayList<Number>();
  for (float x = 0f; x < width; x += (6f * scale) + 1f) {
    for (float y = 0f; y < height; y += (3f * scale) + 2f) {
      final Number newRandomNumber = new Number((int) random(10f), x, y);
      numbers.add(newRandomNumber);
    }
  }
}

private void drawNumbers() {
  for (final Number number : numbers) {
    number.drawImage(scale);
  }
}

public class Number {

  private int value;

  private float x;

  private float y;

  public Number(final int value, final float x, final float y) {
    this.value = value;
    this.x = x;
    this.y = y;
  }

  public void drawImage(final float scale) {
    image(numberImages[value], x, y, 3f * scale, 6f * scale);
  }
}