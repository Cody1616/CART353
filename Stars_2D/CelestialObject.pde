// celestial objects - planets and stars

class CeOb {
  // position and size
  PVector p;
  float size;

  CeOb() {
  }
  // check if mouse is on object (or close enough)
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
  
  // position
  PVector getPosition() {
    return p;
  }
// check if on edge. if soo, loop around
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

  void convert() {
    // if not in map mode, map back to normal
    if (!mapMode) {
      p.x = map(p.x, 0, width, areaMin.x, areaMax.x);
      p.y = map(p.y, 0, height, areaMin.y, areaMax.y);
      size = size*2;
      return;
    }
    
    // if in map mode, map to canvas size
    else if(mapMode){
      p.x = map(p.x, areaMin.x, areaMax.x, 0, width);
      p.y= map(p.y, areaMin.y, areaMax.y, 0, height);
      size = size/2;
     
    }
  }
}