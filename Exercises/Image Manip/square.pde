class Square {
  color col;
  color tempColor;
  int avgColor = 0;
  int size = 20;
  int x;
  int y;
  boolean dot = false;
  PImage img1;
  PImage img2;
  PImage temp;

  int r;
  int g;
  int b;

  Square(PImage tI1, PImage tI2, int tx, int ty) {

    img1 = tI1;
    img2 = tI2;
    x = tx;
    y = ty;
  }

  void display() {

    if (x-size*2<mouseX&&x+size*2>mouseX&&y-size*2<mouseY&&y+size*2>mouseY) {
      dot = true;
    } else {
      dot = false;
    }

    for (int i = 0; i<size; i++) {
      for (int j = 0; j<size; j++) {
        if (dot) {
          tempColor = img2.get(x+i, y+j);
        } else {
          tempColor = img1.get(x+i, y+j);
        }
        r+=red(tempColor);
        g+=green(tempColor);
        b+=blue(tempColor);
      }
    }
    col = color(r/(size*size), g/(size*size), b/(size*size));
    if (dot) {
      fill(col);
    } else {
      fill(col, 20);
    }   
    rect(x, y, size, size);
    r = 0;
    g = 0;
    b = 0;
  }

  void mouseClicked() {
    temp = img1;
    img1 = img2;
    img2 = temp;
  }
}