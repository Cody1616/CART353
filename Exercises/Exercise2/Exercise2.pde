// IMAGE PROCESSING
// By Cody Gaudet

// Declare PImages
PImage cat1;
PImage cat2;

// int for picture mode
int mode;

void setup() {
  size(640, 480);
  //load images
  cat1 = loadImage("glowcat2.jpg");
  cat2 = loadImage("coatcat2.jpg");
}

void draw() {

  if (mode == 0) {
    background(0);
    textAlign(CENTER);
    textSize(30);
    text("1 for checkered, 2 for x, 3 for x", width/2, height/2);
  }

  switch(mode) {
  case 1: 
    checkered();
    break;
  case 2:
  case 3:
  default: 
    break;
  }
}

void checkered() {
  //load pixels
  loadPixels();

  //set a boolean for a checkered effect
  boolean square = true;

  // loop goes through all the pixels, alternating between the two images
  for (int i =0; i<width*height; i++) {
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

void keyPressed() {
  if (keyCode == '1') {
    mode = 1;
    
  } else if (keyCode == '2') {
    mode = 2;
    
  } else if (keyCode == '3') {
    mode = 3;
    
  } else {
    mode = 0;
    
  }
}