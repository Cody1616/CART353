class star() {
  PVector p;
  int size;

  star(PVector tp) {
    p = tp;
  }

  void display() {
    pushMatrix();
    translate(p.x, p.y, p.z);
    sphere(size);
    popMatrix();
  }

  void mouseHover() {
    // put ray stuff here
    pushMatrix();
    translate(p.x, p.y, p.z);
    fill(255, 150);
    sphere(size+10);
    popMatrix();
    
  }

  void mouseClicked() {
    // if ray stuff, etc
  }

  void mouseDragged() {
    stroke(20);
    line(p.x, p.y, mouseX, mouseY);
  }

  void getPosition() {
    return p;
  }
}