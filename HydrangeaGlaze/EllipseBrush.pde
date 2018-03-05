class EllipseBrush extends PshapeElement {

  EllipseBrush() {
    super();
  }

  PShape pscreateElement() {

    noStroke();
    fill(0);
    PShape psDp = createShape(ELLIPSE, 0.0, 0.0, 10.0, 10.0);
    return psDp;
  }
}