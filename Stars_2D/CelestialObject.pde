class CeOb {
  PVector p;
  float size;
  
  CeOb(){}
  
  
  
  boolean mouseOn() {
    if (mouseX > p.x -size
      && mouseX < p.x+size
      && mouseY > p.y - size
      && mouseY < p.y+size) {
      return true;
    } else {
      return false;
    }
  }
  PVector getPosition() {
    return p;
  }
  
  void checkEdge() {
    if (p.x < areaMin.x) {
      p.x += areaMax.x-areaMin.x;
    }
    if (p.y < areaMin.y) {
      p.y += areaMax.y-areaMin.y;
    }
    if (p.x > areaMax.x) {
      p.x-= areaMax.x-areaMin.x;
    }
    if (p.y> areaMax.y) {
      p.y-= areaMax.y-areaMin.y;
    }
  }
  
  
}