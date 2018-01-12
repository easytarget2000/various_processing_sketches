class EyeElement extends FountainElement {

  public PShape pscreateElement() {

    noStroke();
    PShape psDp = createShape(GROUP);

    PShape psCh;
    for (int i = 0; i < 6; ++i) {
      float rad = 5 + pow(i, 3)/2;
      psCh = createShape(ELLIPSE, 0, 0, rad, rad);
      psCh.setFill(color(random(0, 360), 50, 20, 100));
      psCh.rotateX(radians(i * 30));
      psDp.addChild(psCh);
    }

    psCh = createShape(ELLIPSE, 0, 0, 10, 65);
    //psCh.setFill(color(random(0, 360), 100, 80, 100));
    psCh.rotateX(radians(150));
    psDp.addChild(psCh);

    return psDp;

  }

}