class Thing extends Attractor {
  PVector vel = new PVector(0, 0);

  Thing(int s) {
    super(s);

    acc.add(random(-1, 1), random(-1, 1));
  }

  void applyForce(PVector force) {
    PVector f = force.div(size);
    acc.add(f);
  }
  void update() {
    vel.add(acc);
    loc.add(vel);
    //vel.x = constrain(vel.x, -10, 10);
    //vel.y = constrain(vel.y, -10, 10);
    checkEdges();
    acc.mult(0);
  }
  
}