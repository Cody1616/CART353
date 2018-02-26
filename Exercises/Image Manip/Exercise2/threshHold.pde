class ThreshHold {

  PImage img1;
  PImage img2;
  PImage tempImg; // for switching between images
  int TH;
  boolean white = true;

  ThreshHold(PImage i, PImage j) {
    img1 = i;
    img2 = j;
  }



  void display() {
    if (white) {
      white();
    } else {
      black();
    }
  }

  void white() {
    image(img1, 0, 0);
    loadPixels();
    TH = floor(map(mouseX, 0, width, 0, 255));
    color col;
    for (int i = 0; i<height; i++) {
      for (int j = 0; j<width; j++) {
        {
          col = img1.get(j, i);
          if ((red(col)+blue(col)+green(col))/3>TH) {
            pixels[i*width+j]= color(255);
          } else {
            pixels[i*width+j]= img2.pixels[i*width+j];
          }
        }
      }
    }
    updatePixels();
  }
  void black() {
    image(img1, 0, 0);
    loadPixels();
    TH = floor(map(mouseX, 0, width, 0, 255));
    color col;
    for (int i = 0; i<height; i++) {
      for (int j = 0; j<width; j++) {
        {
          col = img1.get(j, i);
          if ((red(col)+blue(col)+green(col))/3<TH) {
            pixels[i*width+j]= color(0);
          } else {
            pixels[i*width+j]= img2.pixels[i*width+j];
          }
        }
      }
    }
    updatePixels();
  }
  void mouseClicked() {
    white = !white;
  }

  void keyPressed() {
    if (key == ' ') {
      //switch images
      tempImg = img1;
      img1 = img2;
      img2 = tempImg;
    }
  }
}