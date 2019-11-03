import KinectPV2.*;
KinectPV2 kinect;

PShape s;
PImage img;

void setup() {
  size(1920, 1080, P3D);

  // kinect set up
  kinect = new KinectPV2(this);
  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);
  kinect.enableSkeleton3DMap(true);
  kinect.init();

  // 3d model read
  img = loadImage("green.jpg");
  s = loadShape("test_arm.obj");
  s.setTexture(img);
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

      // 腕をプロット
      pushMatrix();
      translate(joints[KinectPV2.JointType_ElbowRight].getX(), 
        joints[KinectPV2.JointType_ElbowRight].getY(), 
        joints[KinectPV2.JointType_ElbowRight].getZ());

      float difX = joints2[KinectPV2.JointType_WristRight].getX() - joints2[KinectPV2.JointType_ElbowRight].getX();
      float difY = joints2[KinectPV2.JointType_WristRight].getY() - joints2[KinectPV2.JointType_ElbowRight].getY();
      float difZ = joints2[KinectPV2.JointType_WristRight].getZ() - joints2[KinectPV2.JointType_ElbowRight].getZ();

      // 座標軸をProcessingに変換
      difY = -difY;
      difZ = -difZ;
      println(difX, difY, difZ);

      // 座標軸をProcessingように変換
      float rr = sqrt(difX*difX + difY*difY + difZ*difZ);
      float sita = acos(difZ/rr);
      float fai = acos(difX/sqrt(difX*difX + difY*difY));

      // 極座標で回転
      if (difY > 0) {
        rotateZ(fai);
      } else {
        rotateZ(-fai);
      }
      rotateY(sita);

      strokeWeight(5); 
      stroke(255, 0, 0);
      line(0, 0, 0, 100, 0, 0);
      stroke(0, 255, 0);
      line(0, 0, 0, 0, 100, 0);
      stroke(0, 0, 255);
      line(0, 0, 0, 0, 0, 100);
      scale(2.5);
      shape(s, 0, 0);
      popMatrix();
    }
  }
  fill(255, 0, 0);
  text(frameRate, 50, 50);
}
//draw bone
void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
  line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
}