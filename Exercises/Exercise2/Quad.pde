class Quad {
  int x;
  int y;
  MovPoint p1;
  MovPoint p2;
  MovPoint p3;
  float t = 0;
  color col;
  Quad(int tx, int ty) {

    x = tx;
    y = ty;
    p1 = new MovPoint(x, y-30, 0.06);
    p2 = new MovPoint(x+30, y-30, 0.5);
    p3 = new MovPoint(x+30, y, 1);
  }


  void changeCoords() {

    // x1 and y1 are fixed and DO NOT CHANGE
    
    t++;
  }

  void drawQuad() {
    stroke(5);
    fill(col);
    p1.update();
    p2.update();
    p3.update();
    quad(x, y, p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
  }

}