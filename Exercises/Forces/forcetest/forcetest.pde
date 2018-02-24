Mover[] m = new Mover[10];
Attractor a;

void setup() {
  size(640, 360);
  for (int i = 0; i<m.length; i++) {
    m[i] = new Mover(random(1, 5));
  }
  a = new Attractor();
}

void draw() {
  background(255);
  for (int i = 0; i<m.length; i++) {
    PVector force = a.attract(m[i]);
    m[i].applyForce(force);
    m[i].update();
    m[i].display();
  }
  a.display();
}