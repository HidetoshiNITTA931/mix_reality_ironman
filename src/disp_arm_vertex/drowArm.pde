void drowArm(KJoint[] joints, KJoint[] joints2, int start, int end) {
  /*
  joints  : Joints of skelton color map.
   joints2 : Joints of skelton 3d.
   */

  // 腕をプロット
  pushMatrix();
  translate(joints[start].getX(), 
    joints[start].getY(), 
    joints[start].getZ());

  float difX = joints2[end].getX() - joints2[start].getX();
  float difY = joints2[end].getY() - joints2[start].getY();
  float difZ = joints2[end].getZ() - joints2[start].getZ();

  // 座標軸をProcessingに変換
  difY = -difY;
  difZ = -difZ;

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

  // vertexを描画
  strokeWeight(5); 
  stroke(255, 0, 0);
  line(0, 0, 0, 200, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 200, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 200);

  float k = -50;
  float dist = 200;
  fill(#FC5508);
  stroke(0);
  for (int deg=0; deg < 360; deg=deg+30) {
    beginShape();
    vertex(k*cos(radians(deg+30)), k*sin(radians(deg+30)), 0);  //一点ずつ順番に座標を指定する
    vertex(k*cos(radians(deg)), k*sin(radians(deg)), 0);
    vertex(k*cos(radians(deg)), k*sin(radians(deg)), dist);
    vertex(k*cos(radians(deg+30)), k*sin(radians(deg+30)), dist);
    vertex(k*cos(radians(deg+30)), k*sin(radians(deg+30)), 0); 
    endShape();
  }
  popMatrix();
}