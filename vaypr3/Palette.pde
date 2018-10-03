public class Palette {
  
  public Palette() {
  }
  
  public color getRandomColorWithAlpha(int alpha) {
    return (getRandomColor() & 0xFFFFFF) | (alpha << 24);
  }

  public color getRandomColor() {
    switch ((int) random(6f)) {
    case 0:
      return 0xFFFF00FF;
    case 1:
      return 0xFFFFFF00;
    case 2:
      return 0xFFFF0000;
    case 3:
      return 0xFF0000FF;
    case 4:
      return 0xFF00FF00;
    default:
      return 0xFF00FFFF;
    }
  }
}
