public class ScreenClearer {

  private final ScreenClearerMode mode;

  private final color color_;

  private final int fadeAlpha;

  public ScreenClearer(final ScreenClearerMode mode_, final color color__) {
    this(mode_, color__, 100);
  }

  public ScreenClearer(final ScreenClearerMode mode_, final color color__, final int fadeAlpha_) {
    mode = mode_;
    color_ = color__;
    fadeAlpha = fadeAlpha_;
  }

  public void applyMode() {
    switch (mode) {
    case FULL:
      performFullClear();
      return;
    case FADE:
      noStroke();
      fill(getFadeColor());
      rect(0f, 0f, width, height);
      return;
    default:
      return;
    }
  }

  public void performFullClear() {
    background(color_);
  }

  public color getFadeColor() {
    return (color_ & 0xffffff) | (fadeAlpha << 24);
  }
}

public enum ScreenClearerMode {
  FULL, FADE, NONE
}
