class CeOb {
  PVector p;
  float size;

  CeOb() {
  }



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

  void mapToPic() {
    if (!picMode) {
      p.x = map(p.x, 0, width, areaMin.x, areaMax.x);
      p.y = map(p.y, 0, height, areaMin.y, areaMax.y);
      size = size*2;
      return;
    }
    else if(picMode){
      p.x = map(p.x, areaMin.x, areaMax.x, 0, width);
      p.y= map(p.y, areaMin.y, areaMax.y, 0, height);
      size = size/2;
      
      
    
    
    }
  }
}