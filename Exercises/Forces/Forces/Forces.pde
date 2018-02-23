
Main ball;
Thing objects[] = new Thing[100];


void setup() {
  size(640, 480);
  ball = new Main();
  for (int i = 0; i<objects.length; i++) {
    objects[i] = new Thing();
  }
}

void draw() {
  background(0);
  ball.display();
  ball.update();
  for (int i = 0; i<objects.length; i++) {
  }
}

void keyPressed() {
  ball.keyPressed();
}

void keyReleased() {
  ball.keyReleased();
}