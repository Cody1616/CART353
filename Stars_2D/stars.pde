class Star {

  PVector p;

  float size;

  float aura;
  float angle;

  String name;

  Star(PVector tp, float ts) {

    p = tp;
    size = ts;
    angle = random(PI/10, PI);
    aura = 0;
  }
  void changeName(String n) {
    name = n;
  }


  void display() {
    noStroke();
    fill(255);
    ellipseMode(CENTER);
    ellipse(p.x, p.y, size, size);
    aura=(sin(angle)+size*2);
    if (onStar()) {
      fill(255);
    } else {
      fill(255, 100);
    }
    ellipse(p.x, p.y, aura, aura);
    angle+=PI/60;
  }

  boolean onStar() {
    if (mouseX > p.x -size/2
      && mouseX < p.x+size/2
      && mouseY > p.y - size/2
      && mouseY < p.y+size/2) {
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