class cat {
  float x;
  float y;
  float t;
  float u;
  PImage cat;
  PVector p = new PVector(0, 0);

  cat(float tx, float ty, float tt, float ut) {
    x = tx;
    y = ty;
    t = tt;
    u = ut;

    cat = loadImage("hovercat.png");
  }

  void update() {
    tint(255, 255);
    p.x = map(noise(t), 0, 1, x, x+100);
    p.y = map(noise(u), 0, 1, y, y+100);
    image(cat, p.x, p.y);
    t+=0.01;
    u+=0.01;
    
  }
}