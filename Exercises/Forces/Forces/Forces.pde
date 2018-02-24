
Main ball;
//Thing objects[] = new Thing[10];

Thing ob;
void setup() {
  size(640, 480);
  ball = new Main(50);
  //for (int i = 0; i<objects.length; i++) {
  //  objects[i] = new Thing(int(random(5, 20)));
  //}
  ob = new Thing(20);
}

void draw() {
  background(0);
  ball.display();
  ball.update();
  //for (int i = 0; i<objects.length; i++) {
  //  objects[i].display();
  //  objects[i].update();
  //  ball.attract(objects[i]);
  //}
  ob.display();
  ob.update();
  ob.applyF(ball.attract(ob));
}

void keyPressed() {
  ball.keyPressed();
}

void keyReleased() {
  ball.keyReleased();
}