float r1;
float x = 0;
float y = 0;
float thresh;
int b = 255;
void setup() {
  size(640, 480);
  background(0);
  thresh = 0;
}

void draw() {
  if (b>0) {
    fill(b);
    y = montecarlo();
    y = map(y, 0, 1, thresh, height);
    println("x", x, "y", y);
    noStroke();
    rect(x, y, 6, height-y);
    x+=4;
    if (x>width) {
      thresh += 50;
      x = 0;
      b-=50;
    }
  }
}





float montecarlo() {
  //We do this “forever” until we find a qualifying random value.
  while (true) {
    //Pick a random value.
    float r1 = random(1);
    //Assign a probability.
    float probability = r1;
    //Pick a second random value.
    float r2 = random(1);

    //Does it qualify? If so, we’re done!
    if (r2 < probability) {

      println(r1);
      return r1;
    }
  }
}