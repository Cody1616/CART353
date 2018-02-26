
terrain[] t = new terrain[48];
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

  for (int i = 0; i < 6; i++) {
    for (int j = 0; j<8; j++) {
      int odd = floor(random(0, 100));
      int m;
      if (odd<25) {
        m = 3;
      } else if (odd<50) {
        m = 2;
      } else {
        m = 1;
      }
      t[i*8+j] = new terrain(j*80, i*80, m);
    }
  }
}

void draw() {
  background(0);
  for (int i = 0; i < t.length; i++) {
    t[i].display();
  }
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

void checkGround() {
  for (int i=0; i< t.length; i++) {
    if (t[i].here(ball)) {
      ball.changeMode(t[i].getMode());
    }
  }
}

void keyPressed() {
  ball.keyPressed();
}

void keyReleased() {
  ball.keyReleased();
}