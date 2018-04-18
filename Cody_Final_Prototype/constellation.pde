class Constellation {
  // list of connectors
  ArrayList<Connector> lines = new ArrayList<Connector>();
  String name;
  // whether text is being written down
  boolean text = false;

  Constellation() {
  }

  void addLine(Connector c) {
    lines.add(c);
  }

  void display() {
    for (int i = 0; i<lines.size(); i++) {

      Connector c = lines.get(i);
      if (drawingMode) {
        stroke(0);
      } else {
        stroke(0, 0, 100);
      }
      if (mapMode) {
        strokeWeight(20);
      } else {
        strokeWeight(50);
      }
      // if the points are not too far from one another, draw the line
      if (dist(c.getPoint1().x, c.getPoint1().y, c.getPoint2().x, c.getPoint2().y) < 1000) {
        line(c.getPoint1().x, c.getPoint1().y, c.getPoint2().x, c.getPoint2().y);
      }
    }
    for (int i = 0; i<lines.size(); i++) {
      Connector c = lines.get(i);
      // draw a border around the constellation
      if (dist(c.getPoint1().x, c.getPoint1().y, c.getPoint2().x, c.getPoint2().y) < 1000) {
        if (mouse()) {
          stroke(200);
          strokeWeight(10);
          line(c.getPoint1().x, c.getPoint1().y, c.getPoint2().x, c.getPoint2().y);
          fill(255);
          text(name, mouseX, mouseY);
        }
      }
      // display the connector over the blue "border"
      c.display();
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



  void setName(String s) {
    name = s;
  }


  boolean mouse() {
    for (int i = 0; i<lines.size(); i++) {
      Connector c = lines.get(i);
      if (c.mouseOn()) {
        return true;
      }
    }
    return false;
  }


  void mousePressed() {
    if (mouseButton == RIGHT && mouse()) {
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
      } else if (keyCode == ENTER) {
        text = false;
      } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT) {
        name = name + key;
      }
    }
  }
}