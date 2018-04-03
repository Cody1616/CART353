class star {
  int r;
  PVector position2D = new PVector(0, 0, 0);
  PVector p = new PVector(0, 0, 0);
  int size;

  boolean hover = false;
  boolean click = false;

  color f = color(255, 255, 255);

  star(int tr) {
    r = tr;
    position2D.x = random(-TWO_PI, TWO_PI);
    position2D.y = random(-HALF_PI, HALF_PI);

    p.x = r*sin(position2D.x)*cos(position2D.y);
    p.y = r*sin(position2D.x)*sin(position2D.y);
    p.z = r*cos(position2D.x);
    size = int(random(10, 20));
  }

  void display() {
    if (starmode) {
      pushMatrix();
      translate(p.x, p.y, p.z);
      fill(255, 255, 255);
      noStroke();
      ellipse(0, 0, size, size);
      popMatrix();
    }
    else {
      float x = map(position2D.x, -TWO_PI, TWO_PI, 0, width);
      float y = map(position2D.x, -HALF_PI, HALF_PI, 0, height);
      fill(255, 255, 255);
      noStroke();
      ellipse(x, y, size, size);
    
    
    }
  }
  void mouseDragged() {
    stroke(20);
    line(position2D.x, position2D.y, mouseX, mouseY);
  }

  PVector getPosition() {
    return position2D;
  }
}