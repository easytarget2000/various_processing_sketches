abstract class FountainElement {

  PShape anElement;
  float elementColor, elementSaturation, elementBright, elementAlpha;
  
  FountainElement() {
    anElement = pscreateElement();
    elementColor = 0;
    elementSaturation = 0;
    elementBright = 0;
    elementAlpha = 0;
  }

  abstract PShape pscreateElement();

  void setElementFill(float pcolor, float psaturation, float pbright, float palpha) {
    elementColor = pcolor;
    elementSaturation = psaturation;
    elementBright = pbright;
    elementAlpha = palpha;
    resetColor();
  }

  void resetColor() {
    anElement.setFill(color(elementColor, elementSaturation, elementBright, elementAlpha));
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
    anElement.resetMatrix();
  }

  void changeSize(float scaleX, float scaleY, float scaleZ) {
    anElement.scale(scaleX, scaleY, scaleZ);
  }

  void rotate(float radX, float radY, float radZ) {
    anElement.rotateX(radX);
    anElement.rotateY(radY);
    anElement.rotateZ(radZ);
  }

  void show() {
    shape(anElement);
  }

}