class Planet extends CeOb {
  color c;
  float orbit;
  String name = "???";
  boolean text = false;

  float amp;

  Planet(color tc, PVector tp, float ts, float to, float ta) {
    c = tc;
    p = tp;
    size = ts;
    orbit = to;
    amp = ta;
  }

  void travel() {
    p.x +=orbit;
    p.y += amp*sin((2*PI/(areaMax.x-areaMin.x))*p.x)/50 ;
    p.add(plx);
    p.add(plx);
    checkEdge();
  }

  void display() {


    if (mouseOn() &&!picMode) {
      stroke(255);
      strokeWeight(2);
    } else {
      noStroke();
    }
    fill(c);
    ellipse(p.x, p.y, size, size);
    if (mouseOn() &&!picMode) {
      fill(255);
      text(name, mouseX, mouseY);
    }
    if (text && !picMode) {

      fill(100);
      stroke(255);
      rectMode(CENTER);
      rect(width/2, height/2, 200, 100);
      fill(255);
      textSize(30);
      textAlign(CENTER);
      text(name, width/2, height/2);

      text("please type new name\npress ENTER to save new name", width/2, height/3*2);
    }
  }

  void changeName(String n) {
    name = n;
  }

  void drawPath() {
    //for (int i = int(areaMin.x); i < areaMax.x; i++) {
    //  float j = sin((2*PI/areaMax.x)*i)/50;
    //  stroke(c);
    //  point(i, j);
    //}
  }


  void mousePressed() {
    if (mouseButton == RIGHT && mouseOn()) {
      text = true;
    }
  }

  void keyPressed() {
    if (text) {

      // if backspace, take out some letters
      if (keyCode == BACKSPACE) {
        if (name.length() > 0) {
          name = name.substring(0, name.length()-1);
        }
        // if delete, delete all
      } else if (keyCode == DELETE) {
        name = "";
        // anything else... jot it down
      } else if (keyCode == ENTER) {
        text = false;
      } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT) {
        name = name + key;
      }
    }
  }
}