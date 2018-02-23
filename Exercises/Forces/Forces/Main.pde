class Main extends Attractor {

  Main() {
  }



  void keyPressed() {
    if (keyCode == LEFT) {
      acc.x = -10;
    }
    if (keyCode == RIGHT) {
      acc.x = 10;
    }
    if (keyCode == UP) {
      acc.y = -10;
    }
    if (keyCode == DOWN) {
      acc.y = 10;
    }
  }

  void keyReleased() {
    if (keyCode == LEFT||keyCode == RIGHT) {
      acc.x = 0;
      vel.x = 0;
    }
    if (keyCode == UP || keyCode == DOWN) {
      acc.y = 0;
      vel.y = 0;
    }
  }
}