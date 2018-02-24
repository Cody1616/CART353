class Thing extends Attractor {

  Thing(int s) {
    super(s);
    
    acc.add(random(-1, 1), random(-1, 1));
  }

  void applyF(PVector force) {
    acc.add(force);
  }
}