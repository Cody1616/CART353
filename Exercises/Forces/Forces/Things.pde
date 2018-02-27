class Thing extends Attractor {
  // velocity

  boolean attracted = false;
  Thing(int s) {
    super(s);
    // start with random acc
    acc.add(random(-1, 1), random(-1, 1));
  }

  // apply force depending on size
  void applyForce(PVector force) {
    PVector f = force.div(size);
    acc.add(f);
  }
  // display
  void display() {
    fill(f, 150);
    ellipse(loc.x, loc.y, size, size);
  }
  // update
  void update() {
    if (attracted) {
      f = color(100, 100, 100);
    } else {
      f = color(150, 150, 150);
    }
    vel.add(acc);
    loc.add(vel);

    // because when the thing follows the ball, the velocity accumulates too much and 
    // the object ends up much faster than the ball
    vel.x = constrain(vel.x, -3, 3);
    vel.y = constrain(vel.y, -3, 3);
    checkEdges();
    acc.mult(0);
  }
  boolean getAtt() {
    return attracted;
  }
  void setAtt() {
    attracted = true;
  }
  PVector getVel() {
    return vel;
  }
}