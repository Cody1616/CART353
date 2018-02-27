class Thing extends Attractor {
  // velocity
  PVector vel = new PVector(0, 0);

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
  
  // update
  void update() {
    vel.add(acc);
    loc.add(vel);
    checkEdges();
    acc.mult(0);
  }
  
}