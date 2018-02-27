class Ball extends Attractor {
  // mode for different friction coefficients depending on location
  int mode = 1;

  Ball(int s) {
    super(s);
  }

  // update, multiply acc by friction, check edges, reset acc
  void update() {
    acc.mult(friction());
    loc.add(acc);
    checkEdges();
    acc.mult(0);
  }

  // apply force to things
  PVector attract(Thing other) {
    //float d = dist(loc.x, loc.y, other.getLoc().x, other.getLoc().y);
    //if (d<100&&size>other.getSize()) {
    //  PVector f = other.getAcc().mult(other.getSize());
    //  f.div(d);
    //  other.attract(f);
    //}
    // f is the distance between both objects
    PVector f = PVector.sub(loc, other.getLoc());
    // magnitude
    float d = f.mag();
    // norm
    f.normalize();
    float strenght = (size*other.size)/(d*d);
    f.mult(strenght);
    if (d<25) {
      d = constrain(d, 5, 25);
    }
    return f;
  }

  // apply force
  void applyForce(PVector force) {
    acc.add(force);
  }

  //
  void changeMode(int m) {
    mode = m;
  }

  // check mode, then return friction
  float friction() {
    float a = 1;
    switch(mode) {
    case 1: 
      a = 1;
      break;
    case 2: 
      a = 0.5;
      break;
    case 3: 
      a = random(0, 2);
      break;
    }
    return a;
  }



  void keyPressed() {
    if (keyCode == LEFT) {
      applyForce(new PVector(-10, 0));
    }
    if (keyCode == RIGHT) {
      applyForce(new PVector(10, 0));
    }
    if (keyCode == UP) {
      applyForce(new PVector(0, -10));
    }
    if (keyCode == DOWN) {
      applyForce(new PVector(0, 10));
    }
  }

  void keyReleased() {
    if (keyCode == LEFT||keyCode == RIGHT) {
      applyForce(new PVector(0, 0));
    }
    if (keyCode == UP || keyCode == DOWN) {
      applyForce(new PVector(0, 0));
    }
  }
}