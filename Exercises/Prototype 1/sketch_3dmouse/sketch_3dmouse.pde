//
// https://forum.processing.org/topic/determining-3d-mouse-position-using-z-coordinate-with-p3d-renderer
//
// program state
final int stateStartScreen = 0;
final int stateNormal = 1;
//
int state=stateStartScreen ;
//
final float floorY=600;
//
float CameraX;
float CameraY;
float CameraZ;
//
float angle; // for the blue bar
//
PVector mouse3D = new PVector();
//
String globalCamName="";
float angleNumAt; // for numAt // rotating numbers (using angle angleNumAt in degrees)
//
CameraPosition [] cameraPositions = new CameraPosition[8];
int indexCameraPositions=0;
//
ArrayList<Ball> balls; // the points of the shape you draw
//
void setup()
{
  size( 800, 800, P3D );
  balls = new ArrayList();
  //
  CameraX = 0;
  CameraY = 0;
  CameraZ = 0;
  //  noCursor();
  mouse3D.set(width/2, height/2, 0);
  // default cam
  cameraPositions[0] = new CameraPosition(new PVector(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0)),
  new PVector (  width/2.0, height/2.0, 0   ),
  new PVector (   0, 1, 0  ),
  "from south (default)" );
  //
  cameraPositions[1] = new CameraPosition(new PVector(-320, height/2.0, -10),
  new PVector (  width/2.0, height/2.0, 0   ),
  new PVector (   0, 1, 0  ),
  "from west" );
  //
  cameraPositions[2] = new CameraPosition(new PVector(width/2.0, height/2.0, -1 * ( (height/2.0) / tan(PI*30.0 / 180.0))),
  new PVector (  width/2.0, height/2.0, 0   ),
  new PVector (   0, 1, 0  ),
  "from north " );
  //
  cameraPositions[3] = new CameraPosition(new PVector(width+320, height/2.0, -10),
  new PVector (  width/2.0, height/2.0, 0   ),
  new PVector (   0, 1, 0  ),
  "from east " );
  //
  // now all 4 directions but higher
  int i=0;
  cameraPositions[4] = new CameraPosition( new PVector (cameraPositions[i].pos.x, cameraPositions[i].pos.y, cameraPositions[i].pos.z),
  new PVector (cameraPositions[i].lookAt.x, cameraPositions[i].lookAt.y, cameraPositions[i].lookAt.z),
  new PVector (cameraPositions[i].up.x, cameraPositions[i].up.y, cameraPositions[i].up.z),
  "from south (higher) " );
  cameraPositions[4].pos.y -= 300; 
  //
  i=1;
  cameraPositions[5] = new CameraPosition( new PVector (cameraPositions[i].pos.x, cameraPositions[i].pos.y, cameraPositions[i].pos.z),
  new PVector (cameraPositions[i].lookAt.x, cameraPositions[i].lookAt.y, cameraPositions[i].lookAt.z),
  new PVector (cameraPositions[i].up.x, cameraPositions[i].up.y, cameraPositions[i].up.z),
  "from west (higher) " );
  cameraPositions[5].pos.y = cameraPositions[4].pos.y ;
  //
  i=2;
  cameraPositions[6] = new CameraPosition( new PVector (cameraPositions[i].pos.x, cameraPositions[i].pos.y, cameraPositions[i].pos.z),
  new PVector (cameraPositions[i].lookAt.x, cameraPositions[i].lookAt.y, cameraPositions[i].lookAt.z),
  new PVector (cameraPositions[i].up.x, cameraPositions[i].up.y, cameraPositions[i].up.z),
  "from north (higher) " );
  cameraPositions[6].pos.y = cameraPositions[4].pos.y ;
  //
  i=3;
  cameraPositions[7] = new CameraPosition( new PVector (cameraPositions[i].pos.x, cameraPositions[i].pos.y, cameraPositions[i].pos.z),
  new PVector (cameraPositions[i].lookAt.x, cameraPositions[i].lookAt.y, cameraPositions[i].lookAt.z),
  new PVector (cameraPositions[i].up.x, cameraPositions[i].up.y, cameraPositions[i].up.z),
  "from east (higher) " );
  cameraPositions[7].pos.y = cameraPositions[4].pos.y ;
  //
  //
} // setup
//
void draw()
{
  background(0);
  switch (state) {
  case stateStartScreen:
    fill(255);
    String text1 = "This is a small sketch to demonstrate the 3D space and a 3D mouse. \n\n"
      +"credit http://forum.processing.org/topic/determining-3d-mouse-position-using-z-coordinate-with-p3d-renderer \n"
      + "The sketch shows a smal scene. The sketch comes with 8 camera-positions you can cycle through with pressing SPACE. \n"
      +"1st camera from front (traditional), here called south. Then left (here called west), then north, then east, \n"
      +"then south, but higher up and equally high west, north and east again and then back to the beginning. \n\n"
      +"Use cursor keys to change camera x + and - and y + and - . Also p and L for cam Z + and - (u resets).\n\n\n"
      +"The red box denotes the 3D mouse. \n\n"
      +"Please note that when you look from west, the mouse-x still moves the virtual move X (although it looks like back and forth now). \n\n"
      +"Please note how easy it is now to paint 3D-Shapes now. \n\n"
      +"usage: SPACE-change cam; mouse drag or left-click to change 3D-mouse x and y position; key f and r to move z; "
      +"\n              right-click to set 3D-point.\n\n\n"
      +"Press any key.";
    // println(text1);
    text (text1, 30, 50, width-50, 1900);
    break;
  case stateNormal:
    drawForStateNormal();
    break;
  } // switch
} // func
//
void drawForStateNormal() {
  // help
  camera();
  fill(255);
  text ("usage: SPACE-change cam; mouse drag or left-click to change 3D-mouse x and y position; key f and r to move z; "
    +"\n              right-click to set 3D-point", 30, 50);
  text("3D-mouse pos: " + mouse3D.x+", "+mouse3D.y+", "+mouse3D.z, width-250, 70);
  text("cam pos: "
    +  str( cameraPositions[ indexCameraPositions ].pos.x + CameraX)
    +  ", "
    +  str( cameraPositions[ indexCameraPositions ].pos.y + CameraY)
    +  ", "
    +  str( cameraPositions[ indexCameraPositions ].pos.z + CameraZ), width-250, 100);
  //
  text("camera is "
    +globalCamName
    + ", #"
    +indexCameraPositions, 30, 30);
  // camera 
  cameraPositions[ indexCameraPositions ].use();
  //
  //
  // Floor
  drawFloor();
  // some stuff
  fill (0, 0, 255); // blue
  boxAt(100, 600-20, 0);
  numAt(100, 600-20, 0, 1);
  fill (255, 0, 255); // pink
  boxAt(100, 600-20, -160);
  numAt(100, 600-20, -160, 2);
  fill (255, 255, 0); // yellow
  boxAt(700, 600-20, -160);
  numAt(700, 600-20, -160, 3);
  fill (0, 255, 0); // green
  boxAt(700, 600-20, 0);
  numAt(700, 600-20, 0, 4);
  angleNumAt++;
  // ==================================================
  //
  //
  // show virtual 3D mouse
  pushMatrix();
  fill(255, 2, 2);
  translate(mouse3D.x, mouse3D.y, mouse3D.z);
  box (20, 20, 20);
  popMatrix();
  //
  // paint blue bar / box
  stroke(111, 110, 110);
  fill(111, 110, 110);
  pushMatrix();
  translate(width/2, 0, 0);
  rotateY(angle);
  MyBox (-100, 350, -0,
  100, 350, -0,
  15, color (2, 0, 255));
  popMatrix();
  angle+=.01;
  //
  // for-loop
  Ball ball2=null;
  for (int i = 0; i < balls.size()-1; i++) {
    Ball ball = balls.get(i);
    ball.display();
    ball2 = balls.get(i+1);
    ball2.display();
    stroke(144);
    line (ball.x, ball.y, ball.z,
    ball2.x, ball2.y, ball2.z);
  } // for
  //
  stroke(90);
  if (ball2!=null)
    line (   ball2.x, ball2.y, ball2.z,
    mouse3D.x, mouse3D.y, mouse3D.z  );
  //
  //  // a new for-loop to delete balls
  //  // (it is better to have 2 separate for-loops)
  //  for (int i = balls.size()-1; i >= 0; i--) {
  //    Ball ball = balls.get(i);
  //    if (ball.y+ball.h > height) {
  //      balls.remove(i);
  //    } // if
  //  } // for
  //
} // func
//
void keyPressed() {
  //
  switch (state) {
    //
  case stateStartScreen:
    state=stateNormal;
    break;
  default:
    if (key == CODED) {
      // cursor is for camera
      if (keyCode == UP) {
        CameraY-=10;
      }
      else if (keyCode == DOWN) {
        CameraY+=10;
      }
      else if (keyCode == RIGHT) {
        CameraX+=10;
      }
      else if (keyCode == LEFT) {
        CameraX-=10;
      }
      else {
        // nothing
      }
    }
    else { 
      // not key == CODED
      //
      if (key=='r') {
        mouse3D.z-=11;
      }
      else if (key=='f') {
        mouse3D.z+=11;
      }
      else if (key=='p') {
        CameraZ-=11;
      }
      else if (key=='l'||key=='L') {
        CameraZ+=11;
      }
      else if (key=='u'||key=='U') {
        CameraX=0;
        CameraY=0;
        CameraZ=0;
      }     
      else if (key==' ') {
        // SPACE
        indexCameraPositions++;
        if (indexCameraPositions >= cameraPositions.length) {
          indexCameraPositions=0;
        }
      }
    }
    break;
  }
}
//
void boxAt(float x, float y, float z) {
  pushMatrix();
  translate(x, y, z);
  box (20, 20, 20);
  popMatrix();
}
//
void numAt(float x, float y, float z, int num) {
  // rotating numbers (using angle angleNumAt)
  pushMatrix();
  translate(x, y-19, z);
  rotateY(radians(angleNumAt));
  text ( str (num), -2, 0, 0);
  popMatrix();
}
//
void MyBox(float x1, float y1, float z1,
float x2, float y2, float z2,
float weight, color strokeColour)
// was called drawLine; programmed by James Carruthers
// see http://processing.org/discourse/yabb2/YaBB.pl?num=1262458611/0#9
{
  PVector p1 = new PVector(x1, y1, z1);
  PVector p2 = new PVector(x2, y2, z2);
  PVector v1 = new PVector(x2-x1, y2-y1, z2-z1);
  float rho = sqrt(pow(v1.x, 2)+pow(v1.y, 2)+pow(v1.z, 2));
  float phi = acos(v1.z/rho);
  float the = atan2(v1.y, v1.x);
  v1.mult(0.5);
  pushMatrix();
  translate(x1, y1, z1);
  translate(v1.x, v1.y, v1.z);
  rotateZ(the);
  rotateY(phi);
  noStroke();
  fill(strokeColour);
  box(weight, weight, p1.dist(p2)*1.2);
  popMatrix();
}
void drawFloor() {
  stroke(255);
  // draw floor:
  //
  // to right (background)
  line ( 20, floorY, -200,
  width-20, floorY, -200);
  // to right (in the front)
  line ( 20, floorY, -0,
  width-20, floorY, -0);
  // left side
  line ( 20, floorY, -200,
  20, floorY, -0);
  // right side  
  line ( width-20, floorY, -200,
  width-20, floorY, -0);
}
//
void mouseReleased() {
  if (mouseButton == LEFT)
  {
    float dx = mouseX ;
    float dy = mouseY ;
    mouse3D.x=dx;
    mouse3D.y=dy;
  } // if
  else if (mouseButton == RIGHT) {
    balls.add(new Ball(mouse3D.x, mouse3D.y, mouse3D.z,
    10, 5, 10,
    1, 11, 252));
  } // else if
} // func
//
void mouseDragged() {
  float dx = mouseX - pmouseX;
  float dy = mouseY - pmouseY;
  mouse3D.x+=dx;
  mouse3D.y+=dy;
}
//
// classes
// ======================================================
class CameraPosition {
  // see http://www.processing.org/reference/camera_.html
  PVector pos;     // eye
  PVector lookAt;  // center
  PVector up;      // up
  String name = "";
  //
  // constr
  CameraPosition ( PVector pos_, PVector lookAt_, PVector up_, String name_ ) {
    //
    pos    = pos_;
    lookAt = lookAt_;
    up     = up_;
    name   = name_;
    //
  } // constr
  //
  void use () {
    camera(pos.x+CameraX, pos.y+CameraY, pos.z+CameraZ,
    lookAt.x, lookAt.y, lookAt.z,
    up.x, up.y, up.z);
    globalCamName=name;
  } // method
  //
  //  void print() {
  //    printCamera();
  //  } // method
  //
  //
} // classs
//
// ==================================================
class Ball { 
  // pos
  float x;
  float y;
  float z;
  // size
  float w;
  float h;
  float d;
  // color // or use color
  float r, g, b;
  Ball(float tempX, float tempY, float tempZ,
  float tempW, float tempH, float tempD,
  float tempR, float tempG, float tempB) {
    x = tempX;
    y = tempY;
    z = tempZ;
    //
    w = tempW;
    h = tempH;
    d = tempD;
    //
    // color
    r = tempR;
    g = tempG;
    b = tempB;
    //
  }
  //
  void display() {
    fill(r, g, b);
    pushMatrix();
    translate(x, y, z);
    box (w, h, d);
    popMatrix();
  }
  //
} // class
//
