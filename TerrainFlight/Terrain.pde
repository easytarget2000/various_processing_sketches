 //<>//
class Terrain {

  private final int size;

  private final int max;

  private final float[] heightMap;

  private final float roughness;

  private final int yOffset;

  private final color waterColor = color(0x30660000);

  private final float waterHeight;

  private final float x0 = width / 2f;

  private final float y0 = height / 2f;

  private final float chunkWidth;

  Terrain(final int size_, final int yOffset_, final float roughness_) {
    size = size_;
    yOffset = yOffset_;
    max = size - 1;
    heightMap = new float[size * size];
    chunkWidth = width / size * 2f;
    waterHeight = size * 0.2f;

    roughness = roughness_;
    setHeightMapValue(0, 0, max);
    setHeightMapValue(max, 0, max / 2);
    setHeightMapValue(max, max, 0);
    setHeightMapValue(0, max, max / 2);

    divide(max);
  }

  private float getHeightMapValue(int x, int y) {
    if (x < 0 || x > max || y < 0 || y > max) {
      return -1;
    }
    return heightMap[x + (size * y)];
  }

  private void setHeightMapValue(int x, int y, float value) {
    heightMap[x + (size * y)] = value;
  }

  private void divide(int size) {
    final int half = size / 2;

    final float scale = roughness * size;
    if (half < 1) {
      return;
    }

    for (int y = half; y < max; y += size) {
      for (int x = half; x < max; x += size) {
        square(x, y, half, random(-scale, scale));
      }
    }

    for (int y = 0; y <= max; y += half) {
      for (int x = (y + half) % size; x <= max; x += size) {
        diamond(x, y, half, random(-scale, scale));
      }
    }

    divide(size / 2);
  }

  private float average(float[] values) {
    int valid = 0;
    float total = 0;
    for (int i=0; i<values.length; i++) {
      if (values[i] != -1) {
        valid++;
        total += values[i];
      }
    }
    return valid == 0 ? 0 : total / valid;
  }

  private void square(int x, int y, int size, float offset) {
    float ave = average(new float[] {
      getHeightMapValue(x - size, y - size), // upper left
      getHeightMapValue(x + size, y - size), // upper right
      getHeightMapValue(x + size, y + size), // lower right
      getHeightMapValue(x - size, y + size)  // lower left
      }
      );
    setHeightMapValue(x, y, ave + offset);
  }

  private void diamond(int x, int y, int size, float offset) {
    float ave = average(new float[] {
      getHeightMapValue(x, y - size), // top
      getHeightMapValue(x + size, y), // right
      getHeightMapValue(x, y + size), // bottom
      getHeightMapValue(x - size, y)  // left
      }
      );
    setHeightMapValue(x, y, ave + offset);
  }

  public void draw_() {

    for (int y = 0; y < size; y++) {
      //final int offsetY = y + yOffset;
      for (int x = 0; x < size; x++) {
        final float terrainHeight   = getHeightMapValue(x, y);
        final PVector terrainTop    = project(x, y, terrainHeight);
        final PVector terrainBottom = project(x + 1f, y, 0f);

        final float nextTerrainHeight = getHeightMapValue(x + 1, y);
        final color terrainColor = brightnessAtPos(x, y, nextTerrainHeight - terrainHeight);
        colorRect(terrainTop, terrainBottom, terrainColor);

        final PVector water = project(x, y, waterHeight);
        colorRect(water, terrainBottom, waterColor);
      }
    }
  }
  private void colorRect(final PVector top, final PVector bottom, final color c) {
    //if (bottom.y < top.y) {
    //  return;
    //}
    //stroke(0xFF000000);
    //fill(0xFFFF00FF);
    fill(c);
    rect(top.x, top.y, bottom.x - top.x, bottom.y - top.y);
  }

  private color brightnessAtPos(float x, float y, float slope) {
    if (y == max || x == max) {
      return color(0f);
    }
    return color((slope * 50f) + 128f);
  }

  private PVector project(float flatX, float flatY, float flatZ) {
    //PVector point = iso(flatX, flatY);
    //float x0 = width * 0.5;
    //float y0 = height * 0.2;

    flatY += (millis() / 128f);

    final float cameraAltitude = 16f;

    final float z = (size * 0.5f) - flatZ * 4f + (flatY * cameraAltitude);
    final float x = (flatX - size * 0.5f) * chunkWidth;
    final float y = (size - flatY) / 256f + 2f;

    return new PVector(
      x0 + x/y, 
      y0 + z/y  + yOffset
      );
  }
}
