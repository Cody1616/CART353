// IMAGE PROCESSING //<>//
// By Cody Gaudet

// Declare PImages
PImage cat1;
PImage cat2;

// int for picture mode
int mode;

Spotlight spot;
ThreshHold tH;

boolean saveTimer = false;
int timer;

void setup() {
  size(640, 480);
  //load images
  cat1 = loadImage("glowcat2.jpg");
  cat2 = loadImage("coatcat2.jpg");
  spot = new Spotlight(cat2, cat1);
  tH = new ThreshHold(cat1, cat2);
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

    spot.display(); 
    spot.update();
    break;
  case 3:
    tH.display();
    break; 
  default: 
    break;
  }
  if (saveTimer) {
    text("saving...", width/2, height/2);
    if (timer+24>millis()) {
      saveTimer = false;
    }
  }
}

void checkered() {
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

void keyPressed() {
  if (key == 's') {
    save("data/savedImage.png");
    saveTimer = true;
    timer = millis();
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
      mode = 1;
    } else if (keyCode == '2') {
      mode = 2;
    } else if (keyCode == '3') {
      mode = 3;
    }
    break;
  }
}
void keyReleased() {
  if (mode == 2) {
    spot.keyReleased();
  }
}

void mouseClicked() {
  tH.mouseClicked();
}