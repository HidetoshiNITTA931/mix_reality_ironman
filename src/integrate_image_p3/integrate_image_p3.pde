import kinect4WinSDK.Kinect;

Kinect kine;
void setup() {
  size(640, 480);
  kine = new Kinect(this);
}

void draw() {
  background(0);
  image(kine.GetImage(), 0, 0, 640, 480);
}
