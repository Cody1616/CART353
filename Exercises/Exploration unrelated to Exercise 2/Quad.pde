class Quad {
  MovPoint p1;
  MovPoint p2;
  MovPoint p3;
  MovPoint p4;
  float t = 0;
  color col = color(255);
  Quad(MovPoint t1, MovPoint t2, MovPoint t3, MovPoint t4) {

    p1 = new MovPoint(t1.x, t1.y, t1.t);
    p2 = new MovPoint(t2.x, t2.y, t2.t);
    p3 = new MovPoint(t3.x, t3.y, t3.t);
    p4 = new MovPoint(t4.x, t4.y, t4.t);

  }

  void drawQuad() {
    //fill(col);
    
    quad(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y);
    p1.update();
    p2.update();
    p3.update();
    p4.update();
  }

}