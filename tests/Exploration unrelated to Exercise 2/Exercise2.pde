// IMAGE PROCESSING //<>//
// By Cody Gaudet

// Declare PImages
PImage cat1;
PImage cat2;

// int for picture mode
int mode;

Spotlight spot;
Quad[] tile = new Quad[100];

void setup() {
  size(640, 480);
  //load images
  cat1 = loadImage("glowcat2.jpg");
  cat2 = loadImage("coatcat2.jpg");
  spot = new Spotlight(cat2, cat1);

  for (int i = 0; i<10; i++) {
    for(int j = 0; j<10; j++){
      
      // first shape
      if(i==0&&j==0){
      tile[i+j] = new Quad(new MovPoint(0, 0, 0.01), new MovPoint(0, 40, 0.03), new MovPoint(40, 40, 0.04), new MovPoint(40, 0, 0.08));
      println(tile[i+j].p2.y);  
        
      }
      // beginning of a new row
      else if(j==0){
      tile[i+j] = new Quad(new MovPoint(0, i*40, 0.01), new MovPoint(0, i*40+40, 0.03), new MovPoint(40, i*40+40, 0.04), new MovPoint(40, i*40, 0.08));
      println("2"); 
      
      }
      //other shapes
      else{
      tile[i+j] = new Quad(new MovPoint(j*40, i*40, 0.01), new MovPoint(j*40, i*40+40, 0.03), new MovPoint(j*40, i*40, 0.04), new MovPoint(j*40, i*40, 0.08));
      println(i+j, tile[i+j].p2.x); 
      
      }
    
    
    
    }
  }
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
    circle();
    break;
  case 3:
    cat1.loadPixels();
    image(cat1, 0, 0);
    for (int i = 0; i<tile.length; i++) {
      println(i, tile[i].p1.x, tile[i].p1.y, tile[i].p2.x, tile[i].p2.y, tile[i].p3.x, tile[i].p3.y, tile[i].p4.x, tile[i].p4.y);
    //tile[i].col = cat1.get(int(tile[i].p1.x), int(tile[i].p1.y));
    //tile[i].drawQuad(); 
    }
    break; 
  default : 
    break;
  }
}

void checkered() {
  //load pixels
  loadPixels(); 

  //set a boolean for a checkered effect
  boolean square = true; 

  // loop goes through all the pixels, alternating between the two images
  for (int i = 0; i<=width*height; i++) {
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

void circle() {
  spot.display(); 
  spot.update();
}

void keyPressed() {

  switch(mode) {
  case 1 : 

    break; 
  case 2 : 
    spot.keyPressed(); 
    break; 
  case 3 : 
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