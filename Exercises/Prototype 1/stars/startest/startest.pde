import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import picking.*;

celBody Earth;
celBody Mercury;

PeasyCam cam;
Picker picker;
star stars[] = new star[300];

int lastStarID = -1;

void setup() {
  size(600, 600, P3D);
  background(0);

  picker = new Picker(this);
  Earth = new celBody(new PVector(0, 0, 0), 500, 20, color(100, 150, 230), PI/1000);
  Mercury = new celBody(new PVector(0, 0, 0), 200, 10, color(250, 150, 150), PI/500);
  cam = new PeasyCam(this, Earth.p.x, Earth.p.y, Earth.p.z, 5);

  for (int i = 0; i<stars.length; i++) {
    stars[i] = new star(1000);
  }
}





void draw() {


  background(0);
  pointLight(255, 255, 255, 0, 0, 0);
  //ambientLight(255, 255, 255);
  //cam.beginHUD();
  //text("x "+ cam.getPosition()[0] +"y "+cam.getPosition()[1], 10, 10, 0);
  //cam.endHUD();



  drawSun();
  drawPlanets();
  cam.getState().apply(picker.getBuffer());
  for (int i = 0; i < stars.length; i++) {
    picker.start(i); //picker start
    stars[i].display(); // display star
  }
  cam.setMaximumDistance(10);
  //cam.lookAt(Earth.p.x, Earth.p.y, Earth.p.z, 0);
  cam.setResetOnDoubleClick(false);

  if (lastStarID > -1) {
    float sx = stars[lastStarID].p.x;
    float sy = stars[lastStarID].p.y;
    float sz = stars[lastStarID].p.z;
    PVector s = new PVector(screenX(sx, sy, sz), screenY(sx, sy, sz), screenZ(sx, sy, sz));
    cam.beginHUD();
    stroke(255);
    line(mouseX, mouseY, 0, abs(s.x), abs(s.y), abs(s.z));
    
    cam.endHUD();
    println("mouse " + mouseX, mouseY, s.x, s.y);
    println("starsss " + stars[lastStarID].p.x, stars[lastStarID].p.y, stars[lastStarID].p.z);
    
  }
}


void drawSun() {
  pushMatrix();
  translate(0, 0, 0);
  noStroke();
  fill(255, 250, 250);
  shininess(500);
  emissive(255, 255, 255);
  sphere(100);
  popMatrix();
}

void drawPlanets() {
  Earth.display();
  Earth.update();
  Mercury.display();
  Mercury.update();
}

void mouseClicked() {
  int id = picker.get(mouseX, mouseY); //get whats at the mouse location
  if (id > -1 && id < stars.length) { //if its there
    //stars[id].changeColor();
    lastStarID = id;
    println(id);
    stroke(255);
  }
}
