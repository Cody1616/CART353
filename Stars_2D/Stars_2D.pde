//CODY GAUDET - CONSTELLATION MAPPER
//________________________________INITIALIZATION________________________________________


Star stars[] = new Star[200];


// parralax (?) - how much the "camera" moves around when the keys are pressed
PVector plx = new PVector(0, 0);

// area - bigger than window, so it loops around
PVector areaMax;
PVector areaMin;

ArrayList<Connector> connectors = new ArrayList<Connector>();

ArrayList<Constellation> stells = new ArrayList<Constellation>();

ArrayList<PVector> mouseDrawing = new ArrayList<PVector>();

ArrayList<drawing> doodles = new ArrayList<drawing>();

Planet[] planets = new Planet[10];

// set last star ID to -1 (ie no star selected)
int lastStarID = -1;

boolean drawing = false;


//________________________________S E T U P_____________________________________________
void setup() {
  //size(640, 480);
  fullScreen();
  areaMax = new PVector(width+1000, height+1000);
  areaMin = new PVector(-1000, -1000);
  for (int i = 0; i<stars.length; i++) {
    stars[i] = new Star(new PVector(random(areaMin.x, areaMax.x), random(areaMin.y, areaMax.y)), random(4, 8));
  }

  for (int i = 0; i<planets.length; i++) {
    planets[i] = new Planet(color(random(0, 255), random(0, 255), random(0, 255)), new PVector(random(areaMin.x, areaMax.x), random(areaMin.y, areaMax.y)), random(20, 50), random(-0.5, 0.5));
  }
}

//________________________________D R A W_______________________________________________
void draw() {
  if (drawing) {
    background(0, 0, 100);
    drawPanel();
  } else {
    background(0);
  }

  for (int i = 0; i<stars.length; i++) {
    stars[i].display();
    stars[i].move(plx);
  }
  if (lastStarID>-1) {
    stroke(200);
    line(stars[lastStarID].getPosition().x, stars[lastStarID].getPosition().y, mouseX, mouseY);
  }
  for (int i = 0; i < connectors.size(); i++) {
    Connector c = connectors.get(i);
    c.display();
  }
  for (int i = 0; i< stells.size(); i++) {
    Constellation c = stells.get(i);
    c.display();
  }
  for (int i = 1; i<mouseDrawing.size(); i++) {
    PVector v1 = mouseDrawing.get(i);
    PVector v2 = mouseDrawing.get(i-1);
    strokeWeight(1);
    stroke(255);
    line(v1.x, v1.y, v2.x, v2.y);
  }
  for (int i = 0; i<doodles.size(); i++) {
    drawing d1 = doodles.get(i);
    d1.display();
    d1.move();
  }


  for (int i = 0; i<planets.length; i++) {
    planets[i].display();
    planets[i].travel();
  }
  textAlign(CORNER);
  textSize(15);
  fill(200, 200, 255);
  text("Arrow keys to move\nClick a star and drag to make a connection\nPress A to make a constellation\nRight click constellations and planets to rename them\nPress SHIFT to draw on top of constellation/celestial bodies", 20, 20);
}

//________________________________C O N S T E L L A T I O N_____________________________
void createConst() {
  Constellation c = new Constellation();
  c.lines.addAll(connectors);
  c.setName("Constellation"+stells.size());
  stells.add(c);
  connectors.clear();
}
//________________________________DRAW________________________________________

void drawPanel() {

  stroke(255);
  if (mousePressed == true) {
    stroke(255);
    strokeWeight(1);
    line(mouseX, mouseY, pmouseX, pmouseY);
    mouseDrawing.add(new PVector(mouseX, mouseY));
  }
}

//________________________________KEYBOARD STUFF________________________________________
void keyPressed() {
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
    if (!connectors.isEmpty()) {
      println("CONSTELLATION CREATED");
      createConst();
    }
  }
  if (keyCode == SHIFT) {
    drawing = !drawing;
  }
  for (int i = 0; i<stells.size(); i++) {
    Constellation c = stells.get(i);
    c.keyPressed();
  }
  for (int i = 0; i<planets.length; i++) {
    planets[i].keyPressed();
  }
  if (keyCode == DELETE) {
    for (int i = 0; i <connectors.size(); i++) {
      Connector c = connectors.get(i);
      if (c.mouseOn()) {
        connectors.remove(i);
      }
    }

    for (int i = 0; i <stells.size(); i++) {
      Constellation s = stells.get(i);
      for (int j = 0; j< s.lines.size(); j++) {

        Connector c = s.lines.get(j);
        if (c.mouseOn()) {
          s.lines.remove(j);
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
  for (int i = 0; i<stars.length; i++) {
    if (stars[i].onStar()) {
      if (lastStarID <= -1) {
        lastStarID = i;
        break;
      }
    }
  }
  for (int i = 0; i<stells.size(); i++) {
    Constellation c = stells.get(i);
    c.mousePressed();
  }
  for (int i = 0; i<planets.length; i++) {
    planets[i].mousePressed();
  }
}

void mouseDragged() {
  for (int i = 0; i<stars.length; i++) {
    if (stars[i].onStar() && lastStarID > -1) {
      connectors.add(new Connector(stars[lastStarID], stars[i]));
      lastStarID = i;
    }
  }
}
void mouseReleased() {
  if (drawing) {
    println("NEW");
    drawing c = new drawing();
    c.sketch.addAll(mouseDrawing);
    doodles.add(c);
    mouseDrawing.clear();
  }
  for (int i = 0; i<stars.length; i++) {
    if (stars[i].onStar() && lastStarID > -1) {
      println("CONNECT");
      connectors.add(new Connector(stars[lastStarID], stars[i]));
    }
  }
  lastStarID = -1;
}