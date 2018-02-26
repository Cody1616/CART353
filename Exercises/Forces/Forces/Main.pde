class Main extends Attractor {
  int mode = 1;

  Main(int s) {
    super(s);
  }



  PVector attract(Thing other) {
    //float d = dist(loc.x, loc.y, other.getLoc().x, other.getLoc().y);
    //if (d<100&&size>other.getSize()) {
    //  PVector f = other.getAcc().mult(other.getSize());
    //  f.div(d);
    //  other.attract(f);
    //}
    PVector f = PVector.sub(loc, other.getLoc());
    float d = f.mag();
    f.normalize();
    float strenght = (size*other.size)/(d*d);
    f.mult(strenght);
    if (d<25) {
      d = constrain(d, 5, 25);
    }
    return f;
  }
  void changeMode(int m) {
    mode = m;
  }

  PVector move() {
    PVector a = new PVector();
    switch(mode) {
    case 1: 
      a = new PVector(10, 10);
      break;
    case 2: 
      a = new PVector(5, 5);
      break;
    case 3: 
      a = new PVector(10, floor(random(5, 15)));
      break;
    }
    return a;
  }



  void keyPressed() {
    if (keyCode == LEFT) {
      acc.x = -move().x;
    }
    if (keyCode == RIGHT) {
      acc.x = move().x;
    }
    if (keyCode == UP) {
      acc.y = -move().y;
    }
    if (keyCode == DOWN) {
      acc.y = move().y;
    }
  }

  void keyReleased() {
    if (keyCode == LEFT||keyCode == RIGHT) {
      acc.x = 0;
      vel.x = 0;
    }
    if (keyCode == UP || keyCode == DOWN) {
      acc.y = 0;
      vel.y = 0;
    }
  }
}