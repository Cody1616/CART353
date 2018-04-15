class Star extends CeOb{

  float aura;
  float angle;


  Star(PVector tp, float ts) {

    p = tp;
    size = ts;
    angle = random(PI/10, PI);
    aura = 0;
  }


  void display() {
    noStroke();
    fill(255);
    ellipseMode(CENTER);
    ellipse(p.x, p.y, size, size);
    aura=(sin(angle)+size*2);
    if (mouseOn()) {
      fill(255);
    } else {
      fill(255, 100);
    }
    ellipse(p.x, p.y, aura, aura);
    angle+=PI/60;
  }
  void move(PVector move) {
    p.add(move);
    checkEdge();
  }

  
}