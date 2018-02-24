class Main extends Attractor {


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
      if(d<25){
      d = constrain(d, 5, 25);
      }
      return f;
      
    
  }

  void keyPressed() {
    if (keyCode == LEFT) {
      acc.x = -10;
    }
    if (keyCode == RIGHT) {
      acc.x = 10;
    }
    if (keyCode == UP) {
      acc.y = -10;
    }
    if (keyCode == DOWN) {
      acc.y = 10;
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