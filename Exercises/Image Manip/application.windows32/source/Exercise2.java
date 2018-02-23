import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Exercise2 extends PApplet {

// IMAGE PROCESSING //<>//
// By Cody Gaudet

// Declare PImages
PImage cat1;
PImage cat2;

// int for picture mode
int mode;

Spotlight spot;
ThreshHold tH;
Mosaic mC;

boolean saveTimer = false;
int timer;

public void setup() {
  
  //load images
  cat1 = loadImage("glowcat.jpg");
  cat2 = loadImage("coatcat2.jpg");
  spot = new Spotlight(cat2, cat1);
  tH = new ThreshHold(cat1, cat2);
  mC = new Mosaic(cat1, cat2);
}

public void draw() {


  switch(mode) {
  case 1: 
    mC.display();

    textAlign(CORNER);
    textSize(10);
    text("click to switch pictures", 10, 10);
    break;
  case 2:

    spot.display(); 
    spot.update();
    textAlign(CORNER);

    textSize(10);
    text("use arrow keys to move", 10, 10);
    break;
  case 3:
    tH.display();
    textAlign(CORNER);

    textSize(10);
    text("click to switch colors, press SPACE to switch pictures", 10, 10);
    break; 
    case 0:
    background(0);
    textAlign(CENTER);
    textSize(30);
    text("1 for pixel, 2 for spotlight, 3 for shadow", width/2, height/2);
    break;
  }
  if (saveTimer) {
    text("saving...", width/2, height/2);
    if (timer+24>millis()) {
      saveTimer = false;
    }
  }
}

public void checkered() {
  //load pixels
  loadPixels(); 

  //set a boolean for a checkered effect
  boolean square = true; 

  // loop goes through all the pixels, alternating between the two images
  for (int i = 0; i<width*height; i++) {
    if (square) {
      pixels[i] = cat1.pixels[i]; 
      square = !square;
    } else {
      pixels[i] = cat2.pixels[i]; 
      square = !square;
    }
    if (i%640 == 0) {
      square = !square;
    }
  }
  // display result
  updatePixels();
}

public void keyPressed() {
  if (key == 's') {
    save("data/savedImage.png");
    saveTimer = true;
    timer = millis();
  }
  if (key == 'q') {
    mode = 0;
  }

  switch(mode) {
  case 1 : 

    break; 
  case 2 : 
    spot.keyPressed(); 
    break; 
  case 3 : 
    tH.keyPressed();
    break; 
  case 0 : 
    if (keyCode == '1') {
      background(0);
      mode = 1;
    } else if (keyCode == '2') {
      mode = 2;
    } else if (keyCode == '3') {
      mode = 3;
    }
    break;
  }
}
public void keyReleased() {
  if (mode == 2) {
    spot.keyReleased();
  }
}

public void mouseClicked() {
  tH.mouseClicked();
  mC.mouseClicked();
}
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


  public void display() {
    loadPixels();
    for (int i = 0; i < square.length; i++) {
      square[i].display();
    }
  }
  public void mouseClicked() {
    for (int i = 0; i<square.length; i++) {
      square[i].mouseClicked();
    }
  }
}
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



  public void display() {
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


  public void update() {
    x+= vx;
    y+= vy;
  }

  public void tintChange() {
  }

  public void keyPressed() {
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

  public void keyReleased() {
    if (keyCode == LEFT ||keyCode == RIGHT) {
      vx = 0;
    }
    if (keyCode == UP ||keyCode == DOWN) {
      vy = 0;
    }
  }
}
class Square {
  int col;
  int tempColor;
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

  public void display() {

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

  public void mouseClicked() {
    temp = img1;
    img1 = img2;
    img2 = temp;
  }
}
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



  public void display() {
    if (white) {
      white();
    } else {
      black();
    }
  }

  public void white() {
    image(img1, 0, 0);
    loadPixels();
    TH = floor(map(mouseX, 0, width, 0, 255));
    int col;
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
  public void black() {
    image(img1, 0, 0);
    loadPixels();
    TH = floor(map(mouseX, 0, width, 0, 255));
    int col;
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
  public void mouseClicked() {
    white = !white;
  }

  public void keyPressed() {
    if (key == ' ') {
      //switch images
      tempImg = img1;
      img1 = img2;
      img2 = tempImg;
    }
  }
}
  public void settings() {  size(640, 480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Exercise2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
