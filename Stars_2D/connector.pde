class Connector {
  Star s1;
  Star s2;



  Connector(Star ts1, Star ts2) {
    s1 = ts1;
    s2 = ts2;
  }

  void display() {
    stroke(255);
    strokeWeight(5);
    line(s1.getPosition().x, s1.getPosition().y, s2.getPosition().x, s2.getPosition().y);
  }
}
