import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

/**
 * @author Nicolas Clavaud <antiplastik@gmail.com>
 */

import picking.*;

Picker picker;
Cube[] cubes;
PeasyCam cam;

float rotation = 0;

void setup() {
  size(200, 200, P3D);

  picker = new Picker(this);
  cam = new PeasyCam(this, 50);
  cubes = new Cube[10];
  for (int i = 0; i < cubes.length; i++) {
    cubes[i] = new Cube(
      -15 + (int)random(30), 
      -15 + (int)random(30), 
      -15 + (int)random(30), 
      5 + (int)random(15)
      );
  }
}

void draw() {
  rotation += 0.002;
  if (rotation > TWO_PI) {
    rotation -= TWO_PI;
  }
  cam.getState().apply(picker.getBuffer());
  
  background(255);

  for (int i = 0; i < cubes.length; i++) {
    picker.start(i); //picker start
    cubes[i].display(); // display cube
  }
}

void mouseClicked() {
  int id = picker.get(mouseX, mouseY); //get whats at the mouse location
  if (id > -1) { //if its there
    cubes[id].changeColor();
  }
}