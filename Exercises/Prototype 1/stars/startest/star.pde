class star {
  
  int r; //radius of the star system.
  PVector position2D = new PVector(0, 0, 0); // position in 2d world (for star map)
  PVector p = new PVector(0, 0, 0); // position in 3D
  int size; // star size

//  boolean hover = false;
//  boolean click = false;

  //color f = color(255, 255, 255);

  star(int tr) {
    // pass on radius
    r = tr;
    
    // randomly place stars around in 2d
    position2D.x = random(-TWO_PI, TWO_PI);
    position2D.y = random(-HALF_PI, HALF_PI);
    
    // and in 3d
    p.x = r*sin(position2D.x)*cos(position2D.y);
    p.y = r*sin(position2D.x)*sin(position2D.y);
    p.z = r*cos(position2D.x);
    
    // set random size
    size = int(random(10, 20));
  }

  void display() {
    // if in star world mode, display in 3d coordinates
    if (starmode) {
      pushMatrix();
      translate(p.x, p.y, p.z);
      rotateX(position2D.y);
      rotateY(position2D.x);
      //rotateZ(position2D.z);
      fill(255);
      noStroke();
      ellipse(0, 0, size, size);
      popMatrix();
    }
    else {
      // place stars on 2d plane
      float x = map(position2D.x, -TWO_PI, TWO_PI, 0, width);
      float y = map(position2D.x, -HALF_PI, HALF_PI, 0, height);
      fill(255);
      noStroke();
      ellipse(x, y, size, size);
    
    
    }
  }

  PVector getPosition() {
    return p;
  }
}
