private static final color[] COLORS = new color[] {
  0xFF59B0B9, 
  0xFFDEAE00, 
  0xFFB77BB4, 
  0xFFA98D63, 
  0xFFE0773C
};

color getRandomColor() {
  return COLORS[(int) random(COLORS.length)];
}

color getRandomColor(final float x, final float y) {
    return COLORS[(int) (noise(x, y) * COLORS.length)];
}

color getRandomColor(final float x, final float y, int alpha) {
  final color baseColor = getRandomColor(x, y);
  return (baseColor & 0xFFFFFF) | (alpha << 24);
}
