class Planet {
  color c;
  PVector p;
  float size;
  float orbit;
  String name = "???";

  Planet(color tc, PVector tp, float ts, float to) {
    c = tc;
    p = tp;
    size = ts;
    orbit = to;
  }

  void travel() {
    p.x +=orbit*100;
    p.y += sin(p.x/150)/2;
    p.add(plx);
    //orbit+=PI/100;
    loop();
  }

  void display() {
    if (mouseOn()) {
      stroke(2);
    } else {
      noStroke();
    }
    fill(c);
    ellipse(p.x, p.y, size, size);
    if (mouseOn()) {
      fill(255);
      text(name, mouseX, mouseY);
    }
  }
  void changeName(String n) {
    name = n;
  }


  void loop() {

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

  boolean mouseOn() {
    if (mouseX > p.x -size/2
      && mouseX < p.x+size/2
      && mouseY > p.y - size/2
      && mouseY < p.y+size/2) {
      return true;
    } else {
      return false;
    }
  }
}