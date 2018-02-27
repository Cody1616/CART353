class terrain {
  
  // size, loc, mode, c
  int size = 80;
  int x;
  int y;
  int mode;
  color c;
  
  
  terrain(int tx, int ty, int tm) {
    mode = tm;
    x = tx;
    y = ty;
    colorswitch(); //checking color
  }

  int getMode() {
    return mode;
  }

  void colorswitch() {
    switch(mode) {
      //regular  
    case 1: 
      c = color(200, 200, 200);
      break;
      //sand
    case 2: 
      c = color(200, 100, 100);
      break;
      //cactus
    case 3: 
      c = color(50, 255, 50);
      break;
    }
  }

  void display() {
    rectMode(CORNER);
    fill(c);
    rect(x, y, size, size);
  }
  
  
  // check if a Ball object is on the tile
  boolean onTile(Ball m) {
    boolean left = (m.getLoc().x+m.getSize() > x);
    boolean right = (m.getLoc().x < x+size);
    boolean up = (m.getLoc().y +m.getSize() > y);
    boolean down = (m.getLoc().y < y+size);
    return left && right && up && down;
  }
}