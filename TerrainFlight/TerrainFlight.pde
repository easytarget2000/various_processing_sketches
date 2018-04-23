/*
  Based on:
 Processing port of http://www.playfuljs.com/realistic-terrain-in-130-lines/
 by Jerome Herr and Abe Pazos
 */

private Terrain[] terrainSections;

void setup() {
  //size(800, 600, P3D);
  fullScreen(P3D);
  initTerrainSections();
}

void draw() {
  background(0);
  drawTerrainSections();
}

/*
  Implementation
 */

private void initTerrainSections() {
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
    currentSection.draw_(millis() / 50);
  }
}
