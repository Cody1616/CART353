//array of terrain tiles
terrain[] t = new terrain[48];

//Main ball 
Ball ball;

// attracted objects
//Thing objects[] = new Thing[10];
Thing ob;


void setup() {
  size(640, 480);
  ball = new Ball(50);
  //for (int i = 0; i<objects.length; i++) {
  //  objects[i] = new Thing(int(random(5, 20)));
  //}
  ob = new Thing(20);

  // setting up tiles
  for (int i = 0; i < 6; i++) {
    for (int j = 0; j<8; j++) {
      //ints for probability
      int odd = floor(random(0, 100));
      //int for floor mode that'll be in the constructor
      int m;
      //25% of cactus, 25% sand, 50% normal/regular
      if (odd<25) {
        m = 3;
      } else if (odd<50) {
        m = 2;
      } else {
        m = 1;
      }
      //constructor
      t[i*8+j] = new terrain(j*80, i*80, m);
    }
  }
}

void draw() {
  background(0);
  //display tiles
  for (int i = 0; i < t.length; i++) {
    t[i].display();
  }
  //check where the ball is to adjust friction
  checkGround();
  // then display/update
  ball.display();
  ball.update();
  ball.follow(ob);
  //display objects
  //for (int i = 0; i<objects.length; i++) {
  //  objects[i].display();
  //  objects[i].update();
  //  ball.attract(objects[i]);
  //}
  ob.display();
  ob.update();
  ob.applyForce(ball.attract(ob));
}

// go through each tile and check if the ball is on it
void checkGround() {
  for (int i=0; i< t.length; i++) {
    if (t[i].onTile(ball)) {
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