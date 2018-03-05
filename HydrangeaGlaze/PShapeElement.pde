/* ---------------------------------------------------------------------- */
abstract class PshapeElement {

  private PShape shape;
  private float elementColor, elementSaturation, elementBright, elementAlpha;

  PshapeElement() {
    shape = pscreateElement();
    elementColor = 0;
    elementSaturation = 0;
    elementBright = 0;
    elementAlpha = 0;
  }

  abstract PShape pscreateElement();
  
  void setColor(color color_) {
    shape.setFill(color_);
    shape.setStroke(color_);
  }

  void setColor(float pcolor, float psaturation, float pbright, float palpha) {
    elementColor = pcolor;
    elementSaturation = psaturation;
    elementBright = pbright;
    elementAlpha = palpha;
    resetColor();
  }

  void resetColor() {
    shape.setFill(color(elementColor, elementSaturation, elementBright, elementAlpha));
    shape.setStroke(color(elementColor, elementSaturation, elementBright, elementAlpha));
  }

  void changeColor(float scolor) {
    elementColor = scolor;
    resetColor();
  }

  void changeBright(float sbright) {
    elementBright = sbright;
    resetColor();
  }

  void resetSize() {
    shape.resetMatrix();
  }

  void changeSize(float scaleX, float scaleY, float scaleZ) {
    shape.scale(scaleX, scaleY, scaleZ);
  }

  void rotate(float radX, float radY, float radZ) {
    shape.rotateX(radX);
    shape.rotateY(radY);
    shape.rotateZ(radZ);
  }

  void drawShape() {
    shape(shape);
  }
}