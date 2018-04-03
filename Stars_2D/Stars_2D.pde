Star stars[] = new Star[300];
PVector plx = new PVector(0, 0);
PVector areaMax;
PVector areaMin;

ArrayList<Connector> connectors = new ArrayList<Connector>();

int lastStarID = -1;

void setup() {
  size(800, 800);
  //fullScreen();
  areaMax = new PVector(width+500, height+500);
  areaMin = new PVector(-500, -500);
  for (int i = 0; i<stars.length; i++) {
    stars[i] = new Star(new PVector(random(areaMin.x, areaMax.x), random(areaMin.y, areaMax.y)), random(4, 8));
  }
}

void draw() {
  println(lastStarID, connectors.size());
  background(0);
  for (int i = 0; i<stars.length; i++) {
    stars[i].display();
    stars[i].move(plx);
  }
  if (lastStarID>-1) {
    stroke(255);
    line(stars[lastStarID].getPosition().x, stars[lastStarID].getPosition().y, mouseX, mouseY);
  }
  for (int i = 0; i < connectors.size(); i++) {
    Connector c = connectors.get(i);
    c.display();
  }
}


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
}

void keyReleased() {
  if (keyCode == LEFT|| keyCode == RIGHT) {
    plx.x = 0;
  }

  if (keyCode == UP||keyCode == DOWN) {
    plx.y = 0;
  }
}

void mousePressed() {
  for (int i = 0; i<stars.length; i++) {
    if (stars[i].onStar()) {
      
      if(lastStarID > -1){
        connectors.add(new Connector(stars[lastStarID], stars[i]));
        lastStarID = -1;
        println(connectors.size() + "ey!");

      }

      else if (lastStarID <= -1) {
        lastStarID = i;
        break;

      } 
      
    } 
    else {
      lastStarID = -1;
    }
  }
}
