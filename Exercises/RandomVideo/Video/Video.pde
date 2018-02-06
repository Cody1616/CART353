
// libraries
import processing.video.*;
import java.util.*;

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

void setup() {
  size(640, 480);
  // initialize capture, cats, etc
  generator = new Random();
  video = new Capture(this, 640, 480, 30);
  video.start();
  for (int i = 0; i<6; i++) {
    for (int j = 0; j<4; j++) {
      cats[i*4+j] = new cat(i*random(70, 120), j*random(70, 120), random(0.01, 0.5), random(1, 1.5));
    }
  }
}




void draw() {
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
  color col;
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


void manageVideo() {
  // if no video imput, then do nothing
  if (!video.available()) {
    return;
  }
  // else look at the imput
  video.read();
}

void getTH() {
  //pretty much the code from Nature of Code

  float num = (float) generator.nextGaussian();
  float sd = 40; //found that 40 works pretty well - it gives varied threshholds (and thus different "shadows" each frame), bu not too random. Which i guess is the point of gaussian anyways/...
  float mean = 127;

  //Multiply by the standard deviation and add the mean. That's the threshhold for this frame
  TH = sd * num + mean;
}

void getBright() {
  // again, from Nature of Code.
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
      // but BEFORE, map the brightness of the lightest color of the threshhold
      // to that first random value. 
      // so that the brightness remains random, but mostly brighter.
      // if that makes any sense. 
      bright = int(map(r1, 0, 1, 100, 255));
      return;
    }
  }
}