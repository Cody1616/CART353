class Connector {
  Star s1;
  Star s2;



  Connector(Star ts1, Star ts2) {
    s1 = ts1;
    s2 = ts2;
  }

  void display() {
    stroke(240);

    if (mouseOn()) {
      strokeWeight(4);
    } else {
      strokeWeight(2);
    }
    if (!offScreen()) {
      line(s1.getPosition().x, s1.getPosition().y, s2.getPosition().x, s2.getPosition().y);
    }
  }


  boolean mouseOn() {
    float x1 = s1.getPosition().x;
    float x2 = s2.getPosition().x;
    float y1 = s1.getPosition().y;
    float y2 = s2.getPosition().y;

    float m = (y2 - y1)/(x2 - x1);
    float b = y1-(x1*m);

    if ((mouseY - m*(mouseX)) - b >-5 && (mouseY - m*(mouseX)) - b < 5) {
      return true;
    } else {
      return false;
    }
  }

  boolean offScreen() {

    // if one of the stars is too far from another, dont draw the line

    if (dist(s1.getPosition().x, s1.getPosition().y, s2.getPosition().x, s2.getPosition().y)>1000) {

      return true;
    } else {
      return false;
    }
  }


  PVector getPoint1() {
    return s1.getPosition();
  }

  PVector getPoint2() {
    return s2.getPosition();
  }
}