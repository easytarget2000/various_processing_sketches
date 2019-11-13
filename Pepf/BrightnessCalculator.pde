public class LuminanceCalculator {
  
  public float valueRatio = 255f;
  public int imageStepSize = 1;

  public float imageLuminance(final PImage image) {
    float brightnessSum = 0;
    int pixelCounter = 0;
    for (int x = 0; x < image.width; x += imageStepSize) {
      for (int y = 0; y < image.height; y += imageStepSize) {
        final color color_ = image.pixels[x + (y * image.width)];
        brightnessSum += simpleLuminance(color_);
        pixelCounter += imageStepSize;
      }
    }

    return (brightnessSum * (float) imageStepSize) / (float) pixelCounter;
  }
  
  public float simpleLuminance(final color color_) {
    return (red(color_) + green(color_) + blue(color_)) / (3f * valueRatio);
  }
  
  public float luminance(final color color_) {
    return ((red(color_) * 0.3f) + (green(color_) * 0.59f) + (blue(color_) * 0.11f)) / valueRatio;
  }
  
}
