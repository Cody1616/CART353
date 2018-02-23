class Attractor {
  PVector acc = new PVector(0, 0);
  PVector vel = new PVector(0, 0);
  PVector loc;

  Attractor() {
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

  void display() {
    rect(loc.x, loc.y, 10, 10);
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
    if(loc.y>height){
    loc.y = 0;
    }
    if(loc.y<0){
    loc.y = height;
    }
  }
}