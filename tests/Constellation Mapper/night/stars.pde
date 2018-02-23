class Star {
  float x;
  float y;
  float z;
  int size;
  boolean selected;
  int bright;
  float i =0;
  boolean dull = false;
  Star(int tx, int ty, int tz,
  int ts, int tb) {

    x = tx;
    y = ty;
    size = ts;
    bright = tb;
    z = tz;
  }


  void display() {
    bright();
    checkSelected();
    if (selected) {
      stroke(255);
    } else {
      noStroke();
    }
    fill(bright);
    translate(x, y, z);
    sphere(size);
    orbit();
  }

  void checkSelected() {
    if (x < mouseX && x+size > mouseX && y < mouseY && y+size > mouseY) {
      selected = true;
    } else {
      selected = false;
    }
  }

  void bright() {
    if (dull) {
      bright--;
    } else {
      bright++;
    }
    if (bright>=255) {
      dull = true;
    }
    if (bright<150) {
      dull = false;
    }
  }


  void orbit() {
    x += sin(radians(i))*300;
    z += cos(radians(i))*300;
    i+=0.5;
    if(i>=360){
    i = 0;
    }
  }
}