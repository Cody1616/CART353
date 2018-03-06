class star {
  int r;
  PVector p = new PVector(0, 0, 0);
  PVector place = new PVector(0, 0, 0);
  int size;

  boolean hover = false;
  boolean click = false;

  color f = color(255);

  star(int tr) {
    r = tr;
    p.x = random(-TWO_PI, TWO_PI);
    p.y = random(-HALF_PI, HALF_PI);

    place.x = r*sin(p.x)*cos(p.y);
    place.y = r*sin(p.x)*sin(p.y);
    place.z = r*cos(p.x);
    size = int(random(10, 20));
  }

  void display() {
    pushMatrix();
    translate(place.x, place.y, place.z);
    fill(f);
    noStroke();
    //shininess(500);
    sphere(size);
    popMatrix();


    //fill(255);
    //stroke(20);
    //line(place.x, place.y, place.z, 0, 0, 0);
  }
  void changeColor() {
    f = color(
      int(random(0, 255)), 
      int(random(0, 255)), 
      int(random(0, 255))
      );
  }

  void mouseClicked() {
  }

  void mouseDragged() {
    stroke(20);
    line(p.x, p.y, mouseX, mouseY);
  }

  PVector getPosition() {
    return p;
  }
}