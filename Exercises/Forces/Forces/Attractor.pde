class Attractor {
  // acceleration, location, size
  PVector acc = new PVector(0, 0);
  PVector loc;
  int size;

  Attractor(int tsize) {
    // pass size
    size = tsize;
    // spawn at random place on canvas
    loc = new PVector(random(0, width), random(0, height));
  }

  // functions to pass variables
  PVector getAcc() {
    return acc;
  }
  PVector getLoc() {
    return loc;
  }
  int getSize() {
    return size;
  }


  // display
  void display() {
    ellipse(loc.x, loc.y, size, size);
  }
  
  // check edges and wrap around
  void checkEdges() {
    if (loc.x>width) {
      loc.x = 0;
    }
    if (loc.x<0) {
      loc.x = width;
    }
    if (loc.y>height) {
      loc.y = 0;
    }
    if (loc.y<0) {
      loc.y = height;
    }
  }
}