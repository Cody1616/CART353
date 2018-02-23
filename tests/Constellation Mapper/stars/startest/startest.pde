import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;


celBody Earth;
celBody Mercury;

PeasyCam cam;
star stars[] = new star[300];

void setup() {
  fullScreen(P3D);
  background(0);

  Earth = new celBody(new PVector(0, 0, 0), 500, 20, color(100, 150, 230), PI/1000);
  Mercury = new celBody(new PVector(0, 0, 0), 200, 10, color(250, 150, 150), PI/500);
  cam = new PeasyCam(this, Earth.p.x, Earth.p.y, Earth.p.z, 5);

  for (int i = 0; i<stars.length; i++) {
    stars[i] = new star(2000);
  }
}





void draw() {
  cam.setMaximumDistance(10);
  cam.lookAt(Earth.p.x, Earth.p.y, Earth.p.z, 0);
  background(0);
  pointLight(255, 255, 255, 0, 0, 0);
  //cam.beginHUD();
  //text("x "+ cam.getPosition()[0] +"y "+cam.getPosition()[1], 10, 10, 0);
  //cam.endHUD();


  drawSun();
  drawPlanets();

  for (int i = 0; i<stars.length; i++) {
    stars[i].display();
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