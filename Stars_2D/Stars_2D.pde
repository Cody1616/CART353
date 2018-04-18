//CODY GAUDET - CONSTELLATION MAPPER
//________________________________INITIALIZATION________________________________________

// boolean for whether the program is in map mode
boolean mapMode = false;

// stars
Star stars[] = new Star[500];

// parralax (?) - how much the "camera" moves around when the keys are pressed
PVector plx = new PVector(0, 0);

// area - bigger than window, so it loops around
PVector areaMax;
PVector areaMin;


// list of constellations and an arraylist for the constellation currently being made
ArrayList<Connector> connectors = new ArrayList<Connector>();
ArrayList<Constellation> constellations = new ArrayList<Constellation>();

// list of drawings and drawing in process
ArrayList<PVector> mouseDrawing = new ArrayList<PVector>();
ArrayList<drawing> sketches = new ArrayList<drawing>();

Planet[] planets = new Planet[10];

// set last star ID to -1 (ie no star selected)
int lastStarID = -1;

// "drawing" mode
boolean drawingMode = false;

// timer for the camera flash
int timer = 0;

// number of images taken
int img = 0;


//________________________________S E T U P_____________________________________________
void setup() {
  //size(640, 480);
  fullScreen();
  areaMax = new PVector(width*2, height*2);
  areaMin = new PVector(-width*2, -height*2);
  for (int i = 0; i<stars.length; i++) {
    stars[i] = new Star(new PVector(random(areaMin.x, areaMax.x), random(areaMin.y, areaMax.y)), random(3, 10));
  }

  for (int i = 0; i<planets.length; i++) {
    planets[i] = new Planet(color(random(0, 255), random(0, 255), random(0, 255)), new PVector(random(areaMin.x, areaMax.x), random(areaMin.y, areaMax.y)), random(20, 50), random(-0.5, 0.5), random(0, 5));
  }
}

//________________________________D R A W_______________________________________________
void draw() {
  if (drawingMode) {
    // if the user is in drawing mode, have a blue background.
    background(0, 0, 100);
    drawPanel();
  } else {
    background(0);
  }
  // display all elements
  display();

  textAlign(CORNER);
  textSize(15);
  fill(200, 200, 255);
  text("Arrow keys to move\nClick a star and drag to make a connection\nPress A to make a constellation\nRight click constellations and planets to rename them\nPress SHIFT to draw on top of constellation/celestial bodies\npress P to take a picture", 20, 20);

  // camera flash
  if (timer > 0) {
    if (millis() - timer > 255) {
      timer = 0;
    } else {
      float f = 255 -(millis()-timer);
      fill(255, f);
      rectMode(CORNER);
      rect(0, 0, width, height);
    }
  }
}

void display() {
  // if there is a connector being drawn, display it
  if (lastStarID>-1) {
    stroke(200);
    line(stars[lastStarID].getPosition().x, stars[lastStarID].getPosition().y, mouseX, mouseY);
  }
  // display everything else
  for (int i = 0; i < connectors.size(); i++) {
    Connector c = connectors.get(i);
    c.display();
  }
  for (int i = 0; i< constellations.size(); i++) {
    Constellation c = constellations.get(i);
    c.display();
  }
  for (int i = 1; i<mouseDrawing.size(); i++) {
    PVector v1 = mouseDrawing.get(i);
    PVector v2 = mouseDrawing.get(i-1);
    strokeWeight(1);
    stroke(255);
    line(v1.x, v1.y, v2.x, v2.y);
  }
  for (int i = 0; i<sketches.size(); i++) {
    drawing d1 = sketches.get(i);
    d1.display();
    d1.move();
  }
  for (int i = 0; i<stars.length; i++) {
    stars[i].display();
    stars[i].move(plx);
  }

  for (int i = 0; i<planets.length; i++) {
    planets[i].display();
    planets[i].travel();
  }
}


void takePicture() {
  drawingMode = false;
  background(0);
  display(); // display everything except text
  save("data/stars"+img+".png");
  img++;
  timer = millis();
}

//________________________________C O N S T E L L A T I O N_____________________________
void createConst() {
  // create new constellation, store connectors in it, put the constellation in arraylist, reset
  Constellation c = new Constellation();
  c.lines.addAll(connectors);
  c.setName("Constellation"+constellations.size());
  constellations.add(c);
  connectors.clear();
}
//________________________________DRAW________________________________________

void drawPanel() {

  stroke(255);
  // add each new stroke to an arraylist
  if (mousePressed == true) {
    stroke(255);
    strokeWeight(1);
    line(mouseX, mouseY, pmouseX, pmouseY);
    mouseDrawing.add(new PVector(mouseX, mouseY));
  }
}

//________________________________KEYBOARD STUFF________________________________________
void keyPressed() {
  if (key == 'q') {
    // map all elements to fit the screen
    mapMode = !mapMode;
    for (int i = 0; i < stars.length; i++) {
      stars[i].convert();
    }
    for (int i = 0; i < planets.length; i++) {
      planets[i].convert();
    }
    for (int i = 0; i< sketches.size(); i++) {
      drawing d = sketches.get(i);
      d.convert();
    }
  }
  if (key == 'p') {
    takePicture();
  }

  if (!mapMode) {
    
    if (keyCode == LEFT) {
      plx.x = 10;
    }
    if (keyCode == RIGHT) {
      plx.x = -10;
    }
    if (keyCode == UP) {
      plx.y = 10;
    }
    if (keyCode == DOWN) {
      plx.y = -10;
    }

    if (key == 'a') {
      // if there are connectors, make a constellation out of them
      if (!connectors.isEmpty()) {
        createConst();
      }
    }
    if (keyCode == SHIFT) {
      // switch drawing mode
      drawingMode = !drawingMode;
    }
    for (int i = 0; i<constellations.size(); i++) {
      Constellation c = constellations.get(i);
      c.keyPressed();
    }
    for (int i = 0; i<planets.length; i++) {
      planets[i].keyPressed();
    }
    if (keyCode == CONTROL && drawingMode) {
      // ctrl delete - remove last line drawn
      if (sketches.size() >= 1) {
        sketches.remove(sketches.size()-1);
      }
    }
    // delete connectors
    if (keyCode == DELETE) {
      for (int i = 0; i <connectors.size(); i++) {
        Connector c = connectors.get(i);
        if (c.mouseOn()) {
          connectors.remove(i);
        }
      }

      for (int i = 0; i <constellations.size(); i++) {
        Constellation s = constellations.get(i);
        for (int j = 0; j< s.lines.size(); j++) {

          Connector c = s.lines.get(j);
          if (c.mouseOn()) {
            s.lines.remove(j);
          }
        }
      }
    }
  }
}

//________________________________MORE KEYBOARD STUFF___________________________________
void keyReleased() {
  if (keyCode == LEFT|| keyCode == RIGHT) {
    plx.x = 0;
  }

  if (keyCode == UP||keyCode == DOWN) {
    plx.y = 0;
  }
}

//________________________________MOUSE STUFF________________________________________
void mousePressed() {
  // when a star is clicked on, a line is drawn between it and the cursor
  for (int i = 0; i<stars.length; i++) {
    if (stars[i].mouseOn()) {
      if (lastStarID <= -1) {
        lastStarID = i;
        break;
      }
    }
  }
  for (int i = 0; i<constellations.size(); i++) {
    Constellation c = constellations.get(i);
    c.mousePressed();
  }
  for (int i = 0; i<planets.length; i++) {
    planets[i].mousePressed();
  }
}

void mouseDragged() {
  // connect other stars in a row
  for (int i = 0; i<stars.length; i++) {
    if (stars[i].mouseOn() && lastStarID > -1) {
      connectors.add(new Connector(stars[lastStarID], stars[i]));
      lastStarID = i;
    }
  }
}
void mouseReleased() {
  if (drawingMode) {
    // put all lines in a new drawing, add that drawing to arraylist
    drawing c = new drawing();
    c.sketch.addAll(mouseDrawing);
    sketches.add(c);
    mouseDrawing.clear();
  }
  // if mouse released on a star and there's a star being connected, add new connector
  for (int i = 0; i<stars.length; i++) {
    if (stars[i].mouseOn() && lastStarID > -1) {
      connectors.add(new Connector(stars[lastStarID], stars[i]));
    }
  }
  lastStarID = -1;
}