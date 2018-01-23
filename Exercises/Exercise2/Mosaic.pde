class Mosaic {

  PImage img1;
  PImage img2;
  Square[] square = new Square[768];

  Mosaic(PImage t1, PImage t2) {
    img1 = t1;
    img2 = t2;

    for (int j = 0; j<24; j++) {
      for (int i = 0; i<32; i++) {
        square[i+j*32] = new Square(img1, img2, i*20, j*20);
        println(i+j*32);
      }
    }
  }


  void display() {
    loadPixels();
    for (int i = 0; i < square.length; i++) {
      square[i].display();
    }
  }
  void mouseClicked() {
    for (int i = 0; i<square.length; i++) {
      square[i].mouseClicked();
    }
  }
}