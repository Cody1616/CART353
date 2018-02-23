import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

import peasy.PeasyCam;

PeasyCam cam;

float posx;
float posz;
int d = 0;
public void setup() {
  size(800, 600, P3D);
  cam = new PeasyCam(this, 400);
}

void draw() {
  background(0);
  noStroke();
  pointLight(255, 255, 255, 0, 0, 0);

  updatePos();
  translate(0, 0, 0);

  fill(255);
  shininess(500);
  emissive(255, 255, 255); // emits white light
  sphere(50);

  translate(posx, 0, posz);
  shininess(300); // adjust how light is reflected
  fill(150, 150, 255); // blue color
  emissive(0, 0, 0); // emits black
  sphere(30);
}


void updatePos() {
  posx = cos(radians(d))*500;
  posz = sin(radians(d))*500;
  d++;
  if (d>=360) {
    d = 0;
  }
}
void keyPressed(){
save("image.png");

}