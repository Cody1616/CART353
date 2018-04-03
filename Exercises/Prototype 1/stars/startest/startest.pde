
// import libraries
import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import picking.*;


// declare planets
celBody Earth;
celBody Mercury;

// cameras and pickers
PeasyCam cam;
Picker picker;

// star array - 300 stars
star stars[] = new star[300];

// array place of the last selected star
int lastStarID = -1;

// mode - 2d or 3d
boolean starmode = true;

//_______________________________________________________S E T U P________________________________________________________________________________
void setup() {

  // setup size, etc
  size(600, 600, P3D);
  background(0);

  // initialize picker, cameras, planets
  picker = new Picker(this);
  Earth = new celBody(new PVector(0, 0, 0), 500, 10, color(100, 150, 230), PI/1000);
  Mercury = new celBody(new PVector(0, 0, 0), 200, 5, color(250, 150, 150), PI/500);
  cam = new PeasyCam(this, 50, 50, 50, 5);

  // stars
  for (int i = 0; i<stars.length; i++) {
    stars[i] = new star(1000);
  }
}

//_______________________________________________________D R A W________________________________________________________________________________
void draw() {
  background(0);

  stroke(255, 0, 0);
  line(-200, 0, 0, 200, 0, 0);
  stroke(0, 255, 0);
  line(0, -200, 0, 0, 200, 0);
  stroke(0, 0, 255);
  line(0, 0, -200, 0, 0, 200);

  // choose mode
  if (!starmode) {
    drawPanel();
  } else {


    //cam.beginHUD();
    //text("x "+ cam.getPosition()[0] +"y "+cam.getPosition()[1], 10, 10, 0);
    //cam.endHUD();
    pointLight(255, 255, 255, 0, 0, 0);
    drawSun();
    drawPlanets();

    // display stars and activate picker buffer on each star
    cam.getState().apply(picker.getBuffer());
    for (int i = 0; i < stars.length; i++) {
      picker.start(i); //picker start
      stars[i].display(); // display star
      stroke(255);
      //line(stars[i].getPosition().x, stars[i].getPosition().y, stars[i].getPosition().z, 0, 0, 0);
    }

    // set camera to stick around earth and not reset
    cam.setMaximumDistance(10);
    //cam.lookAt(Earth.p.x, Earth.p.y, Earth.p.z, 0);
    cam.setResetOnDoubleClick(false);

    // LINE DRAWING CODE
    // if a star is selected, draw a line between it and the mouse
    if (lastStarID > -1) {
      PVector starPos = stars[lastStarID].getPosition();

      // new PVector with screen position of the star
      cam.beginHUD();
      PVector s = new PVector(screenX(starPos.x, starPos.y, starPos.z), screenY(starPos.x, starPos.y, starPos.z), screenZ(starPos.x, starPos.y, starPos.z));

      stroke(255);
      line(mouseX, mouseY, 0, s.x, s.y, s.z);

      cam.endHUD();

      // print ln stuff
      println("mouse " + mouseX, mouseY, s.x, s.y);
      println("starsss " + stars[lastStarID].p.x, stars[lastStarID].p.y, stars[lastStarID].p.z);
    }
  }
}

//_______________________________________________________T H E  S U N________________________________________________________________________________
void drawSun() {
  pushMatrix();
  translate(0, 0, 0);
  noStroke();
  fill(255, 250, 250);
  shininess(500);
  emissive(255, 255, 255);
  sphere(25);
  popMatrix();
}

//_______________________________________________________N O T THE S U N________________________________________________________________________________
void drawPlanets() {
  Earth.display();
  Earth.update();
  Mercury.display();
  Mercury.update();
}

// 2d panel
//_______________________________________________________2d________________________________________________________________________________
void drawPanel() {
  cam.beginHUD();
  background(0);
  for (int i = 0; i<stars.length; i++) {
    stars[i].display();
  }
  cam.endHUD();
}

//_______________________________________________________MOUSE/KEYBOARD________________________________________________________________________________
void mouseClicked() {

  int id = picker.get(mouseX, mouseY); //get whats at the mouse location
  if (id > -1 && id < stars.length) { //if its there

    if (lastStarID <=-1) {
      // set laststar to the one selected.
      lastStarID = id;
      println(id);
    } else {
      // draw a line between the last star and the new one, and store the line (connect) in an arraylist. 
      // however i havent written that code yet, so just reset.
      lastStarID = -1;
    }
  }
}

//switch mode
void keyPressed() {
  if (key == ' ') {
    starmode = !starmode;
  }
}
