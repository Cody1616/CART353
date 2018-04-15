class Planet {
  color c;
  PVector p;
  float size;
  float orbit;
  String name = "???";
  boolean text = false;

  Planet(color tc, PVector tp, float ts, float to) {
    c = tc;
    p = tp;
    size = ts;
    orbit = to;
  }

  void travel() {
    p.x +=orbit;
    p.y += sin((2*PI/(areaMax.x-areaMin.x))*p.x)/50;
    p.add(plx);
    p.add(plx);
    //orbit+=PI/100;
    loop();
  }

  void display() {

    if (mouseOn()) {
      stroke(255);
      strokeWeight(2);
    } else {
      noStroke();
    }
    fill(c);
    ellipse(p.x, p.y, size, size);
    if (mouseOn()) {
      fill(255);
      text(name, mouseX, mouseY);
    }
    if (text) {

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


  void loop() {


    if (p.x < areaMin.x) {
      p.x += areaMax.x-areaMin.x;
    }
    if (p.y < areaMin.y) {
      p.y += areaMax.y-areaMin.y;
    }
    if (p.x > areaMax.x) {
      p.x-= areaMax.x-areaMin.x;
    }
    if (p.y> areaMax.y) {
      p.y-= areaMax.y-areaMin.y;
    }
  }

  boolean mouseOn() {
    if (mouseX > p.x -size/2
      && mouseX < p.x+size/2
      && mouseY > p.y - size/2
      && mouseY < p.y+size/2) {
      return true;
    } else {
      return false;
    }
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