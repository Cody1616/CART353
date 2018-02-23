import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
PeasyCam cam;
Star stars[] = new Star[100];

void setup() {
  size(640, 480, P3D);
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star(int(random(-500, 500)), int(random(-500, 500)), int(random(-500, 500)), int(random(3, 8)), int(random(150, 255)));
  }
  cam = new PeasyCam(this, 300);
}

void draw() {
  background(0);
  for (int i = 0; i < stars.length; i++) {
    stars[i].display();
  }
}