import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 
import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Video extends PApplet {


// libraries



// declare capture element
Capture video;

// random generator for gaussian generation
Random generator;

// float for threshholsd
float TH;

//cat array
cat cats[] = new cat[24];

//ints for brightness and transparency
int bright = 255;
int transp = 30;

public void setup() {
  
  // initialize capture, cats, etc
  generator = new Random();
  video = new Capture(this, 640, 480, 30);
  video.start();
  for (int i = 0; i<6; i++) {
    for (int j = 0; j<4; j++) {
      cats[i*4+j] = new cat(i*random(70, 120), j*random(70, 120), random(0.01f, 0.5f), random(1, 1.5f));
    }
  }
}




public void draw() {
  // call this function to check if theres a video.
  manageVideo();

  // set up video
  tint(255, transp);
  image(video, 0, 0);
  loadPixels();

  //generate threshhold and lighter color brightness
  getTH();
  getBright();

  // go through each pixel to check its color to compare to the threshhold
  int col;
  for (int i = 0; i<height; i++) {
    for (int j = 0; j<width; j++) {
      {
        // get the pixel
        col = video.get(j, i);
        // if higher than threshhold
        if ((red(col)+blue(col)+green(col))/3>TH) {
          // give it the predetermined color we got in getBright() (+ the transparency)(cause it looks cool idk)
          pixels[i*width+j]= color(bright, transp);
        } else {
          // otherwise make it black
          pixels[i*width+j]= color(0, transp);
        }
      }
    }
  }

  // then update the pixels...
  updatePixels();

  // and the cats. Can't forget the cats.
  for (int i = 0; i<cats.length; i++) {
    cats[i].update();
  }
}


public void manageVideo() {
  // if no video imput, then do nothing
  if (!video.available()) {
    return;
  }
  // else look at the imput
  video.read();
}

public void getTH() {
  //pretty much the code from Nature of Code

  float num = (float) generator.nextGaussian();
  float sd = 40; //found that 40 works pretty well - it gives varied threshholds (and thus different "shadows" each frame), bu not too random. Which i guess is the point of gaussian anyways/...
  float mean = 127;

  //Multiply by the standard deviation and add the mean. That's the threshhold for this frame
  TH = sd * num + mean;
}

public void getBright() {
  // again, from Nature of Code.
  //We do this \u201cforever\u201d until we find a qualifying random value.

  while (true) {
    //Pick a random value.
    float r1 = random(1);
    //Assign a probability.
    float probability = r1;
    //Pick a second random value.
    float r2 = random(1);

    //Does it qualify? If so, we\u2019re done!
    if (r2 < probability) {
      // but BEFORE, map the brightness of the lightest color of the threshhold
      // to that first random value. 
      // so that the brightness remains random, but mostly brighter.
      // if that makes any sense. 
      bright = PApplet.parseInt(map(r1, 0, 1, 100, 255));
      return;
    }
  }
}
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
    cat.resize(PApplet.parseInt(random(30, 60)), 0);
  }

  public void update() {
    // set the tint so the cats arent transparent, unlike the video frames
    tint(255, 255);

    // map position to noise. or is it map noise to position? either way, the cats are stuck between their initial position and 100 pixels away from that position
    p.x = map(noise(t), 0, 1, x, x+100);
    p.y = map(noise(u), 0, 1, y, y+100);
    // place cat
    image(cat, p.x, p.y);

    //update time
    t+=0.01f;
    u+=0.01f;
    
    // fun fact - because of the transparency experimental stuff i did, the cats now have
    // these transparent trails behing them. It looks like they're flying really fast
    // N I C E
  }
}
  public void settings() {  size(640, 480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Video" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
