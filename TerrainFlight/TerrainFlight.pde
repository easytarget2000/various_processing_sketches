/*
  Based on:
 Processing port of http://www.playfuljs.com/realistic-terrain-in-130-lines/
 by Jerome Herr and Abe Pazos
 */

private Terrain[] terrainSections;

void setup() {
  //size(800, 600, P3D);
  fullScreen(P3D);
  //colorMode(HSB, 1f);
  initTerrainSections();
  
  background(0);
}

void draw() {
  background(0xFFFF00FF);
  drawTerrainSections();
  drawFps();
}

/*
  Implementation
 */

private void initTerrainSections() {
  noStroke();

  terrainSections = new Terrain[4];
  final int sectionSize = int(pow(2f, 8f) + 1f);
  final float sectionRoughness = 0.7f;

  for (int i = 0; i < terrainSections.length; i++) {
    final int sectionYOffset = i * sectionSize;
    terrainSections[i] = new Terrain(sectionSize, sectionYOffset, sectionRoughness);
  }
}

private void drawTerrainSections() {
  for (int i = 0; i < terrainSections.length; i++) {
    final Terrain currentSection = terrainSections[i];
    currentSection.draw_();
  }
}

private void drawFps() {
  fill(0xFF000000);
  rect(8f, 2f, 48f, 16f);
  fill(0xFFFFFFFF);
  text(int(frameRate) + " FPS", 16f, 16f);
}
