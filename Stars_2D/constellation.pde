class Constellation {
  ArrayList<Connector> lines = new ArrayList<Connector>();
  String name;

  Constellation() {
  }

  void addLine(Connector c) {
    lines.add(c);
  }

  void setName(String s) {
    name = s;
  }

  void display() {
    for (int i = 0; i<lines.size(); i++) {

      Connector c = lines.get(i);
      if (mouse()) {
        println("EXCUSEYOU");
        stroke(200);
        strokeWeight(10);
        line(c.getPoint1().x, c.getPoint1().y, c.getPoint2().x, c.getPoint2().y);
      }
      c.display();
    }
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
}
