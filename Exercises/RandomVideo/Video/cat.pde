class cat {
  // original x and y positions
  float x; 
  float y;

  // time values for perlin noise stuff
  float t;
  float u;

  // cat
  PImage cat;

  // and current position of said cat
  PVector p = new PVector(0, 0);

  cat(float tx, float ty, float tt, float ut) {
    // pass position and time from main prog 
    // this allows us to randomize things when we create an array of cats.
    x = tx;
    y = ty;
    t = tt;
    u = ut;
    // load image and give it a random size
    cat = loadImage("hovercat.png");
    cat.resize(int(random(30, 60)), 0);
  }

  void update() {
    // set the tint so the cats arent transparent, unlike the video frames
    tint(255, 255);

    // map position to noise. or is it map noise to position? either way, the cats are stuck between their initial position and 100 pixels away from that position
    p.x = map(noise(t), 0, 1, x, x+100);
    p.y = map(noise(u), 0, 1, y, y+100);
    // place cat
    image(cat, p.x, p.y);

    //update time
    t+=0.01;
    u+=0.01;
    
    // fun fact - because of the transparency experimental stuff i did, the cats now have
    // these transparent trails behing them. It looks like they're flying really fast
    // N I C E
  }
}