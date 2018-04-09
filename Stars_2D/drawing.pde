class drawing {

  ArrayList<PVector> sketch = new ArrayList<PVector>();

  drawing() {
  }


  void move() {
    for (int i = 0; i < sketch.size(); i++) {
      PVector p = sketch.get(i);
      p.add(plx.x, plx.y);
      loop(p);
    }
  }
  void display() {
    for (int i = 1; i<sketch.size(); i++) {
      PVector v1 = sketch.get(i);
      PVector v2 = sketch.get(i-1);
      if (dist(v1.x, v1.y, v2.x, v2.y)<1000) {
        strokeWeight(1);
        stroke(255);
        line(v1.x, v1.y, v2.x, v2.y);
      }
    }
  }

  void loop(PVector p) {
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