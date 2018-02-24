class Attractor {
  PVector acc = new PVector(0, 0);
  PVector vel = new PVector(0, 0);
  PVector loc;
  int size;

  Attractor(int tsize) {
    size = tsize;
    loc = new PVector(random(0, width), random(0, height));
  }



  PVector getAcc() {
    return acc;
  }

  PVector getVel() {
    return vel;
  }

  PVector getLoc() {
    return loc;
  }

  int getSize() {
    return size;
  }

  void display() {
    ellipse(loc.x, loc.y, size, size);
  }

  void update() {
    vel.add(acc);
    loc.add(vel);
    vel.x = constrain(vel.x, -10, 10);
    vel.y = constrain(vel.y, -10, 10);
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