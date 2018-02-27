class Attractor {
  // acceleration, location, size
  PVector acc = new PVector(0, 0);
  PVector loc;
  int size;
  float G = 0.4;
  PVector vel = new PVector(0, 0);
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
    if (loc.x > width) {
      loc.x = width;
      vel.x *= -1;
    } else if (loc.x < 0) {
      vel.x *= -1;
      loc.x = 0;
    }

    if (loc.y > height) {
      vel.y *= -1;
      loc.y = height;
    }
    else if(loc.y < 0){
    vel.y *= -1;
      loc.y = 0;
    }
  }
}