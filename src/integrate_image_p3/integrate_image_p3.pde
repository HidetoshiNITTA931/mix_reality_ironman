import KinectPV2.*;

KinectPV2 kinect;
void setup() {
  size(1920, 1080, P3D);
  kinect = new KinectPV2(this);

  // kinectの機能をONにする
  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);

  kinect.init();
}

void draw() {
  background(0);
  image(kinect.getColorImage(), 0, 0, width, height);  
  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();

  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();

      color col  = skeleton.getIndexColor();
      fill(col);
      stroke(col);
      drawBody(joints);
      println(joints[KinectPV2.JointType_Head].getX(), 
        joints[KinectPV2.JointType_Head].getY(), 
        joints[KinectPV2.JointType_Head].getZ());
      //drawBody(joints);
    }
  }    
  text(frameRate, 50, 50);
}


void drawJoint(KJoint[] joints, int jointType) {
  pushMatrix();
  translate(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
}


//draw bone
void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
  line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
}