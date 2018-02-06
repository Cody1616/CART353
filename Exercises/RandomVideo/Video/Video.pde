import processing.video.*;

import java.util.*;

Capture video;

Random generator;

float TH;

cat cats[] = new cat[24];

int b = 255;
int t = 30;

void setup() {
  size(640, 480);
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
  manageVideo();
  tint(255, t);
  image(video, 0, 0);
  loadPixels();
  getTH();
  getBright();
  color col;
  for (int i = 0; i<height; i++) {
    for (int j = 0; j<width; j++) {
      {
        col = video.get(j, i);
        if ((red(col)+blue(col)+green(col))/3>TH) {
          pixels[i*width+j]= color(b, t);
        } else {
          pixels[i*width+j]= color(0, t);
        }
      }
    }
  }


  updatePixels();
  for(int i = 0; i<cats.length; i++){
    cats[i].update();
  
  }
}


void manageVideo() {
  if (!video.available()) {
    return;
  }

  video.read();
}

void getTH() {
  //Note that nextGaussian() returns a double.
  float num = (float) generator.nextGaussian();
  float sd = 40;
  float mean = 320;

  //Multiply by the standard deviation and add the mean.
  float x = sd * num + mean;
  TH = map(x, 0, width, 0, 255);
}

void getBright() {
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
      b = int(map(r1, 0, 1, 100, 255));
      return;
    }
  }
}