class Spotlight {
  int x;
  int y;
  int vx;
  int vy;
  int speed = 10;
  PImage img;
  PImage img2;

  Spotlight(PImage tImg, PImage tImg2) {
    x = width/2;
    y = height/2;

    img = tImg;
    img2 = tImg2;
  }



  void display() {
    loadPixels();
    img.loadPixels();
    image(img, 0, 0);

    for (int i = 0; i<height; i ++) {
      for (int j = 0; j < width; j++) {
        if (dist(j, i, x, y) < 50) {
          pixels[i*width+j] = img.pixels[i*width+j];
        } else {
          pixels[i*width+j] = img2.pixels[i*width+j];
        }
      }
    }
    updatePixels();
  }


  void update() {
    x+= vx;
    y+= vy;
  }

  void tintChange() {
  }

  void keyPressed() {
    if (keyCode == LEFT) {
      vx = -speed;
    } 
    if (keyCode == RIGHT) {
      vx = speed;
    } 
    if (keyCode == UP) {
      vy = -speed;
    } 
    if (keyCode == DOWN) {
      vy = speed;
    }
  }

  void keyReleased() {
    if (keyCode == LEFT ||keyCode == RIGHT) {
      vx = 0;
    }
    if (keyCode == UP ||keyCode == DOWN) {
      vy = 0;
    }
  }
}