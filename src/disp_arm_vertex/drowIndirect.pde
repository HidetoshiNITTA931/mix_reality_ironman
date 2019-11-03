void drowIndirect(KJoint[] joints, KJoint[] joints2, int point){
  pushMatrix();
  translate(joints[point].getX(), joints[point].getY(),joints2[point].getZ());
  lights();
  fill(#08FC11);
  stroke(#08FC11);
  sphere(50);
  popMatrix();
}