class RoundBrush extends PshapeElement {

  RoundBrush() {
    super();
  }

  PShape pscreateElement() {

    stroke(0);
    noFill();
    PShape psDp = createShape(ELLIPSE, 0.0, 0.0, width / 16f, width / 16f);
    return psDp;
  }
}