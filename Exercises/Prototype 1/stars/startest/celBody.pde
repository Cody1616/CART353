class celBody {
  // for celestial body

  PVector p = new PVector(200, 0, 200);
  PVector pivot;
  float angle;
  int dist;
  int size;
  color texture;
  float speed;

  celBody(PVector tp, int td, int ts, color tc, float s) {
    pivot = tp;
    dist = td;
    size = ts;
    texture = tc;
    speed = s;
    p = new PVector(dist, 0, dist);
  }


  void display() {
    pushMatrix();
    translate(p.x, p.y, p.z);
    noStroke();
    fill(texture);
    shininess(300);
    specular(255, 255, 255);
    emissive(0, 0, 0);
    sphere(size);
    popMatrix();
  }

  void update() {
    angle+=(speed);
    p = new PVector(pivot.x+sin(angle)*dist, 0.0, pivot.z+cos(angle)*dist);
  }
}
