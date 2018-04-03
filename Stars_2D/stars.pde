class Star {

  PVector p;

  float size;



  Star(PVector tp, float ts) {

    p = tp;
    size = ts;
  }


  void display() {
    if (onStar()) {
      stroke(255);
    } else {
      noStroke();
    }
    fill(255);
    ellipse(p.x, p.y, size, size);
  }

  boolean onStar() {
    if (mouseX > p.x 
      && mouseX < p.x+size
      && mouseY > p.y
      && mouseY < p.y+size) {
      return true;
    } else {
      return false;
    }
  }
  PVector getPosition() {
    return p;
  }

  void move(PVector move) {
    p.add(move);
    checkEdge();
  }

  void checkEdge() {
    if (p.x < areaMin.x) {
      p.x += areaMax.x;
    }
    if (p.y < areaMin.y) {
      p.y += areaMax.y;
    }
    if (p.x > areaMax.x) {
      p.x-= areaMax.x;
    }
    if (p.y> areaMax.y) {
      p.y-= areaMax.y;
    }
  }
}
