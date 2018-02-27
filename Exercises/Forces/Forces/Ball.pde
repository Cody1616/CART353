class Ball extends Attractor {
  // mode for different friction coefficients depending on location
  int mode = 1;
  float m = 1;
  PVector prevAcc = new PVector(0, 0);

  Ball(int s) {
    super(s);
    f = color(200, 100, 100);
  }
// display
  void display() {
    fill(f);
    ellipse(loc.x, loc.y, size*m, size*m);
  }
  // update, multiply acc by friction, check edges, reset acc
  void update() {
    acc.mult(friction());
    loc.add(acc);
    checkEdges();
    prevAcc = acc;
    acc.mult(0);
    println(size*m);
  }

  // apply force to things
  PVector attract(Thing other) {
    // f is the distance between both objects
    PVector f = PVector.sub(loc, other.getLoc());
    //
    float d = f.mag();
    // norm
    f.normalize();

    if (size*m>other.getSize() && d<25 && !other.getAtt()) {
      other.setAtt();
    }
    float strenght = 0;
    if (other.getAtt()) {
      d = constrain(d, 5, 25);

      strenght = (G *2* size*m*other.size)/(d*d);
    } else {
      strenght = (G * size*m*other.size)/(d*d);
    }
    f.mult(strenght);

    return f;
  }

  // apply force
  void applyForce(PVector force) {
    acc.add(force);
  }

  //
  void changeMode(int m) {
    mode = m;
  }

  // check mode, then return friction
  float friction() {
    float a = 1;
    switch(mode) {
    case 1: 
      a = 1;
      break;
    case 2: 
      a = 0.5;
      break;
    case 3: 
      a = random(0, 2);
      break;
    }
    return a;
  }

  void follow(Thing other) {
    if (other.getAtt()) {
      other.applyForce(prevAcc.div(other.getSize()));
    }
  }



  void setMult(float i) {
    m=i;
  }
  
  float getSizeB(){
  return size*m;
  }



  void keyPressed() {
    if (keyCode == LEFT) {
      applyForce(new PVector(-10, 0));
    }
    if (keyCode == RIGHT) {
      applyForce(new PVector(10, 0));
    }
    if (keyCode == UP) {
      applyForce(new PVector(0, -10));
    }
    if (keyCode == DOWN) {
      applyForce(new PVector(0, 10));
    }
  }

  void keyReleased() {
    if (keyCode == LEFT||keyCode == RIGHT) {
      applyForce(new PVector(0, 0));
    }
    if (keyCode == UP || keyCode == DOWN) {
      applyForce(new PVector(0, 0));
    }
  }
}