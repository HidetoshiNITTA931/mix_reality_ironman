import KinectPV2.*;
KinectPV2 kinect;

PImage img;

void setup() {
  size(1920, 1080, P3D);

  // kinect set up
  kinect = new KinectPV2(this);
  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);
  kinect.enableSkeleton3DMap(true);
  kinect.init();
}

void draw() {
  background(0);

  image(kinect.getColorImage(), 0, 0, width, height);

  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
  ArrayList<KSkeleton> skelton3d = kinect.getSkeleton3d();
  //individual JOINTS
  for (int i = 0; i < skeletonArray.size(); i++) {
    if (skeletonArray.size() != skelton3d.size()) {
      continue;
    }
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    KSkeleton skeleton2 = (KSkeleton) skelton3d.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();
      KJoint[] joints2 = skeleton2.getJoints();
      color col  = skeleton.getIndexColor();
      fill(col);
      stroke(col);
      drawBody(joints);
      drowArm(joints, joints2, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight);
      drowArm(joints, joints2, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight);
      drowIndirect(joints, joints2, KinectPV2.JointType_ElbowRight);
      
      drowArm(joints, joints2, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft);
      drowArm(joints, joints2, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft);
      drowIndirect(joints, joints2, KinectPV2.JointType_ElbowLeft);
    }
  }
}

void keyPressed() {
  if ( key == ' ' ) {
    save( "hoge.png" );
  }
}