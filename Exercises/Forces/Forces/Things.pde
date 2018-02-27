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

  // update
  void update() {
    
    vel.add(acc);
    loc.add(vel);
    
    // because when the thing follows the ball, the velocity accumulates too much and 
    // the object ends up much faster than the ball
    vel.x = constrain(vel.x, -3, 3);
    vel.y = constrain(vel.y, -3, 3);
    checkEdges();
    acc.mult(0);
    println(vel.x, vel.y);
  }
  boolean getAtt() {
    return attracted;
  }
  void setAtt() {
    attracted = true;
  }
  PVector getVel(){
  return vel;
  }

}