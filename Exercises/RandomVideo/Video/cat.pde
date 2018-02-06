class cat {
  float x;
  float y;
  float t;
  float u;
  PImage cat;

  cat(float tx, float ty, float tt, float ut) {
    x = tx;
    y = ty;
    t = tt;
    u = ut;

    cat = loadImage("hovercat.png");
  }

  void update() {
    tint(255, 255);
    image(cat, x+noise(t)*50, y+noise(u)*50);
    t+=0.01;
    u+=0.01;
    
  }
}