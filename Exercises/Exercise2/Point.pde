class MovPoint {
  float x;
  float y;
  float vx;
  float vy;
  float ox;
  float oy;
  float t;

  boolean xOver = false;
  boolean yOver = false;

  MovPoint(float tox, float toy, float tt) {
    ox = tox;
    oy = toy;

    x = ox;
    y = oy;
    t = tt;
  }

  void update() {
    if (xOver) {
      vx = -noise(t);
    } else {
      vx = noise(t);
    }
    if (yOver) {
      vy = -noise(t+1);
    } else {
      vy = noise(t+1);
    }

    if (x-30>ox||x+30<ox) {
      vx = -vx;
      xOver = !xOver;
    }
    if (y-30>oy||y+30<oy) {
      vy = -vy;
      yOver = !yOver;
    }


    x += vx;
    y += vy;

    t+=0.01;
  }
}