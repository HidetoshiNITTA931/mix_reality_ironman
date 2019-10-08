import peasy.*;
PShape s;
PImage img;
float t = PI/2;              // 現在の回転角
PeasyCam cam;
void setup() {
  size(1200, 700, P3D);
  // The file "bot.obj" must be in the data folder
  // of the current sketch to load successfully
  img = loadImage("Fe.jpg");
  s = loadShape("test_arm.obj");
  s.setTexture(img);
  print(s);
  cam = new PeasyCam(this, 250);
  cam.setMinimumDistance(10);
  cam.setMaximumDistance(1000);
  
  println("set up ok");
}

void draw() {
  rotateX(-.5);
  rotateY(-.5);
  background(255);
  lights();
  pushMatrix();
  rotateX(PI/2);
  stroke(255, 0, 0);
  line(0,0,0,100,0,0);
  stroke(0, 255, 0);
  line(0,0,0,0,100,0);
  stroke(0, 0, 255);
  line(0,0,0,0,0,100);
  shape(s, 20, 20);
  popMatrix();
}